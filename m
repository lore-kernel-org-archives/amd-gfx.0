Return-Path: <SRS0=6vDE=62=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E550CA90AF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2020 16:54:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17ACC206B9
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2020 16:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="S4VsLoU2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17ACC206B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F0A96E947;
	Tue, 12 May 2020 16:54:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 915736E946
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2020 16:54:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XG/tu41P+C/SFMjYPD3vgzSUpEMKHVZVk/zUuzhrhJaSr99k8e3/w90+m1dHMmrHtAyWmQ5Fz60YcaMK2nR/NaiZVmM14ml7ee6IAlS0Fx6/uCGNJmTzSSrHawxmXcFFArbmW/40vNdrJw097e7laoCBI+KLrm9BOkDex+iesDjQMwUzl43jRHzGrMKmh93KalckZg/IZUxkDVffHn59I7rK8++/t91tWM+XCzXcF082nItftuBBWtvqS4jzUA5NZHokAlPEfldMkR8NzAg2Xq9IygakUTzufO1hXH36ImWo54Hl0O7W6w74UIJIJV7YtLq0412yi74he7IQ7D3/Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BcPjGUhXYCNXXcdhq7/qtfJdaOpOtTzaKPYCHzMtrIc=;
 b=eDfDdQhORtQr9lUsrP4r1h49DVxfZRQ+65Onw5EEvNm49SWM/XVWMe4CWhnBmXsrp27sFBn5iBjxheZDsOxSTjuuXU+tdsL6qpL1NKBPHa39QufARVCfjcXzKDkKSV9LoVNVMr3tvY8ZHrsw63QdIi0e8FRdSnx1nahwtCwOu5RC+LPmNnvpTIfiIkDXOXs2D9le29qWr1R8lbOCoLWABQN4z42achX7O3sSb5QgPU/QzVmcgp9lCKepR5kCVf+67AtF7OJCectgt5DkBu8zJfX9nfTTyXyGcjYZatoflXIu2qrH8w34r4dZGtqAqtl7zChR53UXwpgLtdZ2k3iC0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BcPjGUhXYCNXXcdhq7/qtfJdaOpOtTzaKPYCHzMtrIc=;
 b=S4VsLoU2yU1kZefGz/rZ2zL+2A8OhzgaL1dg1yB902mCy1snz1OT0G8zfMc783re8VAgGPzMoqs/5DPTH4LcFifkhJWEsAJJ6toxf+safLfirmTYlmT+I6aqo75nJ3k1lSHPP8bOKuul07C0b1jcrj3nl+kKUsnCJpaWYQwVDkU=
