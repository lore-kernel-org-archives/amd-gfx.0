Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1CFCC67871
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 07:50:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CA7F10E539;
	Thu, 27 Oct 2022 07:50:48 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2058.outbound.protection.outlook.com [40.107.96.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD3E810E539
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 07:50:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCA8oUAei8va9mN+k+R9hLc3ESJE8dbsuK/Un79+COJHk7xKPN8Jm3VJrXLFsnauHO3c1U+BC7vk7D2acY34kquaHH+JLASzCW/FarOuEKK2EQ6uwyza6MDSd8fbSmeyxbz8sv/KW3fFJvR1QeN0AsVp2+2wYJiatC4j/SPLQZSMnsC/ebWneWDIGASCepGzcPLYqOUjrM8ooat2Bg1zzypEFmpLC7KGMYvLGYhbLdVgStfI7tHDtkZ9YLMbCjx6kGTtQYe5akuDZvVp0+xHxDBrBsg800unMORGdtvBPaS29QS0zdMwazXmEJBERJIjERlIgyaxHXbw0qQ1lvyMKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LU4hkTLIzaaql/uWh3ugfXuOLQnmyKc6ELiAjJvlG7s=;
 b=bo8UixbwtV3fwf6xEQwJeTtKoWLIxEKdrCt2e9BVYfbr/2W5YGhFgwfnI/gLKXh8voPv/9OWMBtvLDYTXZrY7BX34X88SO6pfltNquHqZyiRVJoxXdDvhiZNMwQOKvs4XPsiFzoTYxZc0UpOG0IOEokt+h0CqDtXnN3WFR/0243qJgyy5zFdP6FYplwfaTn3Xa300nkvya5ANtRZBF4fKU3JPjh66b3G0+DTzZ8xx6KkkvqvadXmIoZRaSZqvyGdD5P4x1w2qt6yGfRJ2G917VsoWUv2iqKXxVJIR4qG8zA0OzCesCSotequYaDtZdj11I8Il1qws4fI2AW2thGmOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LU4hkTLIzaaql/uWh3ugfXuOLQnmyKc6ELiAjJvlG7s=;
 b=Z58yVwcrfmmSNEtzs+n8IvM8rKvVM41kVnJyiIM9JtqH62o0jST8cxbAU6zhVEZOrl5RPqsGyuS4cmJ+3GBCezHYN/TS0E/gIiQR/Ct7TIQt9xV9Bm7JVnmR/7Peo7fDBFiQOk1Xt7DWGEf1J+/C8R0vFaF5CgQk9g18vorKFYY=
Received: from BY5PR12MB3873.namprd12.prod.outlook.com (2603:10b6:a03:1a3::18)
 by DM6PR12MB4107.namprd12.prod.outlook.com (2603:10b6:5:218::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 07:50:42 +0000
Received: from BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::ed67:d561:7e47:ed4e]) by BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::ed67:d561:7e47:ed4e%7]) with mapi id 15.20.5769.014; Thu, 27 Oct 2022
 07:50:40 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: force read discovery file if set discovery=2
