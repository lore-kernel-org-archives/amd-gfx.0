Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82294CD6E7C
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 18:22:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B99E10E6FA;
	Fri,  5 Jun 2026 18:22:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qnE88wIk";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011032.outbound.protection.outlook.com
 [40.93.194.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D8B410E6FA
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 18:22:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EQh/xzM+VTdrYN0NqTY/y57IwBSLeEu7p9HrUe4+9nIyQuThon3tHMl0TJaozI4u9oH8kqH8UnSTagLPXEHCoooQudb+2nkaaL2+NahVkpiL40ow+CIvCQ7nySuT4kRiGSooZqss2ck8pz3DqAfto+vIyPmg1BbWm9f8FCq4/T9yRbPXqoliN7G/EZ00nR3+HTsesoLJnWg9bWVrj48uGi6hhutfWFOhTETImsJWJfxtAqbutFRVuhLe+9dOwg+ooHiIob+28EDfMGVUAIzM5VjQpdRdW3+/Et1aVqnpoKrB5kdeU2AFkdGS/dvAI8FnqGK98iBLF7YvqQ78rELEGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1V84fOvZWlnZK7ajLJHXxR/1YIpGZtU49oRNwuEtMQ=;
 b=wRwv2Iv6j7IB4nKPwm2yEt1yD6EjDtats0GN0nDcvQ9b2/DaQsKJltq/2MHFMtfoSW26tfA+pAj/erHdfS+41dtiNX15gVVUOufa+B8VEij+hhMdtSSSpdLsu/WypRkHxPM0Qcma4yN8AzAyPoBI9K4JS3sA/lYSRO3VaASNCjdFwlsUakkvHcNSHFQC8lki/gKeGRE0DabeFEf+x7Epwj6f5F+e5sccHIOGHPwZr+nrjNDd1cGhNpwPM9mabMp35awdKVqgaaNOZYx+mV1myRxLDAQWSOcsrtvYLPKopb3xtqul1478F6SIdoD6CyhIq5/+/hovpVqtouuQ4c2B/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1V84fOvZWlnZK7ajLJHXxR/1YIpGZtU49oRNwuEtMQ=;
 b=qnE88wIkuVTO/lNerg7HQOAwPH8wFYyFDfJjoAqeMZ95vfQ4fCC7Q73pr7lvfXdlvnh+A+mOUtxGEsVBABzbywv8ozOH0r2c2JUdhCXZS5oD39Zo0qUnF/5bWcqtyww60RC/fmy66weMcs+y5rO6bv6QDYdNoJ3aqRX50hmQC7U=
Received: from SA1PR12MB8144.namprd12.prod.outlook.com (2603:10b6:806:337::15)
 by DM6PR12MB4169.namprd12.prod.outlook.com (2603:10b6:5:215::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 18:22:21 +0000
Received: from SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec]) by SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec%7]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 18:22:21 +0000
From: "Francis, David" <David.Francis@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/3] drm/amdkfd: Extend MQDs in HBM to gfx942
Thread-Topic: [PATCH 2/3] drm/amdkfd: Extend MQDs in HBM to gfx942
Thread-Index: AQHc81zSsVGCZxZiJE+HnbbzT/4927YwSagW
Date: Fri, 5 Jun 2026 18:22:21 +0000
Message-ID: <SA1PR12MB8144E943A609525DAA1786C3EF112@SA1PR12MB8144.namprd12.prod.outlook.com>
References: <20260603132740.180346-1-kent.russell@amd.com>
 <20260603132740.180346-2-kent.russell@amd.com>
