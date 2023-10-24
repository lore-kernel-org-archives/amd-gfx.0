Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA85C00A8F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Oct 2023 08:14:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4044510E2F4;
	Tue, 24 Oct 2023 08:14:36 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE40110E2F1
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Oct 2023 08:14:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=at4ocmBabspqzaXn3sSfQZwvnWLEwjWhVn6gro7ViDTzoUDV8c5F2qTee/rMQnkVEyxYLHwu8gnJcVvy6zOLvlg85M+RI34YpK68gDJHBfv/0+3Q4x3OuGdZ5CoeuBLh1zKW2FjYNtSj8jyPiH6enNZ7nzV2lWTazwhsE95iQ5V687NjP8mzjlgyarNTlKj17ioS9tyCSXDf0U+yjrfJ5Iguh/cwt41b4e2jzq0fbw2+nmvjA4z9AlB71O4oxNXOAO/92hcsysaMjw0oZpiJhrB6cpkKy3/cs7Dh45ZCh2Q3IH2wf/xA1SKlSAPqRNA2qRrO2CJswfrOWG5zyZI5iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uf4bIY6gHHKpktyMg2V9ubf8CojPU/3h73f4uA09SAg=;
 b=hucxYBLuIgH17x+7JuyBWdDn29G1qcnZaPS58yZYk/6qJhuJojua70qnEMXSIr1H33d0XJJI8YIl8RBPUS15bC/vV70DQ9c/7zT1c46faVP/pARPQtQiEwy6g9lq66vBhvNS1RhhrGrHtFR1+X7/Yi0xeHKZxvQ/EnV8uHv4D0VAqcOeZ4BaNTG7VT6+ekH9+CAbZjEP+l/n2bkPsRbLwr/DM2zgI2OOVA8QQg4mR+JXB0Rq5sH8Psk1Os97SVFsd+Xo47xvYZ2PbdshUWEWEFFLWVHhzJENiY+3+IFjNTbNdxns7hleNn5al/rvhd/Mdxak9fSOeAgW2YQ5qFQMXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uf4bIY6gHHKpktyMg2V9ubf8CojPU/3h73f4uA09SAg=;
 b=dEFq7xN5VyIplkmlZQbzKtx9oe54G7pztcyMwAX6AqdMPmdSjKL8kkfk+rHZNfqhDtSteGnVn8r6J0EUhs5do2wkDmZz9aAcXq1vEgwnuzMDv9skl0ylWvetqKkiqnteTGXWXOCcn3hgQCMQEfpyJ7imKHZKoOcu5Jqli7P5rVw=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by PH7PR12MB9102.namprd12.prod.outlook.com (2603:10b6:510:2f8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Tue, 24 Oct
 2023 08:14:32 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::734d:d070:e2db:de7a]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::734d:d070:e2db:de7a%7]) with mapi id 15.20.6907.025; Tue, 24 Oct 2023
 08:14:31 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Yuan, Perry"
 <Perry.Yuan@amd.com>, "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu: ungate power gating when system suspend
Thread-Topic: [PATCH 1/3] drm/amdgpu: ungate power gating when system suspend
Thread-Index: AQHaBiJ9rOI5wQi3REOI0JUThqpJlLBYe4mAgAAcOJA=
Date: Tue, 24 Oct 2023 08:14:31 +0000
Message-ID: <PH7PR12MB599791A41D2A4E0803CAB07982DFA@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <9d71cec3a900bedfc4a9f2409a606405deb60985.1698114574.git.perry.yuan@amd.com>
 <DM4PR12MB5165A612DFDB89A7DC5DDB5B8EDFA@DM4PR12MB5165.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5165A612DFDB89A7DC5DDB5B8EDFA@DM4PR12MB5165.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=95cd0cc3-2f00-4034-b3bd-5e597ac8538c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-24T06:32:15Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|PH7PR12MB9102:EE_
