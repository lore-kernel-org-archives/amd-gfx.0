Return-Path: <SRS0=wnxc=QD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC604C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Nov 2021 07:40:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7DE0619EC
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Nov 2021 07:40:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B7DE0619EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 420C76EE12;
	Tue, 16 Nov 2021 07:40:08 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E81BB6EE12
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Nov 2021 07:40:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2uae4n46qWPK7UzOKLewfOEYsuAZaIP209Q/Lpqih8Dx9WhECVrj36OQsRaCEbc20E8nxDINpUTxuPBgk1bXi2531aOXlu1hFdC+J1QnmivVNkJmvRgSksOH12yKF0b+MApOjOERefs20vZsOmd2imjsWn7DB3S3yZQtBvtoiQnvR5tvHwGa437czGI6pKK+sJiritIZvuY61w6unjOLhf/0lVIWfgQ6AeQuN3KJPjsyFF+RNOw3Xzv6D2wm1xBZd9bWUk0AwFiNAKBGV7ycT2vIOHcSjlyh8RSFYXL7N8W3ykq9loaJpo/fvGsx1dOqXBNMXMJSfy1qWRbITzYdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwqDPp5V0rMxH9C7bGs90omIJQUI4JhMTjQ0dqovlFY=;
 b=eSQY5Y+hSWtmfzjHAgJkYh4syFg28ddjPKtDgYq0oqbMk9rnsAkakNxlvfBUHC83mDaiV/rbVVegdoaT2MpPRvmzPZvIpTPGqvIiXGyf6vlaHzyC7nImtFBf2kIggYAzfBW3+/AS7xJCeBEXcSucDAynDZtn7qUPEPifMFGHrxT4tnRwbv5v8dP5gGdLU1lMO7Ut52jLJOEcCAtl2tMwbYzHb1pRW5ZxBE/sZ0hlKPQvvr7uaGGmlh6btunM2ReFQAaTd/nPqHpDXcgr4Na69t5lc1jOeZr50EkbOoUfIf4AorsK2f6Rdx9tU8DdUBlP9wiKUze8lQSUneE/SqsQkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwqDPp5V0rMxH9C7bGs90omIJQUI4JhMTjQ0dqovlFY=;
 b=J53Q6K7FenY0Qx9F3cUj2tgBzmfw+s2hhl7hf9v7gyIgoGQ5RscoKOwTxt7asmlAqpO66hRfB7u39cLwG04ci6vnKA6h6sb19pJu7B0qRZztzt46emXVoUGn6L9LmW3/9v5BjKbvmLx1RSwYojs0lUU8rcduQwG3letw1CpEeZ4=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.25; Tue, 16 Nov
 2021 07:40:04 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::2919:f0f6:40a9:e1c0]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::2919:f0f6:40a9:e1c0%6]) with mapi id 15.20.4669.015; Tue, 16 Nov 2021
 07:40:04 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Clements, John" <John.Clements@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>
