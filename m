Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4943FF60CE
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2026 06:26:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 667F810E86C;
	Tue, 31 Mar 2026 06:26:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nzVunjM8";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012002.outbound.protection.outlook.com [52.101.43.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B49EE10E86C
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 06:26:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qeSuYuBBHgAlFTTbo3wPoftyH8GvORSLlQZtwbP3iAqk7FSDDtf+n7R+kqgvDUAoauMCURZYfqlJseicpsXiwGLLRTNddsrnRvBhkAx15mF3xiC4GU0nZu46CW3Kb+zeY8j7L0VaKlnl+N3NPi+FPu3Oj4MggC7sB4JMATU3UoSAkAqRYv2FQAfuZMq2OQGDehNx4R3qC8eaWVy9PF5nadDVrmgEimY7fjFkYu5NWa0Ek6Q+vARlFhJ5KmWOQsfTgc11iufXqNasfvdAnLWn8XQjUrzPEVNUL31sh3QWhUATwGLp/yRFSETzarBegGF0rd8p6r8fPc834tzS+dVmOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnypG+hdrjERhVQ1ZeRxC1hFpyPVTW1noAGjV0ZN75Y=;
 b=KsyVXDX7aN7qF67GN2rVYrUruJNClf1oLH0o1ZYExy6yEfXr1SvjWTg1TW2KyVw4461Ci/NdX51NNrnqj0chRtkbdhal0EErbDoGTJ5pqVGZhet0I/yxr3Sacg9Divx19G6dw1C772jcX2Ao2YQJy7GW3me6q2KL0hTNcFJUEXF6iZa1CpYc9nmP3CHCUIUm5MbBYKydKgGXAp9c+lDfYZZ33J59AdxkT4AbDwhrQXAuQDa/0/eTMIhw5y60nob1S7FmrSHDfBw+CoyEzn0mGeD130QRwR6nWlZ9G4hiTAts5ks/eKu4EF4cIIHdcXs2HT+6yuCDAS+Md4l8zNPd1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnypG+hdrjERhVQ1ZeRxC1hFpyPVTW1noAGjV0ZN75Y=;
 b=nzVunjM80rk0p3xlJn908l4kb07cUHj2M3iNeSrIp7AFwcqsVXXI4Odk46MKFCJnRTdNSIp77FQblgeAAM8sWfzK3Mz/Sj7DMjdgeYQlN+5Be5UmPVawFMe6CGGYGVW+uMgDQZTmUbcDKSH+oniEsFOz6F1aKTEn+QQL1hLs0fw=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 SJ0PR12MB6990.namprd12.prod.outlook.com (2603:10b6:a03:449::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.15; Tue, 31 Mar 2026 06:26:18 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::6f14:4646:fb11:829]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::6f14:4646:fb11:829%3]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 06:26:18 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/3] drm/amd/pm: Add smu vram copy function