Thread-Topic: [PATCH] drm/amdgpu: force read discovery file if set discovery=2
Thread-Index: AQHY6OkIMU8GkCB0jUq5NU5L+KrKq64h311g
Date: Thu, 27 Oct 2022 07:50:40 +0000
Message-ID: <BY5PR12MB3873252B8E91346C8DD32650F6339@BY5PR12MB3873.namprd12.prod.outlook.com>
References: <20221026031354.3230715-1-yifan1.zhang@amd.com>
In-Reply-To: <20221026031354.3230715-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=34ef11d1-a481-4f87-8c36-1b3c763edb7c;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-10-27T07:49:40Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB3873:EE_|DM6PR12MB4107:EE_
x-ms-office365-filtering-correlation-id: 7e44fe2f-344d-4fb3-45f5-08dab7eff19b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nhfwW3ZruVTOjYF+wSv7yhIu1JyPh2Rob+BN0FVrrdPUANcjoGwWsVTBDDnfQTitrFqVteOPRMbEXK5VpmlsCMIR8KKz3y+wzewCcgpRMiElZN7j1wbO4TWWRHXZuTIRQmykp2Wb8XGaU4ATT7w35esDHM8SvJET4JsW9twoQVLw6Y7AeIoXO/P8PxsL5PwcoILlfd2XiDB70hcxZlfNhZDTZNHbUhJVqOzmhUU/txStOiWucNciDgrCResb5yd7LEehXvopCFOKkAz9DJRtBQsB9u7A1eMwzlDoK6DdgnC/RTw2NjFEbTPGkkxfDRYj+fNNnw/0DSH3U2UvU9her085j2vY4iAZbOtSuari9kmfxL/598RWmDuM8XdnNRbtmsw1Y1l6nl0kmhQRn0bQR0o3W8841LWdzTcpwzstFXd8ZMnfrC3ZlIGEY3R2CjPs5HCqzzOXfdqapdcIwvy7Ua0AGCDinZKyR197d/5CTMb4vhE+YyKTVNRHiPWWnvY/l9QRqfvF3MAR8YtLJtMu5a7ZmGwhSC8M6XUJrdeGdiuPT2rNjzx8jdYXXNzX11pwGlBZctxv4yTaW/uYdFkHMeYBDEzkXb8C2zvgTh888LitSWNnXDwPVO3fmJqwgyO5f7+1t1JpGzJNYFTfJKuCAd+1bkVDfqd3HY/LcpryG5ZcjkXAvWPWYAnIY92BVBly/vfzLt6lZf9EddDWKtxhZ5AqKbePjpTB71XA3K5fzH8i+Ylxnnb0jACbUPvghBDJCX0u7j16gSJecRtNtSLG5w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(451199015)(83380400001)(186003)(478600001)(33656002)(2906002)(71200400001)(38070700005)(86362001)(55016003)(38100700002)(6506007)(7696005)(26005)(9686003)(53546011)(66556008)(4326008)(110136005)(8676002)(41300700001)(66446008)(54906003)(66946007)(52536014)(64756008)(76116006)(122000001)(8936002)(66476007)(316002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eENgXU0+i5hLx5AdaJsrfxI8dLFxkGxKkbGwlTTiMNG8RXkxzNYyupgk80cG?=
 =?us-ascii?Q?cw4LQ+s7Om/hjDuIcLSmIp+G320P7gWH4TAwzh+hR6P4ix1eQYiHQasVqp3N?=
 =?us-ascii?Q?SAqssiEtHwvOoJ9JlcFAI6DtR8OYXpzd+NvGpY1GJRTgYPjn2xf8jJK4VHuo?=
 =?us-ascii?Q?FO/mBbhBdJrgiX8KTDLZ9JrmxVGVnm5uYrOavlz5nKYMc8J86+7LSm3Kh32m?=
 =?us-ascii?Q?N/VPUySjjr5CYhwYA4KplJLyjqNqAGDuEzNdw10D7oNa6jzKGWTFICNWj6oC?=
 =?us-ascii?Q?203fPYaw/2xEjfjeTGkkFczrIHJH+hxMYcQ/U0EXDOJkH+I1r8BhSjsgtkmI?=
 =?us-ascii?Q?3DYXV/461hjbJ9qoKe/gbmsgOkIJ7Tp6ndB22YWPZT7PZlh62XptkcuHqc0w?=
 =?us-ascii?Q?ZQljALUhbJrNefXzykfz7Ayoml2KgRus53Sd/DdCPKpeG3/552rD3sOGbTmc?=
 =?us-ascii?Q?ut7KjZ9xpfo6UiDkP2grOv8Og6hcgDsifjNtjyFZcJoloFTo75Fxq8u6Gtho?=
 =?us-ascii?Q?BySB8Z8861w9AgoJt47K/gOGhjvCq8kKeCbhLSwIETjKdcGWn94iTTHeALtk?=
 =?us-ascii?Q?A8enJlUFKiH+3H5lifNDs80zvBWJuLUMIgAzbGb9FBe/gNhYJuervJvfHeUf?=
 =?us-ascii?Q?KZMSRsrBepDsU9Hs/oMZQyCnf9SdsSnY4xR4m2Du5vwG0gzorHiB3QWrEvkg?=
 =?us-ascii?Q?5IyuIVNRCOAcf4wZFwvPu5a/OVpk5NJm5VpygcWPG7r9l3/tP8StYTJouI/s?=
 =?us-ascii?Q?UH8bhB8H9vJHmjj50NhDFCDrbYWdfOaNoM+hPIKal6raQke9DHbxW+W7283h?=
 =?us-ascii?Q?QpelyPrz5NfwoeuJrrlg5fWyUBx/gmkQYMjbe2IvQQUkYZm/fJpIjpsumBnP?=
 =?us-ascii?Q?WtGJWp1a6G4OQSYZ0BAKSglfR7FWojLVFBMLvMWkL2Rom5D1fvB/jTI4stgj?=
 =?us-ascii?Q?zBYcJTyk00xk9bZufbyg0Evs5QEYwhBEs1svqjuF0KXngjaDJPLyuc3hFwmB?=
 =?us-ascii?Q?vQ63G/PJwj+ncqeG7ZEDkjfT9+YY/As8mrdcTZlovXhBe305E+O2H2iMTgZI?=
 =?us-ascii?Q?KfCN8T82o0zweeg+tgdcsFXJj++nr4fYDY+BnME4DZlUR11wINqhBkUtQ7Jn?=
 =?us-ascii?Q?L6IkIZITsPSqzq+jKMp2OnVRt8tiC/NdGilcJQBeWqlf7IOjyrD6pFqQAXko?=
 =?us-ascii?Q?/Yi5V5YgfUIxxG3paOcvh4JCpHWnOhv22H+bOU9miNWFn7oRasOjCpdjOXwQ?=
 =?us-ascii?Q?AQbmH98pLqpQOcG3K39Vm+sTptbWj1LCA90hQWYSc870gdh53/gJsGtH/N4m?=
 =?us-ascii?Q?J5aFvWkXivNb5e5GVZpgXXYXFpDg6y4Cv6iJXRMlOpkpOaBPU0kySadDxwAZ?=
 =?us-ascii?Q?2uFYlB6yCAPjfxYHUJjZuiasU9dnXO1QNlEqJ9hsjfd/wCXyb3rmFyRItTk1?=
 =?us-ascii?Q?nccTxUFIu7PxGZByOYec8LCt3AOABMlF9pZn3rtR6X8uwxyuMfzFtLqHNVFv?=
 =?us-ascii?Q?22/G0kOBm79hEJ/z8mCHiT6FC7RI6FumDfPtHKEhYUnjUgVh3HM8sMMrswnX?=
 =?us-ascii?Q?ywUb2EJ+UozcE4fys3vyR2JtuIxmCC3b6ZddBDH1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e44fe2f-344d-4fb3-45f5-08dab7eff19b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 07:50:40.4273 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AKI9nXcLu4KFQ4FviN1KxNaGpOtM+kX8yUZdrJDoITgKoJ8tGlCI636+teG5LaCo91gWADFWS8abTnSfGX4m8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4107
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liu,
 Aaron" <Aaron.Liu@amd.com>, "Du, Xiaojian" <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Reviewed-by: Tim Huang <Tim.Huang@amd.com>

Best Regards,
Tim Huang



-----Original Message-----
From: Zhang, Yifan <Yifan1.Zhang@amd.com>
Sent: Wednesday, October 26, 2022 11:14 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Tim <Tim.Huang@a=
md.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Liu, Aaron <Aaron.Liu@amd.com>=
; Zhang, Yifan <Yifan1.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: force read discovery file if set discovery=3D2

If discovery is set to 2 in module parameters explicitly, the intention is =
to use the discovery file in FW rather than the one in BIOS, usually becaus=
e the latter is incorrect. This patch to force read discovery file if set d=
iscovery=3D2.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index 3993e6134914..5ea9afaaf4f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -305,8 +305,13 @@ static int amdgpu_discovery_init(struct amdgpu_device =
*adev)
                goto out;
        }

-       if (!amdgpu_discovery_verify_binary_signature(adev->mman.discovery_=
bin)) {
-               dev_warn(adev->dev, "get invalid ip discovery binary signat=
ure from vram\n");
+       if (!amdgpu_discovery_verify_binary_signature(adev->mman.discovery_=
bin) || amdgpu_discovery =3D=3D 2) {
+               /* ignore the discovery binary from vram if discovery=3D2 i=
n kernel module parameter */
+               if (amdgpu_discovery =3D=3D 2)
+                       dev_info(adev->dev,"force read ip discovery binary =
from file");
+               else
+                       dev_warn(adev->dev, "get invalid ip discovery binar=
y signature from
+vram\n");
+
                /* retry read ip discovery binary from file */
                r =3D amdgpu_discovery_read_binary_from_file(adev, adev->mm=
an.discovery_bin);
                if (r) {
--
2.37.3

