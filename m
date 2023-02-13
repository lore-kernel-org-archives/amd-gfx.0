Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A34C636CC
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Feb 2023 06:05:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B14710E03C;
	Mon, 13 Feb 2023 06:05:09 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2056.outbound.protection.outlook.com [40.107.102.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C929510E03C
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Feb 2023 06:05:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZyyRfJNdFDAKSMKVJdsGEbsI+rJhg3gI2Io0r75tpCH8bO1ahnyD2VQ3x/CVSrKPv8izmL8VkHXOKFHDQHMldE/g4GgH0Oru2h3BnYZ3VsleDwAyc30kLdVYg5ZJ6d/TEuo0Hwl5uGSWAt4otMWJUVoOCe1WPtjf6sRv/MR9emuDuJKpzFrZwFhTBBKqMy+IXYpHrqFp7yKOOaAJb4M6yP78MUzDlEsjGgDItTFUP9Cobxf2vRpvS73HyL1buA0LG5yGU07Z8lEmx6RcuMIHgoaw7xPsc8zlztQ4sHoCd4cktck/MivfnaxQzneDAkgdM+9hKRT9Nan63t4KwuWqhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lrXw86Kw3AysQ1gdJJ3iz8GwkbRPBDm3HTlUSA8Z71E=;
 b=lWPFaVBM9TAzmHDFm6bxhC9+nG5EX/2r2LxuHm0ksblBpXQn9+1tcnVENhieQcKLdYmrKwS26Dycyg8RmuZbkSV0LPaJSG1gSwozDdSH/Gynt2IGuyvjAnX+RR7CL7F/ie6HKHRvF53VjP0atbcS9KITcjJDzELK7lHWCbDLW9PaS82DAIp/p+Y5tCfvefrKPw4fqOJwrT8pxF9XMEFAykw76tsnjYX5TwDP3eNsYmHps0v1CUOuXXkaJWCVdcnd/ZpZUXwbmPbfUlT4HgD1sJk8zhL/nod75Glf7NKsOMoQj0u19HKXyDWtBIWV5rAIHPZ3eecddJ8OjzSVrbpY5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrXw86Kw3AysQ1gdJJ3iz8GwkbRPBDm3HTlUSA8Z71E=;
 b=KZxe1/kttjHeC6BtLDZ/nUxe4FkwNl0o9GY1l0FIeige4VzD/DFiuid7gwabSc9mxy0qroxjkroFIKHmC0mXMgEbvXrOtoWLKO5uOplAsihEcUafFtZuceTfpuQXvDhIxhS7FSh8Goj6CZiwI3089HVp494O3xBCHhPHWyBT2Ik=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM6PR12MB4532.namprd12.prod.outlook.com (2603:10b6:5:2af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.22; Mon, 13 Feb
 2023 06:05:02 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::27cd:5a5c:4713:83f5]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::27cd:5a5c:4713:83f5%4]) with mapi id 15.20.6086.024; Mon, 13 Feb 2023
 06:05:01 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zha, YiFan(Even)" <Yifan.Zha@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Revert programming GRBM_GFX_* in RLCG
 interface to support GFX9
Thread-Topic: [PATCH] drm/amdgpu: Revert programming GRBM_GFX_* in RLCG
 interface to support GFX9