Received: from DM5PR1201MB0026.namprd12.prod.outlook.com (2603:10b6:4:52::19)
 by DM5PR1201MB0107.namprd12.prod.outlook.com (2603:10b6:4:55::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Tue, 12 May
 2020 16:54:20 +0000
Received: from DM5PR1201MB0026.namprd12.prod.outlook.com
 ([fe80::bc8d:388d:7086:692c]) by DM5PR1201MB0026.namprd12.prod.outlook.com
 ([fe80::bc8d:388d:7086:692c%7]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 16:54:20 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Tao, Yintian"
 <Yintian.Tao@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Khaire, Rohit"
 <Rohit.Khaire@amd.com>
Subject: RE: [PATCH] drm/amdgpu: turn back rlcg write for gfx_v10
Thread-Topic: [PATCH] drm/amdgpu: turn back rlcg write for gfx_v10
Thread-Index: AQHWKEaPKO8Bw/JCTkOBOeKPrSMg0qikggUAgAAiZ0A=
Date: Tue, 12 May 2020 16:54:20 +0000
Message-ID: <DM5PR1201MB002621B2E4E6314F9CFE1342F4BE0@DM5PR1201MB0026.namprd12.prod.outlook.com>
References: <20200512101721.12164-1-yttao@amd.com>
 <MN2PR12MB44883BAFB8242994F2BAF857F7BE0@MN2PR12MB4488.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB44883BAFB8242994F2BAF857F7BE0@MN2PR12MB4488.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-05-12T14:26:11.901Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-05-12T16:54:18Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: d87bca4d-55bf-4195-b354-0000a1e9f2cb
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a092462b-0bef-4226-d768-08d7f6951d9a
x-ms-traffictypediagnostic: DM5PR1201MB0107:|DM5PR1201MB0107:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB01076AB8D614E484C88D1312F4BE0@DM5PR1201MB0107.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0401647B7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kCvyDO/y9n+Oq/5cM4g08IqQ5xVo3gxco9rCpj1l5sOqcjDZ17cjnj6nnEwI8x2tjwMDHJ6+I/nU6FlrOfA5cC9MaqZxswHwhTvKYJK2JqMl5WCcSVs9+URbCtCZkAq/jukBC2uHtIyIC5/V3H4whGks8nj5p+W5KyQVDrxQxQ7ciTe2GWDUcsJ5PYhmTi0Z86VVm0IE2877VVt3mp7GWNESKwdugzP4OBqfa8ZR9PwFIcs5FkfeFHEXlB7F3/T+K3xKsqGIZxDWrtJ6C1MhEBkXJiFzR2AFiRAkWivQ6m7VvYnpMQcae4Zqf3ilM3zbNj74LqZKN+SdozGVZQSUViSqEv+8S2OTQ6Q/YmLMMN0WmnLG53A1GG9ORNSysUq7wkV6230ToAHtRa86oKBzi6zFR2FkstJ2Ka+6+MSpwmo4DSUAMbwjPgqTV2WfW1sBTyOiWH+8/u1f1bam5s+phrGRC4FbsalJmBTy9wpcfy93kZ3bNM3HrL/3iKazHsoGVJbfSwYze66aS8e7Fm3EuA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0026.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(396003)(366004)(346002)(376002)(33430700001)(66476007)(66556008)(9686003)(5660300002)(66446008)(6636002)(8676002)(52536014)(64756008)(186003)(33656002)(76116006)(86362001)(7696005)(110136005)(33440700001)(8936002)(26005)(55016002)(2906002)(4326008)(6506007)(66946007)(53546011)(54906003)(478600001)(316002)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: IFYyQvuerjZM9k3uX4hShvsJLy4no8BwPPBqoSvCee4j3Erxe5i/fqqmiLLQRide+Ve+B+y8so9kKYbTaWgCA6wqfoa7JNdqmctRE8yHnJK2eP9C4HFnZgpvwvr8oulzAdaC99OMLJ5IugrRX9iwqTc9igSjDtDmHX8/7eRcsCwMDGvUo6MrNZo/Xus1PMwhtWnWX+Pt1eat6BXbT+4FOhhAXYgc3mRs+v9rFJH5KcjgXha4G0Ov0FE9ImL8xmtn8l0Vx8ty6nHjAvGhIHyShU9guS4+yrTFGjORqWZXt0K51EhWVB8EOBRzwqErcnan18jmrbfPn+JL3v+xB8kYshv1aA60Pd00fCg5DBvzAqjLXEWHvYhlL8NYlqGIxo/r+TjIx+dBYQnamRhMmUAiQIxNAMa016T+ZsctK/EHY/9c+KXuRBU9QfR2HPL/W53se4qVICy63ervSYcl15hE178kpPZBOb3ehNDOszfXFkYkhwxrcj3Pl/Z37L23g793
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a092462b-0bef-4226-d768-08d7f6951d9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2020 16:54:20.2351 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: blhzbsme2kwUoXCjJC7Q96mur0e8B/IuZzrnREr8hwUR1a6FVp5lVIDDM7TbJzPxqMbmpXK+hUZSN+KsDYmItA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0107
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
Cc: "Tao, Yintian" <Yintian.Tao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0538687676=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0538687676==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR1201MB002621B2E4E6314F9CFE1342F4BE0DM5PR1201MB0026_"

--_000_DM5PR1201MB002621B2E4E6314F9CFE1342F4BE0DM5PR1201MB0026_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]


[AMD Public Use]

Hi, YinTao
The write to CSIB register through RLCG requires RLCG firmware to support i=
t.  This currently only implemented by nv12 . So you need to find a way to =
block it  for other GFX 10 asic like NV14 , nv21 if you want to revert the =
code.

On existing code , amdgpu_mm_wreg_mmio_rlc  seems do what is expected (fall=
 back to MMIO if RLCG support not there) from the name , so although it ori=
ginally designed for debugfs case access,  we should check why it failed on=
 your case .
In my previous fix , I try to only initialize the rlcg_write function point=
er for nv12. The function amdgpu_mm_wreg_mmio_rlc  will depends on SRIOV an=
d rlcg_write function to go through rlcg way .  This will exclude the bare-=
metal mode . Do you see the  issue on bare metal mode on nv12 ? If that's t=
he case  we might can consider to remove the SRIOV check inside function am=
dgpu_mm_wreg_mmio_rlc .

Regards
Shaoyun.liu


From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Tuesday, May 12, 2020 10:26 AM
To: Tao, Yintian <Yintian.Tao@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Liu, =
Shaoyun <Shaoyun.Liu@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Tao, Yintian <Yintian.Tao@amd.com>
Subject: Re: [PATCH] drm/amdgpu: turn back rlcg write for gfx_v10


[AMD Public Use]

Acked-by: Alex Deucher <alexander.deucher@amd.com<mailto:alexander.deucher@=
amd.com>>
________________________________
From: Yintian Tao <yttao@amd.com<mailto:yttao@amd.com>>
Sent: Tuesday, May 12, 2020 6:17 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>; Liu, Monk <Monk.Liu@amd.com<mailto:Monk.Liu@amd.com>>; Liu, Shao=
yun <Shaoyun.Liu@amd.com<mailto:Shaoyun.Liu@amd.com>>
Cc: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>; Tao, Yi=
ntian <Yintian.Tao@amd.com<mailto:Yintian.Tao@amd.com>>
Subject: [PATCH] drm/amdgpu: turn back rlcg write for gfx_v10

There is no need to use amdgpu_mm_wreg_mmio_rlc()
during initialization time because this interface
is only designed for debugfs case to access the
registers which are only permitted by RLCG during
run-time. Therefore, turn back rlcg write for gfx_v10.
If we not turn back it, it will raise amdgpu load failure.
[   54.904333] amdgpu: SMU driver if version not matched
[   54.904393] amdgpu: SMU is initialized successfully!
[   54.905971] [drm] kiq ring mec 2 pipe 1 q 0
[   55.115416] amdgpu 0000:00:06.0: [drm:amdgpu_ring_test_helper [amdgpu]] =
*ERROR* ring gfx_0.0.0 test failed (-110)
[   55.118877] [drm:amdgpu_device_init [amdgpu]] *ERROR* hw_init of IP bloc=
k <gfx_v10_0> failed -110
[   55.126587] amdgpu 0000:00:06.0: amdgpu_device_ip_init failed
[   55.133466] amdgpu 0000:00:06.0: Fatal error during GPU init

Signed-off-by: Yintian Tao <yttao@amd.com<mailto:yttao@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index 449408cfd018..bd5dd4f64311 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4577,13 +4577,11 @@ static int gfx_v10_0_init_csb(struct amdgpu_device =
*adev)
         adev->gfx.rlc.funcs->get_csb_buffer(adev, adev->gfx.rlc.cs_ptr);

         /* csib */
-       /* amdgpu_mm_wreg_mmio_rlc will fall back to mmio if doesn't suppor=
t rlcg_write */
-       amdgpu_mm_wreg_mmio_rlc(adev, SOC15_REG_OFFSET(GC, 0, mmRLC_CSIB_AD=
DR_HI),
-                                adev->gfx.rlc.clear_state_gpu_addr >> 32, =
0);
-       amdgpu_mm_wreg_mmio_rlc(adev, SOC15_REG_OFFSET(GC, 0, mmRLC_CSIB_AD=
DR_LO),
-                                adev->gfx.rlc.clear_state_gpu_addr & 0xfff=
ffffc, 0);
-       amdgpu_mm_wreg_mmio_rlc(adev, SOC15_REG_OFFSET(GC, 0, mmRLC_CSIB_LE=
NGTH),
-                                adev->gfx.rlc.clear_state_size, 0);
+       WREG32_SOC15_RLC(GC, 0, mmRLC_CSIB_ADDR_HI,
+                        adev->gfx.rlc.clear_state_gpu_addr >> 32);
+       WREG32_SOC15_RLC(GC, 0, mmRLC_CSIB_ADDR_LO,
+                        adev->gfx.rlc.clear_state_gpu_addr & 0xfffffffc);
+       WREG32_SOC15_RLC(GC, 0, mmRLC_CSIB_LENGTH, adev->gfx.rlc.clear_stat=
e_size);

         return 0;
 }