x-ms-office365-filtering-correlation-id: d514710f-56de-45a9-965c-08dbd4694037
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u4F4zlwbxZ3GDCX755RkIB6Gq8W6zgBBL48FnWJ8djNkcSqZ2EG/oFAAyFqzlJMVsmEVZzvcbMMozJgWBCLZvLggdlsgB7ymp89Bh/M7HfrwtgKVMbQzgGWVBB4eJ6XuLuYg60bVQRTojwyOtnpD8X4nPPjL4F5yhJWZZmJLXlHzEes+7J/sbs3DmYU2lGfc5TsjSzV20vO9BH0gB2DhAhqv+wCHZV3ZCk62G9hciRgeRtptEj5I1vopavT9uti3pEU8vet+E3tkBpy0Lh8b2BEf9HwlQHOyQZMfQmnn6rpGqKt9zL+M6Du82iOgbZKEihEA2TNE4uhIfoHkNNY4gH26ugnzP6mwVRgIvrhBBI4t7mWtNZaoSNpnS1Fp+WWY1TDwkw77sLlHAGqhNqGpec4T1FcN47qCyay6dYdPCPfpjZXDIkDX3RLHBNw53Df+8LmAN7GcQQz7hYJOdZmFFtacvJN0ubPSpOp0AG4yMwS39oToI6rGqVkIWTlzvxeAExs44WLYhnWmCiFXZEuLaBO74eZJFv7y1bhaISuox0y5UpwyqMVZuwZSGjsjCB0st7D8vLMZthY3gKCSI36b1YqNI++ES7TLFwodKt9tnICcnuPsOjVCH7CpqGN4PG0n
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(366004)(396003)(376002)(39860400002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(38070700009)(26005)(2906002)(86362001)(41300700001)(5660300002)(52536014)(4326008)(8936002)(33656002)(15650500001)(8676002)(7696005)(478600001)(6506007)(71200400001)(110136005)(64756008)(66556008)(38100700002)(54906003)(66446008)(66946007)(316002)(66476007)(76116006)(6636002)(122000001)(83380400001)(53546011)(9686003)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?j/00OpK5aWCgWlGdgw33pii80rtOjLBwCHGvhSFVXPXSX6CtvggZmVdABXEq?=
 =?us-ascii?Q?oo8duKj0KReDp2BjO/6Q1rmeNxJjtaCgOgUtaBTere5BUC4y0YEfVMPHeMsd?=
 =?us-ascii?Q?Ys+dFqd2CW2piiTTz9y2boauCRIwUk4F+Oy78biW8PgDVRmCp6hppbB+LQQr?=
 =?us-ascii?Q?t5C3HSeXmPvbLW8+1TeDSwmbNF36Xen8RjYzPBcg35PSazJvfJbSUE1si6d8?=
 =?us-ascii?Q?MUTBIR9PQgBU7u0lkpU0kzBEOHxLt4romLHSAy4lR5zbErMYRgPy3DGtbsjm?=
 =?us-ascii?Q?Nd0fyVzzHRV/tH3ovEhZeW3aGbu5Gb0HoAoXX0ZXAI7jMJc1U/WKovkF2XYE?=
 =?us-ascii?Q?OsyM+uqIK4YUkQLqFv+VwAb87VYmEdQJex4h5p1Y0nfywNSpG3+5cvPx8SHB?=
 =?us-ascii?Q?ClZZICTpJvcsVBEidd900gTDFFn0Zk1ncU8rsosyy3bGUiZp6LLQa6YuLekt?=
 =?us-ascii?Q?vardI1oul8ATjIG2IbJ7z7mJie61Onv3DflxiWN6UK/gEVGeEwAXCh4cPjQC?=
 =?us-ascii?Q?3P7xctfOts8JfZYlS6SZGgyJO9T+LP2nn5fXtcXgWtPeSvEq2xFOTVcnfam9?=
 =?us-ascii?Q?HYpF1KAjxbkWOEI1lMYyP7HoDc6DUPd2F/v/3au9rk1qkf1u8V0dPNHLkjcz?=
 =?us-ascii?Q?s3q51OZHsgycFvevkTE6N6zEFwak5UxYK4WZAIlgaO7w7rbRajUQx0N/ib4B?=
 =?us-ascii?Q?0I4ihTKrqGbIDTGOtCFuUNOuB5BUXr1Uwxf9aoEa15Axq4VQyXwHQqrYmmkq?=
 =?us-ascii?Q?YOsEge3Mk1GOe94KRdciU4XyrBpxKPYUIQ2KCQEe/tJ4/zHH3hVR7szck0jP?=
 =?us-ascii?Q?dKgfoZYXzIVaSK5Bsou9i2YKnh4rXXx/eSFczY6VEqe4+8kARTz7h5YoWFxg?=
 =?us-ascii?Q?g/Ic9REdgd5qeXtFAZEdnX81SlvWoE1HPK4Ij9SVcvFd0asf2gOhnAr4izzQ?=
 =?us-ascii?Q?1KjfCLqN15Alz2zloPlRX26vXimBXAx3i8LFTWB0s00TponKdiwzLVhEeRTC?=
 =?us-ascii?Q?r9KxHTYNMvSY+liKVJz0/wWyTv9cd7th4nUhIdJtNA8LPSTQDe5gn3FQFDM5?=
 =?us-ascii?Q?z358EynFjrqHI/Mdyd8pVDi6UWtZ1kXHhslGzpQIItQWWQfJd5Ip6E40O5vb?=
 =?us-ascii?Q?JA/tqFOsAOIofWVx4JCCVj2gpYg6zGadxMiVWi3xWt1APoH7gLPTVxpo3MI8?=
 =?us-ascii?Q?diwLsH+ovF5jS1CeU97dDNrXI/TfUL7M9/goTFenpi8UPpQAOeXwbxD/V+HE?=
 =?us-ascii?Q?bO4bRNCSJA+FoP9kV48/mEQNjIFZrz1XpzUstvmPiwAreXm9ZCNOlvgNdy88?=
 =?us-ascii?Q?ItggRfmcCWm8GCIupbMXiEQ7QL4+gqzfeV4Kb5xFF2uIUxiO9+xE+TBkxG/N?=
 =?us-ascii?Q?dk0u7aRlYdmwbfGaC5cFwekovHJs9Gq/kGRuFPAIhgHLXCiRMLle/dvu28Pe?=
 =?us-ascii?Q?tWW01kFI7Appoa+Fr6dSjRejPzLI+lYt7IUAZkcbRAygMaq5IFc/vX+bI5hJ?=
 =?us-ascii?Q?qLB2jIwAAfs5qkgXgWcIClW8r9hUYg6te5KG1rkGse1JXVf8KDDZh2fUHVOz?=
 =?us-ascii?Q?MVzlceGvm7ezezUtEoU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d514710f-56de-45a9-965c-08dbd4694037
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 08:14:31.7091 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jO4MRypbm2thW4VZtho3ZOiJ9wZ72pqO6KN16rzvpKLubqNdhuX2Gke/X4h9QInT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9102
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Acked-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: Feng, Kenneth <Kenneth.Feng@amd.com>
Sent: Tuesday, October 24, 2023 2:33 PM
To: Yuan, Perry <Perry.Yuan@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>; =
Limonciello, Mario <Mario.Limonciello@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Yang(Kevin) <Kevi=
nYang.Wang@amd.com>; amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH 1/3] drm/amdgpu: ungate power gating when system suspen=
d

