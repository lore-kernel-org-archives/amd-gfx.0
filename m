Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95360C07545
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Oct 2023 16:42:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A0DE10E429;
	Tue, 24 Oct 2023 16:42:29 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEB6810E429
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Oct 2023 16:42:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8Dy+iUlmf+2Il5/EtxGrL/NjN3XmwZ0InEHLRvI7HjQajVLhFhEBdXhJuwYloy/tbVuSrtsb7VN6kZJX+tLL0A1vHqryT6u3pBn0c3oIV4iP6xx7MPjlzkfynLAgeftW/i3NY1yUN00hwpijU6Lf4Fd4IJjwqd3ku733yLf7Ec0MzQjLvMtAl2dmiA58onc6VboMq+QmcNX4bI1QKb680ws1FGcqVYsiTFMLIyZRgmXceGgyARCNCW6yGKlzCTnhkHxbsCmG5zM1ylKqlBLVwtOg/vSITk1VK9kcsF3KFqjIzoz86tYRkCzkvlp/Z0LzTNMXUFy1a8UwSXe9/JLeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3HeDe6/d7wxtiF15A+iLkvu8QudKPwMxQjma0mHBle0=;
 b=RyXhgKk5cEd4S72ubsPODcq4yrWXc/uMYwVrz3PClg0Lryf1qVdSP3z4qn5d2F652O5Sl02U+gekDbKr+BMo61M/go574nBVMMF1mftWWBbG0WLNgnbSJ2FyanuQorwIdkYcDvp1f/FZLBf3xl9jobFTTb2sO3+SbXNXsL2jKk24jrA/LCIceu3GOTcTp1YhZmqGi6Cg6Nj6IFn2FxBlA+ey48nv+fviIXsLbdPqwW/fi611DlowyRD61K+mnsdMtgWX2+iYDu3M1Gar2LiWznF7jLmsS06efL64J/N9nYmRm9BpuCwUV/3eQPROcBR+1KTRcMidBcU1kgiY58N0UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HeDe6/d7wxtiF15A+iLkvu8QudKPwMxQjma0mHBle0=;
 b=A48hxGPKJgrCHE+/W8iQVxj2PjeBlYd1n9yHHigfxNbz1ax6CqYmwp6w0TSJGHZigRw4R/ZxWjxCkEajquzRDHXyT96Qdj+JV7H1Vj7wOzx6Iu5AzhGeHe526VFRocl/3umgEbSbjIfzpDvOojEi0Te67a76osvpqDvN7rU5tuM=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CH0PR12MB5058.namprd12.prod.outlook.com (2603:10b6:610:e1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Tue, 24 Oct
 2023 16:42:21 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a990:2836:75d1:148]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a990:2836:75d1:148%3]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 16:42:20 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: call smu_cmn_get_smc_version in
 is_mode1_reset_supported.
Thread-Topic: [PATCH] drm/amd/pm: call smu_cmn_get_smc_version in
 is_mode1_reset_supported.