@@ -5192,7 +5190,7 @@ static int gfx_v10_0_cp_gfx_enable(struct amdgpu_devi=
ce *adev, bool enable)
         tmp =3D REG_SET_FIELD(tmp, CP_ME_CNTL, ME_HALT, enable ? 0 : 1);
         tmp =3D REG_SET_FIELD(tmp, CP_ME_CNTL, PFP_HALT, enable ? 0 : 1);
         tmp =3D REG_SET_FIELD(tmp, CP_ME_CNTL, CE_HALT, enable ? 0 : 1);
-       amdgpu_mm_wreg_mmio_rlc(adev, SOC15_REG_OFFSET(GC, 0, mmCP_ME_CNTL)=
, tmp, 0);
+       WREG32_SOC15_RLC(GC, 0, mmCP_ME_CNTL, tmp);

         for (i =3D 0; i < adev->usec_timeout; i++) {
                 if (RREG32_SOC15(GC, 0, mmCP_STAT) =3D=3D 0)
--
2.17.1

--_000_DM5PR1201MB002621B2E4E6314F9CFE1342F4BE0DM5PR1201MB0026_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheader87abd423, li.msipheader87abd423, div.msipheader87abd423
	{mso-style-name:msipheader87abd423;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"msipheader87abd423" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#317100">[AMD Public Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hi, YinTao<o:p></o:p></p>
<p class=3D"MsoNormal">The write to CSIB register through RLCG requires RLC=
G firmware to support it. &nbsp;This currently only implemented by nv12 . S=
o you need to find a way to block it &nbsp;for other GFX 10 asic like NV14 =
, nv21 if you want to revert the code.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">On existing code , amdgpu_mm_wreg_mmio_rlc &nbsp;see=
ms do what is expected (fall back to MMIO if RLCG support not there) from t=
he name , so although it originally designed for debugfs case access, &nbsp=
;we should check why it failed on your case
 . <o:p></o:p></p>
<p class=3D"MsoNormal">In my previous fix , I try to only initialize the rl=
cg_write function pointer for nv12. The function amdgpu_mm_wreg_mmio_rlc &n=
bsp;will depends on SRIOV and rlcg_write function to go through rlcg way . =
&nbsp;This will exclude the bare-metal mode
 . Do you see the&nbsp; issue on bare metal mode on nv12 ? If that&#8217;s =
the case &nbsp;we might can consider to remove the SRIOV check inside funct=
ion amdgpu_mm_wreg_mmio_rlc .
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards<o:p></o:p></p>
<p class=3D"MsoNormal">Shaoyun.liu<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Deucher, Alexander &lt;Alexander.Deuche=
r@amd.com&gt; <br>
<b>Sent:</b> Tuesday, May 12, 2020 10:26 AM<br>
<b>To:</b> Tao, Yintian &lt;Yintian.Tao@amd.com&gt;; Liu, Monk &lt;Monk.Liu=
@amd.com&gt;; Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org; Tao, Yintian &lt;Yintian.Tao@amd.=
com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: turn back rlcg write for gfx_v10<o:=
p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:#317100">[AMD Public Use]<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Acked-b=
y: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com">alexander.=
deucher@amd.com</a>&gt;<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Yintian Tao &lt;<a href=3D"mailto:yttao@amd.com">yt=
tao@amd.com</a>&gt;<br>
<b>Sent:</b> Tuesday, May 12, 2020 6:17 AM<br>
<b>To:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher@amd.com</a>&gt;; Liu, Monk &lt;<a href=3D"mailto:Monk=
.Liu@amd.com">Monk.Liu@amd.com</a>&gt;; Liu, Shaoyun &lt;<a href=3D"mailto:=
Shaoyun.Liu@amd.com">Shaoyun.Liu@amd.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;; Tao, Yintian &lt;<a href=3D"mailto:Yint=
ian.Tao@amd.com">Yintian.Tao@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: turn back rlcg write for gfx_v10</span>=
 <o:p>
</o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">There is no need to u=
se amdgpu_mm_wreg_mmio_rlc()<br>
during initialization time because this interface<br>
is only designed for debugfs case to access the<br>
registers which are only permitted by RLCG during<br>
run-time. Therefore, turn back rlcg write for gfx_v10.<br>
If we not turn back it, it will raise amdgpu load failure.<br>
[&nbsp;&nbsp; 54.904333] amdgpu: SMU driver if version not matched<br>
[&nbsp;&nbsp; 54.904393] amdgpu: SMU is initialized successfully!<br>
[&nbsp;&nbsp; 54.905971] [drm] kiq ring mec 2 pipe 1 q 0<br>
[&nbsp;&nbsp; 55.115416] amdgpu 0000:00:06.0: [drm:amdgpu_ring_test_helper =
[amdgpu]] *ERROR* ring gfx_0.0.0 test failed (-110)<br>
[&nbsp;&nbsp; 55.118877] [drm:amdgpu_device_init [amdgpu]] *ERROR* hw_init =
of IP block &lt;gfx_v10_0&gt; failed -110<br>
[&nbsp;&nbsp; 55.126587] amdgpu 0000:00:06.0: amdgpu_device_ip_init failed<=
br>
[&nbsp;&nbsp; 55.133466] amdgpu 0000:00:06.0: Fatal error during GPU init<b=
r>
<br>
Signed-off-by: Yintian Tao &lt;<a href=3D"mailto:yttao@amd.com">yttao@amd.c=
om</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 14 &#43;&#43;&#43;&#43;&#43;=
&#43;--------<br>
&nbsp;1 file changed, 6 insertions(&#43;), 8 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c<br>
index 449408cfd018..bd5dd4f64311 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
@@ -4577,13 &#43;4577,11 @@ static int gfx_v10_0_init_csb(struct amdgpu_dev=
ice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.funcs-&gt=
;get_csb_buffer(adev, adev-&gt;gfx.rlc.cs_ptr);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* csib */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* amdgpu_mm_wreg_mmio_rlc will fall =
back to mmio if doesn't support rlcg_write */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mm_wreg_mmio_rlc(adev, SOC15_R=
EG_OFFSET(GC, 0, mmRLC_CSIB_ADDR_HI),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.clear_state_gpu_addr=
 &gt;&gt; 32, 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mm_wreg_mmio_rlc(adev, SOC15_R=
EG_OFFSET(GC, 0, mmRLC_CSIB_ADDR_LO),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.clear_state_gpu_addr=
 &amp; 0xfffffffc, 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mm_wreg_mmio_rlc(adev, SOC15_R=
EG_OFFSET(GC, 0, mmRLC_CSIB_LENGTH),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.clear_state_size, 0)=
;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_RLC(GC, 0, mmRLC_CSI=
B_ADDR_HI,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&=
gt;gfx.rlc.clear_state_gpu_addr &gt;&gt; 32);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_RLC(GC, 0, mmRLC_CSI=
B_ADDR_LO,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&=
gt;gfx.rlc.clear_state_gpu_addr &amp; 0xfffffffc);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_RLC(GC, 0, mmRLC_CSI=
B_LENGTH, adev-&gt;gfx.rlc.clear_state_size);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
@@ -5192,7 &#43;5190,7 @@ static int gfx_v10_0_cp_gfx_enable(struct amdgpu_=
device *adev, bool enable)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp,=
 CP_ME_CNTL, ME_HALT, enable ? 0 : 1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp,=
 CP_ME_CNTL, PFP_HALT, enable ? 0 : 1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp,=
 CP_ME_CNTL, CE_HALT, enable ? 0 : 1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mm_wreg_mmio_rlc(adev, SOC15_R=
EG_OFFSET(GC, 0, mmCP_ME_CNTL), tmp, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_RLC(GC, 0, mmCP_ME_C=
NTL, tmp);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-=
&gt;usec_timeout; i&#43;&#43;) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (RREG32_SOC15(GC, 0, mmCP_STAT) =3D=3D 0)<br>
-- <br>
2.17.1<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM5PR1201MB002621B2E4E6314F9CFE1342F4BE0DM5PR1201MB0026_--

--===============0538687676==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0538687676==--