In-Reply-To: <20260603132740.180346-2-kent.russell@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-05T18:22:20.894Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8144:EE_|DM6PR12MB4169:EE_
x-ms-office365-filtering-correlation-id: 2330dcdb-a0f9-437d-bfce-08dec32f6275
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|18002099003|22082099003|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info: +/eLtG17zkSj0qD/FEZFenHZ8iwDC6pnPfyToOtz5oD88uJ9IsKokToKGwgh9hshauP8QSj0TEShyCpKqJyXkTiHr2XKNpXXjfvuZop5f9pBZochY2Duge1mkmhlZXY/s16+O/Uj/OOuWDQyz4Ac8c1AYZkrfQO2uZug/VqZbdJn464p75lCLocyjXg6b+8uRAJQO5zD0Ones1bSID2h4aL4z0g3IR6zPJptZ8fBq7nmFNBapZz+7sqk0YMVKaNx1y0ikoe3gs1gsppvKb8WCsPrfTuD4o1v4jM7Is2A7ufhAjgG0awV/rMEpSr8COtc0UfuXdg3m8yNMFXgdFt4fIEytrTcYEf4UIkvQbgJEksTES9oyYy6TPnOtqdObKmuS3ADeJzUhU+r/KuWsfxHEno5mEYSRpJ6D5mtUG6DcHjB3adua7mlCefIq+rnmdkGsPgjW70h4F7YnrC9THV9iEOJGPjtie3NMLGmlrFPtmt9H/Z6xHIGIXDC6/zNT+/ypaANDjn7hkaormyjm6+VK42IKqdlELP7i4R5GgkHG9MtF45POMI8aJpTlW+g7yB3O4qVeiP8ju0ACgJryYQTGoVeARSUnVGp7Ro44Kd9OEZv9Bynvbu2ukDFGyUosqN6riK8QFta3E9/SZ7w965wj1f5qXT8ckl7qvdvoiUek+AaD1ZONM9rG5yzpuHOhuqPOIGKuXw1hO9EIH7dgWI5DTyH4zSt/CosRIp4AYdi+pNVhCzhNeqVKHfFqiv5wDzs
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RxnVnxRvCaXPacVKZ4ybDolghXjrd8aG0FX+pZI6YnEuhvUOEI+9Q1PvN185?=
 =?us-ascii?Q?YEuD0GvDgx0xheXzUVr+a5UaNQrNK3voh+QBvJGE6ZJpJnKcufdqFbOd5xUB?=
 =?us-ascii?Q?Y6PhsF9b+Cal1sHKyom4Bt9DNI0kK7KtdOEWRPv9+n3Dekr4ELJnakxTLp6S?=
 =?us-ascii?Q?7pp2OuQi/dZmD0AlMFeSvGN4EDO+2W8VzMNWZAZRHegPTCAGTLwYMOwSgGz/?=
 =?us-ascii?Q?oeaKBuhAkODpr8/VKaZRSYVjOm/bG2WUlp8b1OojZ+WbIlq54lqcKtnmu+mV?=
 =?us-ascii?Q?OAJ2oiQP8Go9YRpmAnW/ZyMDY8Nejg71IiFSLFK0Gk98BON0RXGnX+6lPj93?=
 =?us-ascii?Q?NxfpxVXOEI8s9M+hB15BZUKEshGY0SJt1A41CP90YxiUD3P5MqClVEDzE3xm?=
 =?us-ascii?Q?/AATVynYOoGoRVr0lb0Yyw1Hh9aey0DNLDMc3F6EzxpgQBcbgYqCAyIOP6SA?=
 =?us-ascii?Q?nZYB38sMuMqMuM4PTHSVld4DYPv08nrFR+/GloVU+4C//2BdQysf/1Qx7cPV?=
 =?us-ascii?Q?g90CBRBZbDLHjEw0BcAKLIra/MxIzfj0WcbyU9Xtvz7ddms5SIrqKy4IVl8w?=
 =?us-ascii?Q?fqRWymhXUQX7MnBk6rclS63XYgX1KrqSmgAF24ZYd7wrO8e2QPwkjg2n+Cch?=
 =?us-ascii?Q?PM0J0kwtEBkr9euzdtg3yQFxduCHZjBYL3piI5IXrds2QZgm/w5nCqtX+LMf?=
 =?us-ascii?Q?bhtXmjUorBmCLjJ/IXbgcj8jTg4Sa9pmEI5Z43y1D4bO0Y4e9RIaZMvz+bWD?=
 =?us-ascii?Q?SAPZoIyO8akNwjhEY2Bb86iP9kJpIBALxKpDk8HJ1k8alqdaOlHZo53QFHzT?=
 =?us-ascii?Q?B/HmQ3+CFzuXWv+DDK2Gbb/h96jnLtmibE5W+HU6pjQzgXgG1tzwoQB7xEaZ?=
 =?us-ascii?Q?NvpxneWOPEOrRERAhdZ59ACtzH6RN2ofcfxyIdKPVoMii3kkcCfgkrapH+tB?=
 =?us-ascii?Q?rEWmjJSpIu3kbYKItydXIGLutg2aGDqH6Qzeo9c5h+2rzC2dMvieV/LSMEVg?=
 =?us-ascii?Q?aetimSTPVmIWd2h9A+0ddi8+A5t92Hnp+1nnJWOo2kwuSfkp878xtSCGB3jJ?=
 =?us-ascii?Q?VJNGM7OfENEa6T3X2f4+yeEjmnXhEX/da/fBrSerqFVyW4vapZNtJqHBNniu?=
 =?us-ascii?Q?C+2PI5acM77RplcRbFcnBsuQsIFMPfbC+cyDdhWksQI/S9fFyKkvPThX8jb4?=
 =?us-ascii?Q?uXObQWc+vTtBa/wwVoehPZZxvrBjtN7ND/rX9jW1/GupHqcuKpAMLNVYdnuQ?=
 =?us-ascii?Q?3F76eEEp6ryQHDddx/qQ7iyeLZBqZkjAet/2r8FUVFjp6AfTSNzAatIpFtjk?=
 =?us-ascii?Q?gYYVAVGk3343bm7GlR2jbrDXHPorkKk1+B//YbRsV9TZ9QuYQYGS6pfIKBvd?=
 =?us-ascii?Q?eeo7I4ZaWW8PPpawC5TMKSz6JcevRJ3sfA/mHdzGHXHUN4mfMOwI0odpuAy+?=
 =?us-ascii?Q?IpjF/4MosfIWwaKgefkFu9Gx808OGXUKD3u2jljk85BZDtObfQDkctKU6FZV?=
 =?us-ascii?Q?XIv2WtHFCVMNEm4/3pFJ5rcoVXeU2xIcdCCoCggv5NpMapDw5L287W1vAV4v?=
 =?us-ascii?Q?vh2u8djml5X7WIYllCBRjk9J3hEuXZkXKv2dRUQBpn18M26tehrI4TK8c4Zf?=
 =?us-ascii?Q?Xp8tCuzKmG6j6guZhJ75HhHBPhtzMxS4bhzipdMDUzgPNCz+xcL7vtFBbC7E?=
 =?us-ascii?Q?VREOlHySBMVu4TK9ArDa8XbmpDRzVx7+HKg4YNQj3Cc1wjtT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2330dcdb-a0f9-437d-bfce-08dec32f6275
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 18:22:21.5011 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aYaSNCLbmUFZtWo8Lsxo3LUkcdGsF3Wzj8Ow9lo04d2fs699pWGCCWsJfdUanFKw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4169
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


Simple change, makes sense

Change is

Reviewed-by: David Francis <David.Francis@amd.com>

________________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Kent Rus=
sell <kent.russell@amd.com>
Sent: Wednesday, June 3, 2026 9:27 AM
To: amd-gfx@lists.freedesktop.org
Cc: Russell, Kent
Subject: [PATCH 2/3] drm/amdkfd: Extend MQDs in HBM to gfx942

This has proven stable and performant on gfx943 and gfx950, so extend
it to the Aldebaran/gfx942 series

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm=
/amd/amdkfd/kfd_mqd_manager.c
index 02b52f907f80..5970a1694286 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
@@ -322,6 +322,7 @@ bool mqd_on_vram(struct amdgpu_device *adev)
                return false;

        switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+       case IP_VERSION(9, 4, 2):
        case IP_VERSION(9, 4, 3):
        case IP_VERSION(9, 5, 0):
                return true;
--
2.43.0