Thread-Topic: [PATCH 1/3] drm/amd/pm: Add smu vram copy function
Thread-Index: AQHcvb62088LfMKKxUmY9fowW++f87XIMsSw
Date: Tue, 31 Mar 2026 06:26:18 +0000
Message-ID: <DS7PR12MB60716E86B9BD960BB26874FA8E53A@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20260327075231.1413092-1-lijo.lazar@amd.com>
In-Reply-To: <20260327075231.1413092-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-31T06:25:12.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|SJ0PR12MB6990:EE_
x-ms-office365-filtering-correlation-id: 96cb529e-feb4-42f1-1f05-08de8eee6afe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: 2cYNL5BwkliV/GY5tEEABq9qCURKL25iF58cMao6rLdWV6M8ESgzl5cEGNTMfT/iPOLexpjZsKlHHgyPlaIXcJqbzxE9eJ5VqLX/8cxwTWpXDkMJaxrGoAHVuXJuyUPQ8FGV+/B7toyz7kiTyhdMcyrgbDam+aQ04isS8icjScdophGOIZ4qrzT6+pBk6oZLDwLKTlfl2tb8Vz1tZ2Z8cKnoPn47Rgt4XteyucpuAbKAGDhf0dZrKPzsTpwM7ou6L+lk0kpYAnzQ5dsGk4VMYTMeX+bvjr1L0KwBnkBTUWuDZl6AVpSf6saelLZnGDiTL3VSd11XpL2TnaaZc0ulcK1nxiyjuZuHk8bPosGSc8JvXdWa5gup+9kF2UOlhaFVLjSp3hI1LHhjZp8SeaecZHP1laslRUS788hFker9C0RXqZIwqt1IwdUmK1bK/G5h7CSlXhK5skqH5WDXj6gZ9U3vJCY9ygHUQ34XHvmhfR6ZKwL3q+iMy0kJrAnR3ubtfcy8Rwi6ws+4JyTzXS0SQxLSY3xNHyq0ZfbfqxfhmFYT/Y7vzMfDH6AbFvcHg2UOOeVKjA94PmoCOUxN+k75r5C6OZewW235BGVwskP2lOyPwz2Rz7kstoTCL4pmxf8dG+hx1f9aPlklHsYNU/EKbly3cNzUniE5bB13iL5IzOr/yRQbB7yaQ/n4lwl7YhEc7MtGKrg/geB+uapVxT0BMnUNIqNmYbVccn3dVL1s+diT0DIFAl86WQlVGjO2wqHrbSJtw3Z+4ff2RhUvd9W1EcWgDnfH2bqvk4qbQPC1cFA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TY3/78QTFlLJ8SoUVQN5YYidrSPHEUeMKioyIOTHZZm0190n/hEH+jMh6bFh?=
 =?us-ascii?Q?uAzfYYXYcwGqFekS4R4CYDouDyJdo5+U+DoOH5nG99m2elATiITYHFFUz6AS?=
 =?us-ascii?Q?ZJOljcPSiTh6N+ga1aBUyR/hckz55pts3kWLK4u+EeloJAowdkvpHNsOrNMA?=
 =?us-ascii?Q?7SoS8UhfCAaD2Ml67LOiAn7/vZDM+W36BH4abOzt6MLJJGE9J7wKMQDBDv61?=
 =?us-ascii?Q?spCAiY/60p0DjQZXPuMaqTHfPHXpa39geRIovMqu9QZWwlU0F2sb0Sm/wF1Y?=
 =?us-ascii?Q?eeMBMpDNCt/zK6PqQ5zawDLTbdrjZE36NcVTm5FRJcGFhEufwAz/Bk1ANkEj?=
 =?us-ascii?Q?QXk/hvy4ERfalYoQITDE44hd7/W1oD9cUL/52nAJqf52HKX/pu+FTwWxDBrW?=
 =?us-ascii?Q?9cPfRlZYwD0dQ2KRP77onaWmlHW8OIDweqBunN2ziwqQsLuXeJ3gHR8BKnbb?=
 =?us-ascii?Q?xRKxRbKpPnRZRCvwSAnSnthW+vURoG7TrySLwCCdGpELh3QYVFj+sAAevNZT?=
 =?us-ascii?Q?jSwz6pErLqOErWvLQxy43pL3L+eVFqLnSqnnrhkYj9r65EayR+dQACOiuk1S?=
 =?us-ascii?Q?XDtlTxVJ7H8M+fMwcMzu7Gr68rNp0s+XqW3uNXWyfee/48vvU4ML30Wjh3mc?=
 =?us-ascii?Q?yCKAZf+Vlj6HmBoSRsk+yCzIy2RQEZ4fUWp/fucS3ezEa4djmdFgp6clt3R/?=
 =?us-ascii?Q?6UHUcmETUAhbl+7zpZjmqGMsClIoxAyC5mBUgjN7nEaLCEbjUvoFOp1gj9fr?=
 =?us-ascii?Q?bOmE0ae2XKQGQ9A4mLMlhecET9IkO0FEfD+44L1WNeZP53XBMbNVi4QHvgS+?=
 =?us-ascii?Q?nDNiqK6QJgnrjYSWMYIw9PYEmgG7jtxxQyeayqi61B+Okch9eV7SytU2WGGv?=
 =?us-ascii?Q?4qPqUiF/sRH/RzgxY1PcP4JTmWgxRC1W4QEZIPla5eNp1uwXvd6voEQsVEfX?=
 =?us-ascii?Q?3ERLfNye6u0FNbvCb+zjl8E/kvmNxW6nC5riHF+I9qlKB86ljUyW8bfKRfkM?=
 =?us-ascii?Q?zQO8xFMb/lftofkcCmRKJXgJacUdOX5zRuFz7RN9qXo6pC79fvGV9ZwG4vUz?=
 =?us-ascii?Q?zo0LpmzifVE66xgR1JczHF2BcIWeYQrtpUB7ZGcIzset206MrC/aiDa1jFuh?=
 =?us-ascii?Q?RUAXKnUyR18mQBzLaYoUSGgepAqmQzvLbhh8Fv8gJN7DiJfM1Ps9qgITsXom?=
 =?us-ascii?Q?qN0HsVNb49HNU+FppKPw9H0dIqNEfUW6xkcuRdRE2jR/BANJ9RJlC8IyPIYA?=
 =?us-ascii?Q?0ejHi5BND8W1SNaoBl3f4+7DaVbSZpKrTvmHaJ9RRR9H61wgzTs8C6cj5S/i?=
 =?us-ascii?Q?mW7bClqZDIzi3BwmKHxYByX5XdpeyckfyNcVwV+5ZHIOURIyn8+uD8fNY7hW?=
 =?us-ascii?Q?nON5bN9ITBeA7qG+J5HzvF4hP5wEZdzAnyoxVx8CHe2/dnS1f0hQ0dja2hlH?=
 =?us-ascii?Q?oDUWOzTzbHcK8dDtZ7MABINi5Kk5R/cSXn0aTITPCm3TOp61jgrxbA4kBGHB?=
 =?us-ascii?Q?9/UL21lkbbcCLztozK9QtVbLaGJe630nEe6Jc4y0fDMQe+6XWFaeU5RkWOy/?=
 =?us-ascii?Q?+gCi+47fp+DWvq7MlnDEPV21n7V7+mO6MKfB+gPRFrXAG0wPgeRehVLA50Hi?=
 =?us-ascii?Q?ix+lsCJcy/r36ybX+clWgwDPJYFBgKrOIP+0pLZe5sAxiyZvX1YKtat7pniW?=
 =?us-ascii?Q?zc9dZzQ1TYnYG/sLoRwse8C2MKzmo2mfWxg/39FDIxgb8yOc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96cb529e-feb4-42f1-1f05-08de8eee6afe
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 06:26:18.1230 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cZys0O2AX4mI36lcUUcitnCMJG5wwZ+oEXXVN7AyF9Gyo0483R4roWiON30EIfOIiI8ZgDRG34uKpNQ19ULf5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6990
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - AMD Internal Distribution Only]