Thread-Index: AQHZO6N2XK3o4cYWYEGcHtCZ+uK/8q7MZMMQ
Date: Mon, 13 Feb 2023 06:05:01 +0000
Message-ID: <BN9PR12MB525737285CF369698F9D87D7FCDD9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230208095450.1000441-1-Yifan.Zha@amd.com>
In-Reply-To: <20230208095450.1000441-1-Yifan.Zha@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM6PR12MB4532:EE_
x-ms-office365-filtering-correlation-id: 5d0d5548-5900-4906-8557-08db0d883e5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yFRGUJ6cjYO6dXZoj1n6af2ZECYoq5sTf4M3ylQA0li9u/zn8eqnsfeAD3//sQGmwZ/51RPZIkVwQ/WxiZtfXFG09l6m9dPdc3rJiXVGL64oLcqkFO9EgfQHPiesVG4lC/reuDCe2DFcHWVt/DzrPtKSj66A5C5C3FlSSnImHmCUpZv6212rEgDIBkGCETbSg8ToAjjlEYqOGJKOyl2x74F4xtTjZnrRQBr2Y/QpFqaBNbnOTvgn7ZHK4SJ2OwUwLZUR2eqRBv6cYwfYHBYOdIkW9q6bUaDbKcqUHuiNAbeB2gblB2TvxsKc2nSozQQUTbRHyXHl1L3s7vwnSn1CPrMXNlmbM45cHcQrZYabkKxj0zpDrqCB5c2J0ytZnLYfnbhp5+9Ajnyzz1OnSA5B/WSH/S+uaj///HncYj4PTsHWgascEwNlb9kKnH9ykTW/QFqg0pBdcuWZ2kFDWIl9h7DFD/GTPeLFxRxjWt23wEAH7dsOnbHY9MxUPvGye/9EIHrdMhGBSALPgVoi3H+fHXE3dQ8NMAoI/dJg8sz01WPfTQq/PC0h3v4ZWzMgBns4qu8IlcgGCcjxcy8jZHRichiNV4HqlfPtsrBtAqrp3cCqskD3+xC7rynpif2aZFGQ9ADTpU8FdF9ElneogbQnDiEVoGxdedPqyGHK8vwFDp9qdQs8gsrrWluTF8JjoOviKoO1OOV/AwOHrjMzGpXF/A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(39860400002)(346002)(366004)(136003)(376002)(451199018)(86362001)(9686003)(186003)(6506007)(53546011)(38100700002)(26005)(122000001)(33656002)(478600001)(2906002)(7696005)(71200400001)(38070700005)(64756008)(66556008)(76116006)(66476007)(66446008)(54906003)(6636002)(52536014)(110136005)(55016003)(66946007)(8936002)(5660300002)(83380400001)(8676002)(4326008)(316002)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MFi9ASNGoVXF1gjCOU3nKQUpXCqnV71jClBTlGWevaSXlOpZZ+61pc7J47KD?=
 =?us-ascii?Q?hRd+efZE54uR+dFJJHluHFsWNCatonoNaUagn5vpbEnnK9gMUK7XIyXuzc+L?=
 =?us-ascii?Q?9ZnapZ1a6y7QuuOtjsviS50unIz5WGxHpjaEglxG1vr3TvojmhZmz1KuC2Ai?=
 =?us-ascii?Q?R13xVPNiAuMU+oSB3xP4gArOJPhYEKMjCKKhVMsE2xRFJ6EM64pfhI+5FOFV?=
 =?us-ascii?Q?ywag8E6M+SsTXtLuy8gVr2WZ3agudx303PPOILIkSBEWhto3deLULzXyuoeb?=
 =?us-ascii?Q?BS3G2crLPHoeCYSBz8RMlO9sp8Ct5Gsup1VwDyy83sGs3FMCYzr7E6IfxUm0?=
 =?us-ascii?Q?F81nSH95W5xEoBSRGGMOxc+ogVAg4gFooSIX3KxFSiFzBp5JdVWsy7N4MlTH?=
 =?us-ascii?Q?TJOsGzOw4aYWrVwl5930OzxQeBhiPa4I8GxleyJ3u/3Lvw9qXFCKaLM8HSgR?=
 =?us-ascii?Q?e1Ffpzh2KXUtbsG1dNsDIXRXDNWPWqNIhfawix5EnfLSJzrJSbCLbUQWq9Dj?=
 =?us-ascii?Q?X+oRrhkYRZ1j7EU1JuNCvER0mXp7nYV3kqGLq4gOtueDtQc5TceRtGJKUftq?=
 =?us-ascii?Q?327KgfRJOoVXK1vQZe4sn9JB2OkX1oLa1MvB1zD4hYUHXlTfYdjUqfTAklyZ?=
 =?us-ascii?Q?gd/bIHodsHxXu7m6xQI0szh6s6AcngE4bgEdhG4jE4S5S3/Mqg6phdzvCgve?=
 =?us-ascii?Q?mLQcAXE85+m73OtGNtE7Ba1e4HDwQQ5djf79auMpYX/e1jdBWzOUirBvy7u3?=
 =?us-ascii?Q?zF/fCjAGu4OUE7bUy0gsGExTD5WYAY3XPA6jGOCFaaCv6PgrRGduHaKkzM8v?=
 =?us-ascii?Q?BvMCjDYipOkOLXXbpQZO6GLTzsC/RAm9HUTLIoYGyDH6mx6xIu5vWrsrIgki?=
 =?us-ascii?Q?TiH77UyGkDzqb/9sqm2PllXYQBiYh5aXyO1rHAEpHlzQDq241dSgJQHxlaFg?=
 =?us-ascii?Q?rGdwdJsAV0psl9+TwpKCGXecX3uFXYAhkOmPiin69ODvR7FxeoLfbsPN+UMi?=
 =?us-ascii?Q?ToVYeWJl9Xvl1OGUmCJBszCChskhMR13j5Si9YVO4RDE6MeP7169pkH31YPe?=
 =?us-ascii?Q?8eTPi6UKfYS6Z0VFB0eWn16dXlNywDdqRARW5nRS6ijL1/OvJI5BEdwxzE+i?=
 =?us-ascii?Q?4igI+SFXCYGRFLIUGJ9vFUt0nSgWJwxu8fRS757nFkz84OWs3W+vOkh21g1r?=
 =?us-ascii?Q?6lbC4/vulkZr4mc5M9OkXDeuKh/LXTtmeexN2XCEwvO+Al9tV5VO41Dc+ytJ?=
 =?us-ascii?Q?AuuEcgB/e//XbqRpv4yO7a+okQZPIbZmC3LrI9tNS1xmqFl+Vplh799CP6vK?=
 =?us-ascii?Q?rEIS5pg45P3PNGl/iiFDW9u+WIOqFr74tOUdkk/rm38NW0J72ZR+kZBt8ArZ?=
 =?us-ascii?Q?2mhplMBL6daC9l7wyaFC0rsXXYA3SB3aY9XyC5TqlHlgPnTjAHCwhZZj0Yj/?=
 =?us-ascii?Q?lSBTn6rn0dOle9pk9i/y9zEKcK1tX8JSLUY8Zwa+kUrQq9oafKh7Vnygwq0R?=
 =?us-ascii?Q?nCkcSzwWMLDVgJzxvGa4v+UZtHeOlShUvjv6kUGjrK1CC+unUGMg1BmHUOd/?=
 =?us-ascii?Q?fwXHjUB8pBac91by3kyFihZ0e7pUlc4X34dQFXK6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d0d5548-5900-4906-8557-08db0d883e5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2023 06:05:01.5996 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eKWCdaZDwi91GJQSk4XUcmogQ/V1bEt+mBwNlGK3gCtSm19M64I2GpfoLqJPh6uPDzd50A8CSjMVqUoj+Lw7TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4532
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
Cc: "Chen, Horace" <Horace.Chen@amd.com>, "Zha,
 YiFan\(Even\)" <Yifan.Zha@amd.com>, "Chang, HaiJun" <HaiJun.Chang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