Thread-Index: AQHaBn/RGZl/JNAP7kqi5IILkDb9KrBZJQV9
Date: Tue, 24 Oct 2023 16:42:20 +0000
Message-ID: <BL1PR12MB5144EE9831D30CB82829EC09F7DFA@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20231024134124.1601125-1-yifan1.zhang@amd.com>
In-Reply-To: <20231024134124.1601125-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-10-24T16:42:17.889Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|CH0PR12MB5058:EE_
x-ms-office365-filtering-correlation-id: c14e43e0-e64f-4d40-37f9-08dbd4b0312c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e/JoDCizcWvEhnmwJBYN219BMmf+V5zJ9CqF2BWhRJA6nBLDtOph8rQZWxKU3VVySjRZE5bWrBUA7+rW4W7/f3PD5V+V5YdHtXT1wECXPVk0P1OnQUaaQs6R25xsbQ/dWIOixRAcU+YcDYXuWU1LNfQeve/fwFNpOV2c5WOLsz06/QHPXIENwFIi9L6bjP/Qq80MSNkixg8sh7Zg7KeJ3Ni011n/dAAy5xXpO2mRa5IfI6w67NC0SH+Ivo0RNYuA9A+g2I8dZJD/94BxYJnprsWtgjxdFPUihhdZa+aic94na2LcTo0Q6U+VnfjKVt/g6ta4xFavAkNK5h6CGJMrmvznL2aqvKSMVfAdAMCgIoUcjRJgEGjXEqbOEkrApv/b0GF1jzNp/V/eddhfSsVhtKA+8C/05KceGRJ520X8MoVuNhS96EtHSRbmHrs9Ht5Rx4t8L/ORyJfUMUJUuNuomjv15wncsmkMEJYmcLPYX58TAAUxRhXzjXyIwBHv2bJuKVxbvIUWlNjcKCq53W29Cx0DAo+fP23Vz2T3QoTQSwCVrSpxPkDHl1AEUpXFNV5qQ/j34uGJj1t7HrDGTfoPpcQVR53cbUm4i1Z/mF0eUP/plpEO7Gdmv9i8k89gM9EB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(346002)(376002)(39860400002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(4326008)(8676002)(8936002)(52536014)(55016003)(53546011)(6506007)(9686003)(71200400001)(26005)(7696005)(86362001)(64756008)(54906003)(66446008)(76116006)(110136005)(66476007)(66556008)(66946007)(316002)(33656002)(478600001)(122000001)(38100700002)(83380400001)(38070700009)(5660300002)(2906002)(19627405001)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vmcwadN2Hp60tN+rGJQWdayfl92U7s+t3RcigYjkcUTkT53vJne9+P/VrDJ/?=
 =?us-ascii?Q?J2TnmchV8PTzDgAq5Zps61g9ZkmyMtx7+khmqVA+0hID1vSRa8EHqQEAviOU?=
 =?us-ascii?Q?MBDafTAzWx2mnAVXfw+gu3Ks5jIeWQXk/yfe9kb1pYt3jvH9g9gxD5SKpXwH?=
 =?us-ascii?Q?y+gOlHdIlNiYaCy7lg0HWs+TE5+BB4vbDCW4zKT2s8/VZpI1w3rjxkb+XQfv?=
 =?us-ascii?Q?L500Kjcf7qvYtv/daBsydjBXYkp+v/qFseXjemU9xQbXgmFAiNWyqXuwEirY?=
 =?us-ascii?Q?dMIEmjZVPOK45J5XV6C798beo1QAuAO6uTBUfJz45pyBZuvjTz2Ei31WhIjw?=
 =?us-ascii?Q?oEi93rCZnu1+/55LVkqlbFfWi/J6U+Wj5bvq1Y02qlGejQjZVOmQ/z1o1w4h?=
 =?us-ascii?Q?v8AdojeQnPYe2x4MDnBOf/J+BGdVZOzGkt0llKFInNTFQrbtti1S8+w96J31?=
 =?us-ascii?Q?xmEYKNBgN+ueiARiKPaxTa8vOmqjphafuBIPbwKj71ElOtxxYOasUdx0jLc4?=
 =?us-ascii?Q?//HH79FBNq64QIEnfZQQGErJ2oBsKY4fxfxf6+OX+AZwDhbFb6t08CPkCvpC?=
 =?us-ascii?Q?H0DRifVAm5wJ01KkaRj7AvyyWqqIHDcfGdxH3rGw5saGiJvKzAcGZdBhzkvy?=
 =?us-ascii?Q?qTWC4Xm7WeY4H6qFQ92cP6729SDbcT7+1TwRytK0/K41OWOA5AgVAYVQrTGB?=
 =?us-ascii?Q?/QbPDSPEK3jgQNK4QjSOHfaGDfTNNF1hl6E3tcKJ/QT979dvKnk9NHAWUwM6?=
 =?us-ascii?Q?eKhBrZ8O+KJuHdWpHs6I18CHxUm6Y5+fJNn+lVOwzglHkXnJnTBwtZfVDRfg?=
 =?us-ascii?Q?4HnLOvuTWkWqKtFCMgETHdJcwU5KMm78IqI8Lr0B6dQWvZvuOYuot+epAepC?=
 =?us-ascii?Q?+2kYvot0vKKJZTEJuNkajLFUJ6/60GDUTzYguahe+SaerdU07I8Bsxqc8pmU?=
 =?us-ascii?Q?5fx7ZhtqC5T57FuAFgVAJJg2ClHAE62OSI3W3PniZaiW/jPdmQSQyywQCrFl?=
 =?us-ascii?Q?qw2MKWnNh07V4tJeWWv8DhnHPqdGpyPGpDMtPzmGqkXFjMS5hrGNORbtTmEK?=
 =?us-ascii?Q?PiWEtQ+FblrWJJemchUcdVFAF0EK2+tV9mZ54jNsAjmBGrhrDwlF1Q5dq/81?=
 =?us-ascii?Q?rMa3Ad72kviu/2vXQcznBn6mVcsQnT2k4pWa3SqPjmJE8DlzyGdXkjwODHIT?=
 =?us-ascii?Q?+38wFfdz6z9oLs3FjQeQWUoX98cHEpjey1Vu0cu8foXlArRXAq6Cqi4CISCk?=
 =?us-ascii?Q?ui0CASuwjVIxCKfKfnZGO+zNYOa+DbRWfa1zqlSEBBOzy13eDuUSwR1DiFWa?=
 =?us-ascii?Q?vby7V0QiuULm6dZoYXYsBKl4hwCeQT8AVu4pYuasY9Lh+pM0+X+AsoMFwIf8?=
 =?us-ascii?Q?ySAkcpGDQbFxZz85xA4YHonffeCl3wta7tj3EBarVSQeRJn61j+6Dj8uOzej?=
 =?us-ascii?Q?6Gs+KwSsrrS+F12UimTUy3nqF8NT3HpJTQA7nmGBHhm3bqJERLs7lwgdUyrr?=
 =?us-ascii?Q?1wolQjA5RUssSK+qndXSn0Z2eptaOdxqSppWGqJPFUID7y3L/fwtOyZa3To5?=
 =?us-ascii?Q?fjJjsVb43bN7QXyW3O4=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144EE9831D30CB82829EC09F7DFABL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c14e43e0-e64f-4d40-37f9-08dbd4b0312c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 16:42:20.7090 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uqffnQJQcUgeCF97V8Vj1IqmcxXIPNgeKKHcdcDFc+4ZoZZSlw6HpDkNgMmMccUGkNyQNXRV9MMgivKtI25ihg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5058
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
Cc: "Li, Candice" <Candice.Li@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144EE9831D30CB82829EC09F7DFABL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Zhang, Yifan <Yifan1.Zhang@amd.com>
Sent: Tuesday, October 24, 2023 9:41 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Li, Candice <Candice.Li@amd.com>; Feng, Kenneth <Ken=
neth.Feng@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>
Subject: [PATCH] drm/amd/pm: call smu_cmn_get_smc_version in is_mode1_reset=
_supported.

is_mode1_reset_supported may be called before smu init, when smu_context
is unitialized in driver load/unload test. Call smu_cmn_get_smc_version
explicitly is_mode1_reset_supported.

Fixes: 5fe5098c64d9 ("drm/amd/pm: drop most smu_cmn_get_smc_version in smu"=
)
Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 8 +++++++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c    | 8 +++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 090249b6422a..77c3d76c76a2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -2461,12 +2461,18 @@ static bool sienna_cichlid_is_mode1_reset_supported=
(struct smu_context *smu)
 {
         struct amdgpu_device *adev =3D smu->adev;
         uint32_t val;
+       uint32_t smu_version;
+       int ret;

         /**
          * SRIOV env will not support SMU mode1 reset
          * PM FW support mode1 reset from 58.26
          */
-       if (amdgpu_sriov_vf(adev) || (smu->smc_fw_version < 0x003a1a00))
+       ret =3D smu_cmn_get_smc_version(smu, NULL, &smu_version);
+       if (ret)
+               return false;
+
+       if (amdgpu_sriov_vf(adev) || (smu_version < 0x003a1a00))
                 return false;

         /**
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index b1433973380b..648d5eafb27b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2615,13 +2615,19 @@ static int smu_v13_0_0_baco_exit(struct smu_context=
 *smu)
 static bool smu_v13_0_0_is_mode1_reset_supported(struct smu_context *smu)
 {
         struct amdgpu_device *adev =3D smu->adev;
+       u32 smu_version;
+       int ret;

         /* SRIOV does not support SMU mode1 reset */
         if (amdgpu_sriov_vf(adev))
                 return false;

         /* PMFW support is available since 78.41 */
-       if (smu->smc_fw_version < 0x004e2900)
+       ret =3D smu_cmn_get_smc_version(smu, NULL, &smu_version);
+       if (ret)
+               return false;
+
+       if (smu_version < 0x004e2900)
                 return false;

         return true;
--
2.37.3


--_000_BL1PR12MB5144EE9831D30CB82829EC09F7DFABL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;font=
-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhang, Yifan &lt;Yifa=
n1.Zhang@amd.com&gt;<br>
<b>Sent:</b> Tuesday, October 24, 2023 9:41 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;; Li, Candice &lt;Candice.Li@amd.co=
m&gt;; Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;; Zhang, Yifan &lt;Yifan1.=
Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: call smu_cmn_get_smc_version in is_mode=
1_reset_supported.</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">is_mode1_reset_supported may be called before smu =
init, when smu_context<br>
is unitialized in driver load/unload test. Call smu_cmn_get_smc_version<br>
explicitly is_mode1_reset_supported.<br>
<br>
Fixes: 5fe5098c64d9 (&quot;drm/amd/pm: drop most smu_cmn_get_smc_version in=
 smu&quot;)<br>
Signed-off-by: Yifan Zhang &lt;yifan1.zhang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 8 +++++++-<=
br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c&nbsp;&nbsp;&nbsp=
; | 8 +++++++-<br>
&nbsp;2 files changed, 14 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<br>
index 090249b6422a..77c3d76c76a2 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<br>
@@ -2461,12 +2461,18 @@ static bool sienna_cichlid_is_mode1_reset_supported=
(struct smu_context *smu)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D smu-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t val;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t smu_version;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * SRIOV env will not=
 support SMU mode1 reset<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * PM FW support mode=
1 reset from 58.26<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) || (smu-&gt=
;smc_fw_version &lt; 0x003a1a00))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_get_smc_version(smu, =
NULL, &amp;smu_version);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return false;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) || (smu_ver=
sion &lt; 0x003a1a00))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
index b1433973380b..648d5eafb27b 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
@@ -2615,13 +2615,19 @@ static int smu_v13_0_0_baco_exit(struct smu_context=
 *smu)<br>
&nbsp;static bool smu_v13_0_0_is_mode1_reset_supported(struct smu_context *=
smu)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D smu-&gt;adev;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 smu_version;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* SRIOV does not support =
SMU mode1 reset */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* PMFW support is availab=
le since 78.41 */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;smc_fw_version &lt; 0x004=
e2900)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_get_smc_version(smu, =
NULL, &amp;smu_version);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return false;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu_version &lt; 0x004e2900)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
-- <br>
2.37.3<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144EE9831D30CB82829EC09F7DFABL1PR12MB5144namp_--