Just a typo in patch description

Add a wrapper functions->function


Series is

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, March 27, 2026 1:22 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH 1/3] drm/amd/pm: Add smu vram copy function

Add a wrapper functions for copying data/to from vram. This additionally ch=
ecks for any RAS fatal error. Copy cannot be trusted if any RAS fatal error=
 happened as VRAM becomes inaccessible.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 12 ++++++++++++  drivers/gpu/drm/=
amd/pm/swsmu/smu_cmn.h |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c
index 7bd8c435466a..006ef585a377 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -1104,6 +1104,18 @@ int smu_cmn_update_table(struct smu_context *smu,
        return 0;
 }

+int smu_cmn_vram_cpy(struct smu_context *smu, void *dst, const void *src,
+                    size_t len)
+{
+       memcpy(dst, src, len);
+
+       /* Don't trust the copy operation if RAS fatal error happened. */
+       if (amdgpu_ras_get_fed_status(smu->adev))
+               return -EHWPOISON;
+
+       return 0;
+}
+
 int smu_cmn_write_watermarks_table(struct smu_context *smu)  {
        void *watermarks_table =3D smu->smu_table.watermarks_table; diff --=
git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu=
/smu_cmn.h
index b76e86df5da7..d129907535bd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -174,6 +174,9 @@ int smu_cmn_update_table(struct smu_context *smu,
                         void *table_data,
                         bool drv2smu);

+int smu_cmn_vram_cpy(struct smu_context *smu, void *dst,
+                    const void *src, size_t len);
+
 int smu_cmn_write_watermarks_table(struct smu_context *smu);

 int smu_cmn_write_pptable(struct smu_context *smu);
--
2.49.0

