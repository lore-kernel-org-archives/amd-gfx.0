Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65CE4C54E64
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 05:50:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7486A10EA2D;
	Thu, 28 Mar 2024 05:50:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ToPwYlyO";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA9C510EA2D
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 05:50:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GlUEs21pITefafPrrzzPYnUfI0adi1avFJOxGVu5icXH/G9QpeTDSAh+qpFmfb5sYcItq2YwHMVKUDYHwUPsLWGjfvx7sazKB6H+cts4CM7SC9s1x4K/FFo+7NhdmGNvrQfzRdaE1EbuHCDoiYrPy9ChcPrlqmWbBntnK8zlO0UfpG6u7QURbqaO+EE7o2Lh1TXwqn4T1T1BGqpMzYmXyvA6NyI/au2PVDRHMd93Vcwt5F9mPpFrFx2nE3hKbwHnD0QS/gby30r/us41b1vjRkI9tJ2Lu1MxlfXiOB6bfM55S1M1jQksfTzyrP/IvzA4q5czURkdvV/QwVqaqARhng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tqt4mV3UBHG0w9b/n5KeAqcifCugojxsttierX0af1w=;
 b=U21FWoD0ZnlMGS6rYzl5AZVA8Q7pgJeJx1ppZFLCPIq8kAsoox0fFci4MrSzUMiIUh1pYV0SHYASnJH7boS/EpgvLOQk0GZOIj9XsMbNvCtEplbQoSDUXpVpH1tI9XMYu658l5QCmFGnDKZvuB3o/yceMC36L8r+L7OF8ShPpAEFPSUXZdqKdxr2esxgzJJGy21PDutUOA64QJMv7aV/XtXniBRNHdLiarRQA7TDX2L+jUEjD61gfMtbZSndzF1S9b+uf7BxgF8jJhklue5d8q0xekHQix8HcVSwE+7DNHK9Ra+bwntybBoE22U+P6rrsOrVlsouQFwCGlwecUF2Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tqt4mV3UBHG0w9b/n5KeAqcifCugojxsttierX0af1w=;
 b=ToPwYlyOv8AwkwkrJBiC63sBHl8J6gsZfIgQm+jMQVUnBhzGMN3SO9mNJfsqeHbGpvNKvZx7pEfsL86loPl6DE1g6EmhVghRIJNCCcso2S6s5mRM+mbYf7wE+CXblBPl+DGD79K11XqLEjYzE/WQQpJYHzfz7PqHOrjkodlY8WA=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DS7PR12MB5863.namprd12.prod.outlook.com (2603:10b6:8:7a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 05:50:18 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996%7]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 05:50:18 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v3] drm/amdgpu: Reset dGPU if suspend got aborted