Subject: RE: [PATCH] drm/amdgpu: support new mode-1 reset interface
Thread-Topic: [PATCH] drm/amdgpu: support new mode-1 reset interface
Thread-Index: AQHX2rrnWDKhUA27D0WUm65WJ6P/FqwFwwxg
Date: Tue, 16 Nov 2021 07:40:03 +0000
Message-ID: <BN9PR12MB5257ECCA86BFE48331E6FD53FC999@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20211116072337.29600-1-tao.zhou1@amd.com>
In-Reply-To: <20211116072337.29600-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-16T07:40:01Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=d7687e18-9023-43d8-abda-dfe264b94665;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 452ea5ec-4959-419f-9789-08d9a8d44dba
x-ms-traffictypediagnostic: BN9PR12MB5115:
x-microsoft-antispam-prvs: <BN9PR12MB5115A2790E9C13B499243F4AFC999@BN9PR12MB5115.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LmJze0V84MCyKMkxA8Mo9AdYpuK5m8ZWOwwZayOw+VOH4hRKEWbp0R1GpT14RXN5RPLrPLReMaYib5uKDMOqesxcDSdG9Nw/+YxT1+ILbiBulgJYzAwpyuTUKuKWxdpPbqKuEkLlWI9/1ZY97e40WgFnTT4sH0iJX4+KzXroCDrxXph0eLE7IhPnAHIND4Qig08SjeudbJXyDQny4vG1ptYM5GJpMNCvyX07OU66YC7Ymfmehbv/ju1l8oOP73E1jLJYm+sE4ieY9hI7yhC+3iwMNkG7noV2m63yGHNIx1k9oD5dJuIyUoVh5E7zQyCFKLD0ReYb7Imx6RuZCjBqRgjCbyvFqHgRmgFEsrD+sO7vU+I5fkP1EE5mx0TDrtt82vynAk//v6+e6UWLpfneqGFTAPTQ4VtWx18IrbwDcnC5dkU2B4JBMa9zFs6tnJYO+sZGqTZNvDZYLw3eW5PP2cROFjTBUIdb3eJYpt2GBCgvyJUW3cVZiNNmo8bEkEQC/OPDPjyU2E4IBwgjFo+YRlfQEnKtLLMP2NpzTZDJeXAg2J2Mj89BQm4UJtwYfrg3k5SC53Jry+PRJlZ4U3pawIHOwTcI2qIX+kcSr+s+zGc0123iB14fL5UMLtlrY1i7A5axT5k66x+qK3YIiFKa68gj/8WHZf8T5gsZdTfcjq4g+y6satl1Q9R15Fne/MVpAhVo1Gm0xTB3SAmz8fFcWA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6506007)(38070700005)(55016002)(122000001)(33656002)(86362001)(5660300002)(9686003)(8936002)(66556008)(110136005)(6636002)(186003)(76116006)(508600001)(38100700002)(71200400001)(52536014)(7696005)(66476007)(316002)(83380400001)(26005)(53546011)(2906002)(8676002)(64756008)(66446008)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZXA0jGJyO3XpqBXByncwLRFKQ2D+pdpcdym+dA8a70SL+KUW64Pa0ZF2lfQD?=
 =?us-ascii?Q?i2VaLFd3rAlUGF9lTMtpQMwzMTDUs1DIZoPu1bcmxvuYy6UayMMgvQoWHjDu?=
 =?us-ascii?Q?O8EgpxRlu2DYs+v/C39kqH7KzyQsow5nAIVkhB+DAYZJ/4zmBaONNqLoU6Ip?=
 =?us-ascii?Q?vko8bCbg2qe+K2Ich+jD7SKDYj7jHCHnzPx4BbbfqrUn2juEEfGza5bBZDhA?=
 =?us-ascii?Q?YT2zWOTagsb1kxCTsuU1cXJAOkrEANuTDImmchyUJPmkLKc/bNysRncX2X/V?=
 =?us-ascii?Q?539GOwtqutT19+TdT6cC2ujC3Bd/6KHaJ28JMMgQjgS2suew4pKr4nGx1yVL?=
 =?us-ascii?Q?BPJb1J12At622Q4e01yeiA3/+3LODjVeehMEr/P13iGvwTp5Ix1u9xSNWdRZ?=
 =?us-ascii?Q?KB1XOnZcKfFxxmZNsaDsA+SK1kPA6QrKDmF+3RiNFG+Rs6g7DGpnkNxDfseg?=
 =?us-ascii?Q?FL3cyZwPJzWwbwCSTHip8vc5TG8fHekWDaABZby7rDKtpJzulkb1WxgMb32E?=
 =?us-ascii?Q?8ti08g9oPdDjRwGK+g6VciQwIqwMqzsKysMNDaO8GfUvn9QfxGOCojVp0OjZ?=
 =?us-ascii?Q?YuhRFdgUDQqGDy2fnHQXX/Kv2aYBQ1yGp/IUX/n9QiOSZLjGKMu+Nl1HC4hM?=
 =?us-ascii?Q?obvU5ZwtXDpo+PrKif97L0ZsLC5NBld7y/W9TrZ68SEVbOEiOQSgpNwUusN7?=
 =?us-ascii?Q?ZA7ynQoONfSHP5mZoZi+8s2NqXLLDti9bqZQOnQtxJV+oE3lSkjfEvc/Aa5J?=
 =?us-ascii?Q?ZglIVYyPdxBUoXc4y9otfF4ecUN21lpdojpit1uP0qUSkwGtucO2sfR9ezi5?=
 =?us-ascii?Q?vGw9zE4ISc8G5rmz96iKACZcUYetA9MrN3QFKWIuhIGvSKIAAVvua1sD4zAD?=
 =?us-ascii?Q?zLPQuEPFe6Dk4xuIj2kUx2E18jFPb7tscUAR+TTdjj6/pRYFihlfb3Tr8Cs0?=
 =?us-ascii?Q?3YGRIueiuoRwB4qkvoXT7OmfS7dzRSAAQtDEgrJ3PQBLu/UlFEFhQ7r9B9mh?=
 =?us-ascii?Q?V9X4xHT3YU+J66WjDUmqNCIMDTLOliCauNuS/+qHd3g8R3dhcU6/4A/I9F/L?=
 =?us-ascii?Q?Ls9Uaro7U/zAsKybCGiQdcXkGoqAXVnBcpJkUCm9SSr1sVPVaxwb4zhqa5Bu?=
 =?us-ascii?Q?jj/TlUJksybU3H9z5DbqGSydD8ihQ1pQk1DxARxe9/eSnMkKtAJNEIhQJHlB?=
 =?us-ascii?Q?bwcfKjpxFoDoheLgn3/fF3DQz2sq+ioF89L9GAk6lvgeqJyRguqm4wVRlCI/?=
 =?us-ascii?Q?BgGeyZZmSW33V8u+IKj7gIv27Y9LDloxogRh5k+nOEbYApF6rLmYBVn4ls1A?=
 =?us-ascii?Q?FQDK25phP7X5MScjx/QvsEcgpyS9J2tr7+P0kBSEzaD8IC2tKe6utdJqpgxH?=
 =?us-ascii?Q?fz0YfxR+TGCEhNAwdUsYk1eSOpCWyZMvUpGIi2f8wGWj9BuHyPFK0Jc7JLoQ?=
 =?us-ascii?Q?j0uFyhpbMRBO+CX5bNvRGu9Lqtti7Z9KCgEhcuIFm1jvEtxTdEucssar5Hrf?=
 =?us-ascii?Q?S+VbDBznBq8ReBjA/zjAxj7NFSTUtEvJaYOSIxRHA1kBH0cS2vUz0vzFVxE+?=
 =?us-ascii?Q?FhawJ/zVw/kQevKrdOd32ifO0w9odCJPuOgA5FA3OxgX9szHvwN+lOYC0wJg?=
 =?us-ascii?Q?8Nv0RM1eu5cIUcVfc6ALHTI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 452ea5ec-4959-419f-9789-08d9a8d44dba
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2021 07:40:03.8769 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: npCINcmZ2n/iwPRtnpz94nJFbmPb9FN8a4JyFZhOTDGp2DXX/EwXRNIHc2RUJUoEwqLGtb1UEvN89WImX0Vjvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5115
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