-----Original Message-----
From: Yifan Zha <Yifan.Zha@amd.com>=20
Sent: Wednesday, February 8, 2023 17:55
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Cc: Chen, Horace <Horace.Chen@amd.com>; Chang, HaiJun <HaiJun.Chang@amd.com=
>; Zha, YiFan(Even) <Yifan.Zha@amd.com>
Subject: [PATCH] drm/amdgpu: Revert programming GRBM_GFX_* in RLCG interfac=
e to support GFX9

[Why]
Regression of commit a291321cce8e("drm/amdgpu: Remove writing GRBM_GFX_CNTL=
 in RLCG interface under SRIOV") on GFX9.
According to GFX9 VF using different method to access GC registers includin=
g MMIO(direct) and RLCG(indirect), removing GRBM_GFX_* writing would make P=
IPE/ME/VM/QUEUE selection chaos leading to some OCL benchmark failure.

For example,
using RLCG interface to program GRBM_GFX_CNTL/INDEX for selecting MEC(actua=
lly the value is only in scratch2/3), then using MMIO directly program a ME=
C register in VF driver.
The register programming are invalid due to GC switched to incorrect ME.

[How]
With checking RLCG accessing flag, keep writing GRBM_GFX_* as a legacy way.
But it is still skipped on GFX10+ to avoid violation occurrence.

Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index ca5a1d026f5a..f2e2cbaa7fde 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -983,9 +983,13 @@ static u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_devic=
e *adev, u32 offset, u32 v
 	if (offset =3D=3D reg_access_ctrl->grbm_cntl) {
 		/* if the target reg offset is grbm_cntl, write to scratch_reg2 */
 		writel(v, scratch_reg2);
+		if (flag =3D=3D AMDGPU_RLCG_GC_WRITE_LEGACY)
+			writel(v, ((void __iomem *)adev->rmmio) + (offset * 4));
 	} else if (offset =3D=3D reg_access_ctrl->grbm_idx) {
 		/* if the target reg offset is grbm_idx, write to scratch_reg3 */
 		writel(v, scratch_reg3);
+		if (flag =3D=3D AMDGPU_RLCG_GC_WRITE_LEGACY)
+			writel(v, ((void __iomem *)adev->rmmio) + (offset * 4));
 	} else {
 		/*
 		 * SCRATCH_REG0 	=3D read/write value
--
2.25.1