Thread-Topic: [PATCH v3] drm/amdgpu: Reset dGPU if suspend got aborted
Thread-Index: AQHagM5Q257hxNA92kSdUICSzpBVWrFMpesA
Date: Thu, 28 Mar 2024 05:50:18 +0000
Message-ID: <BN9PR12MB52573A0257263E4FFFEAF367FC3B2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240328051036.826751-1-lijo.lazar@amd.com>
In-Reply-To: <20240328051036.826751-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0b155be3-397f-470f-b778-8da73bfdf6bb;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-28T05:49:57Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DS7PR12MB5863:EE_
x-ms-office365-filtering-correlation-id: d96b0909-72ff-43b9-58bb-08dc4eeaf318
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q436AuLMfdQMrGLFNd5j2GymTYdeMQzX+xuyhtDPjwooOb8yjKIIOsM1kG5KRJSgz09gCwJeGmVCShj0cHgudxOgpew2e5CCIKxukqK6HXcfb8bOuTZy3YnrunGg3e8xd5F3dpwHylWSjUyRL3XKI8OSqu9CowdlKNE4eJDSoC94nAH6KWFtblvAbWOvzeN4RBifUmUpTP73/PfhflgxCeHNxKFrmptIvI5ywys5W7VBhGSpIlU3ZikA6w03yjoLBN2GHbkHtNY91zo7syJqTc6P0rIxJsW1rWYl9YIciIrKsXke4P4VWbPGIs6AETZzYjK0N7nKNLzAw0sfh8EdUfI7wh0lJkB9mYvp68uqPJadyZzDokbelcKtdNrARhIiXsD2D2EWa07/Q+BdWfQOCWY0rfVj7+GkDxFyIPhxNQdAChwZQQINfld14S5+jT4gGL6JIMRI6m/Mwkc9ELJlj4ryfw1NsZCeQZtF+9USoJVTe3BA2iJywnTx2Chb9BJYzUN90KKYSpoYFrzUI7obYAFp5kFl5fNo/I3CsVfzA9L1SEWEDBL25LRg/o7wMcJu/eZDTKupCL9YWQ6/IRZ2T+SR6Hst9s8KFDapzzlcwy+N80qmQIj9Aab8uNjGP922DpnwacUhtuBAJ7CLKjB8l/nlxZjX2KJoMe18j7exLZPSKk8k2h5j19oiEDQzsEMrI0fIbzWseL1Njtgzg22zKyHvoVSQyEj+UgsJZxZBJFA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m5Asj64+qfsc047npJ9axj4okBKWZwzosafLUm15Ts2393u7+Ax1a4a/zcoZ?=
 =?us-ascii?Q?MVmPlrCou05JG9m6JgV03VQpAQtkMditq2CJstJPi8MrMr3cmygYXCYEJOQX?=
 =?us-ascii?Q?I6CH4LXdCJghZr+/I7tYAPM4SO/agVncCRdUqRoHdS34Crdk/tk2q5reCF2a?=
 =?us-ascii?Q?O0+7rrd51BiDALYr+0YP8snxnkctxKpi7gHxI4QwNjZPzc119h1qTEA2jjAe?=
 =?us-ascii?Q?UR8bVoYT22ccU72lIzFwZJV2YVc+ZfLqJzWijdbiZCsNvYFC6ugcAi/BhDxJ?=
 =?us-ascii?Q?mXo3hIIGa3bU2DaXz2kGSlIqiE+NJn5ABNHzcaf8+x2JKQUGyoWjSVVHe2nL?=
 =?us-ascii?Q?OxiSYN+jh7mqQzBVzzp4xrHEnVJNsfbTw7aIBToOobcQaRwBC9GwzcZ+5nIE?=
 =?us-ascii?Q?jxbcM39m0ReytduHMj6IGx9XQNf0/r7cjBeuC988pUs/ikTkS1JJywKwoARi?=
 =?us-ascii?Q?RIoonEcxki7XqV28aZf7lDWu9Ph6Cm7J4zREOV47bbGFHqtgd5Q+rRp5X+NP?=
 =?us-ascii?Q?/g/L6BGNl8Qwi9lrx7SroLrxDPT8c0i6Xxory9o3vrBormm6qw+pa3ZcvavX?=
 =?us-ascii?Q?9ayi7BlIdihMKum+o3wIxx3y1Pr0P/akx1keJ4dNW0j0p/lmqrIHjDArXP1x?=
 =?us-ascii?Q?3kj6ZFCyuq2qZp7uSI3TGH2Wm+3o3QKRjiB9Mfc2CA3BeFpPPzH8Eczp0NkH?=
 =?us-ascii?Q?H9X43lTKbvn4nfC1a+oaL6BalHqiHROy7hFwMg6dl2F0ZkkaRwn0wypADdc2?=
 =?us-ascii?Q?QxgK3EchnfWwhpEq9a7asOLcAGJL7wTGpUV/zAaE4VBUwTpXiBfyguvKsvWE?=
 =?us-ascii?Q?hHvqzOILUMfpwXCy7DqqjZ5UrCP/QsXLPm8L42I5BmaJCpZZzDJyghrW/5XD?=
 =?us-ascii?Q?j5bJEMKC4INdrd9BjN8kEeV3e5+PaLmvOpTbDGgjjvS5j2e5DUzWzJnTCkVj?=
 =?us-ascii?Q?SrlTiXDnoDwxRK0kef9zJOBgGp4hH0e1aIZvfXkb+ImnqNDxM0X7UDxrgmsf?=
 =?us-ascii?Q?VbWh4892LUPD0UiK4v3VLibFW1lklkd67cpOR+QSL07/o4VblG2pvs7zbPKt?=
 =?us-ascii?Q?PvHg63Uu8HQi8rRwyrzEmY8vziNGxdi/QbzoS5chs2STs8W8q1C0zojy7ZBS?=
 =?us-ascii?Q?bzJFep/DYtFnsIIh5XWGxyN9+GdrbRDt1CwFAawvjnp5Dm4qbwdJ5gytNAVF?=
 =?us-ascii?Q?BtwmkL5uY7fr7OCGm2uo4wQ2ml+w3GG7qVBI2IADw1ea9nyS71/w0mbJvkux?=
 =?us-ascii?Q?w0PLCDRDcQcFWQg4dBTgeRK49+BBoIHhlobvMdqkcy1dvcJH7bZoEgUfBSyI?=
 =?us-ascii?Q?RsAK+7nSUosGovhY4KGF3Ced78VhUrlMZs97gp78CR7c7jVru4azI3d1CpwE?=
 =?us-ascii?Q?EVIo1fJ4kv7/Nrj98tqQoiXR3GcJzpH6ppFVr0+rGiegdIwG32wAX63GXitU?=
 =?us-ascii?Q?c9LlRpEiB7Pt99fO1maOtZJEZZ5bxwHWBYPMwl0E7pxJCxtWVlcuP/vJRsCw?=
 =?us-ascii?Q?JtQ06V+kxp56/PUi57YMglMbw2pIm9KlrD5MGL8GyNoM4Xhq7Mef4lsB+0O0?=
 =?us-ascii?Q?We5EmaT5ys/ZITmVw3M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d96b0909-72ff-43b9-58bb-08dc4eeaf318
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 05:50:18.7428 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6sBKXqcc6kPVj73eYG2nddSWA4yT/VCZ6j4xI6wqNbgeJgW/errLN+py2N7GCf8priWHnecjH/3ff5nZPC8rUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5863
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

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Thursday, March 28, 2024 13:11
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Deucher, Alexa=
nder <Alexander.Deucher@amd.com>; stable@vger.kernel.org
Subject: [PATCH v3] drm/amdgpu: Reset dGPU if suspend got aborted