[AMD Official Use Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>=20
Sent: Tuesday, November 16, 2021 15:24
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Clements, John <John.Clements@amd.com>; Yang, Stanley <Stanley.Yang@amd.com=
>; Quan, Evan <Evan.Quan@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: support new mode-1 reset interface

If gpu reset is triggered by ras fatal error, tell it to smu in mode-1 rese=
t message.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 21 ++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index 35145db6eedf..6f3d064a8232 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1426,16 +1426,31 @@ int smu_v13_0_set_azalia_d3_pme(struct smu_context =
*smu)
=20
 int smu_v13_0_mode1_reset(struct smu_context *smu)  {
-	u32 smu_version;
+	u32 smu_version, fatal_err, param;
 	int ret =3D 0;
+	struct amdgpu_device *adev =3D smu->adev;
+	struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
+
+	fatal_err =3D 0;
+	param =3D SMU_RESET_MODE_1;
+
 	/*
 	* PM FW support SMU_MSG_GfxDeviceDriverReset from 68.07
 	*/
 	smu_cmn_get_smc_version(smu, NULL, &smu_version);
 	if (smu_version < 0x00440700)
 		ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_Mode1Reset, NULL);
-	else
-		ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GfxDeviceDriverRese=
t, SMU_RESET_MODE_1, NULL);
+	else {
+		/* fatal error triggered by ras, PMFW supports the flag
+		   from 68.44.0 */
+		if ((smu_version >=3D 0x00442c00) && ras &&
+		    atomic_read(&ras->in_recovery))
+			fatal_err =3D 1;
+
+		param |=3D (fatal_err << 16);
+		ret =3D smu_cmn_send_smc_msg_with_param(smu,
+					SMU_MSG_GfxDeviceDriverReset, param, NULL);
+	}
=20
 	if (!ret)
 		msleep(SMU13_MODE1_RESET_WAIT_TIME_IN_MS);
--
2.17.1