[AMD Official Use Only - General]

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: Yuan, Perry <Perry.Yuan@amd.com>
Sent: Tuesday, October 24, 2023 10:33 AM
To: Zhang, Yifan <Yifan1.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.co=
m>; Limonciello, Mario <Mario.Limonciello@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Yang(Kevin) <Kevi=
nYang.Wang@amd.com>; amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdgpu: ungate power gating when system suspend

[Why] During suspend, if GFX DPM is enabled and GFXOFF feature is enabled t=
he system may get hung. So, it is suggested to disable GFXOFF feature durin=
g suspend and enable it after resume.

[How] Update the code to disable GFXOFF feature during suspend and enable i=
t after resume.

[  311.396526] amdgpu 0000:03:00.0: amdgpu: SMU: I'm not done with your pre=
vious command: SMN_C2PMSG_66:0x0000001E SMN_C2PMSG_82:0x00000000 [  311.396=
530] amdgpu 0000:03:00.0: amdgpu: Fail to disable dpm features!
[  311.396531] [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR* suspe=
nd of IP block <smu> failed -62

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Kun Liu <kun.liu2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index d9ccacd06fba..6399bc71c56d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3498,6 +3498,8 @@ static void gfx_v10_0_ring_invalidate_tlbs(struct amd=
gpu_ring *ring,  static void gfx_v10_0_update_spm_vmid_internal(struct amdg=
pu_device *adev,
                                               unsigned int vmid);

+static int gfx_v10_0_set_powergating_state(void *handle,
+                                         enum amd_powergating_state state)=
;
 static void gfx10_kiq_set_resources(struct amdgpu_ring *kiq_ring, uint64_t=
 queue_mask)  {
        amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_SET_RESOURCES, 6)); @@ =
-7172,6 +7174,13 @@ static int gfx_v10_0_hw_fini(void *handle)
        amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
        amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);

+       /* WA added for Vangogh asic fixing the SMU suspend failure
+        * It needs to set power gating again during gfxoff control
+        * otherwise the gfxoff disallowing will be failed to set.
+        */
+       if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(10, 3, 1)=
)
+               gfx_v10_0_set_powergating_state(handle, AMD_PG_STATE_UNGATE=
);
+
        if (!adev->no_hw_access) {
                if (amdgpu_async_gfx_ring) {
                        if (amdgpu_gfx_disable_kgq(adev, 0))
--
2.34.1