For SOC21 ASICs, there is an issue in re-enabling PM features if a suspend =
got aborted. In such cases, reset the device during resume phase. This is a=
 workaround till a proper solution is finalized.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Cc: stable@vger.kernel.org
---
v2: Read TOS status only if required (Kevin).
    Refine log message.

v3: Add stable trees tag

 drivers/gpu/drm/amd/amdgpu/soc21.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgp=
u/soc21.c
index 8526282f4da1..abe319b0f063 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -867,10 +867,35 @@ static int soc21_common_suspend(void *handle)
        return soc21_common_hw_fini(adev);
 }

+static bool soc21_need_reset_on_resume(struct amdgpu_device *adev) {
+       u32 sol_reg1, sol_reg2;
+
+       /* Will reset for the following suspend abort cases.
+        * 1) Only reset dGPU side.
+        * 2) S3 suspend got aborted and TOS is active.
+        */
+       if (!(adev->flags & AMD_IS_APU) && adev->in_s3 &&
+           !adev->suspend_complete) {
+               sol_reg1 =3D RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81);
+               msleep(100);
+               sol_reg2 =3D RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81);
+
+               return (sol_reg1 !=3D sol_reg2);
+       }
+
+       return false;
+}
+
 static int soc21_common_resume(void *handle)  {
        struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;

+       if (soc21_need_reset_on_resume(adev)) {
+               dev_info(adev->dev, "S3 suspend aborted, resetting...");
+               soc21_asic_reset(adev);
+       }
+
        return soc21_common_hw_init(adev);
 }

--
2.25.1

