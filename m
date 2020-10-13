Return-Path: <SRS0=VV5o=DU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CA5C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2020 13:58:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A836924791
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2020 13:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Mztghji+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A836924791
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 489896E8F7;
	Tue, 13 Oct 2020 13:58:00 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD45B6E8F7
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2020 13:57:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3+Tw/Rwy37KznQaJAY4xl3+Dpnvh66JOk9mDGf/ldHa28kPK1gnd8+AohjfxLnjZ/wNkc89DaVvf14ouVApQnsTrhG8dzQB/AQsdKnlSBJWf6lri+I7Y6UHTXM/AOSi96i1aszhNvbEgqVkiTS/rkpP9M54gpyaF5u35quXPdP71X9BRviAHH15PWYDAyYYkyv8VnCwSzPS3jHap6LFi3aQ3H+blsyGfn7zB6xz8vkmzBjgEZAsF6mTu5XKmv+emlZHixlaGcM9w+BE5pqqoxCNZFaR9fo3wsUjXcgNmB+ipFamiJ8WxyJWp2IlRFQxAoVhphPIy81tMKagtWzpNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOOwlPfgAN45RMT/ph+VVtIOcflna1HYt1dEcYZKdns=;
 b=bBqTH7uLLY969d7j9+PDE8llxeADzi5HtNJXbmZcocLBa6Ddg0oIZ+VyS126Thb+fMCZjLuWmSTEuMfTS08w4lcce3CW58Lu/r1FhALECa/BFECUclLWC3YALgo18alEHTg0mI9lxk+fScyisDOQRiZWkVG0q6H1gTLmLAPNTvtl6VIuIUzyIR5M+/EqvT/068nVSGYjc0OkL64s5u459cF01XaeFcyW4Wv+LmPOrK4Clz/zAL9mNMrdlOJkBgzweAZqW9NJA5EtCGMa2Md9VWVnWzD/c7WbNaMaOWcWuFQYxNhAItngwVvhAkC4QkRCp3eI6HYV9ng2s1q6zHlp7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOOwlPfgAN45RMT/ph+VVtIOcflna1HYt1dEcYZKdns=;
 b=Mztghji+QmRfkrYNuDUPvfTmYQadPG2Xv+aNw0XYCZbJkKnXCMDXAaWobBNK7IJ1Dke+eYXWRs6gCA4FjsYNNwFD6k2z1ou04R0YCM2uqyOfqpRM63JqwpyCydXX6XJR3s8b2ZZAvxg/O5/wgTSPtQ8oXkSQzI8iKN5pYMwFWmE=
Received: from BL0PR12MB2433.namprd12.prod.outlook.com (2603:10b6:207:4a::25)
 by MN2PR12MB3742.namprd12.prod.outlook.com (2603:10b6:208:16a::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 13 Oct
 2020 13:57:57 +0000
Received: from BL0PR12MB2433.namprd12.prod.outlook.com
 ([fe80::bd7a:2354:a2d4:97fe]) by BL0PR12MB2433.namprd12.prod.outlook.com
 ([fe80::bd7a:2354:a2d4:97fe%7]) with mapi id 15.20.3455.031; Tue, 13 Oct 2020
 13:57:57 +0000
From: "Chauhan, Madhav" <Madhav.Chauhan@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix the issue that apu has no smu firmware
 binary
Thread-Topic: [PATCH] drm/amdgpu: fix the issue that apu has no smu firmware
 binary
Thread-Index: AQHWoVZfceHnx7DUYkC4c0vnva25CamVjo1A
Date: Tue, 13 Oct 2020 13:57:57 +0000
Message-ID: <BL0PR12MB2433478C6C17DFF5038F4BBC9C040@BL0PR12MB2433.namprd12.prod.outlook.com>
References: <20201013114502.3479215-1-ray.huang@amd.com>
In-Reply-To: <20201013114502.3479215-1-ray.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-10-13T13:57:49Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=f15afd5a-624d-4976-bee4-0000d528e9f2;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-10-13T13:57:44Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 65c8b557-b575-42e0-b429-00004cf9da8a
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-10-13T13:57:54Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 0f6d521e-72ba-4c9f-a671-0000afdeca02
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.158.249]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: af03d3c8-87af-46ff-81c0-08d86f7ffd32
x-ms-traffictypediagnostic: MN2PR12MB3742:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB37427843C54303A87A17CBFA9C040@MN2PR12MB3742.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RlT+FfslQqLRyapcuK/GJKVMHtX+CE1N5c+04ryfQtwO0ycBFTqNa8V4KHSvgs3GI0+/jsPturJlkY04Nl4269zu/Pt4LMDxBkpbK/bVdyIN844iz6EvrUVcJBQBRyRD3lzu0UOD/DjLy23hcXoel6w/SjD1m1UyR9av39mt3HeVenmAeoosT8PV2bHeCUBRRslgPz5bZaMp+jiWq1IguHW6T6cy2xmNVf+zyjL9RKSsRfFc1fXHXhsJnZHqdmmZq1jyA0NXZy9zZSMXeDwBqi/u5qrlGIzn8vzLwAM5qbRNxs8u/VTVqHx4TkDSJ2DnQhg8/SMWudUro2ZcHmOuJS+DHW+qQkRkWQ4pzJhV3Xo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2433.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(4326008)(83380400001)(71200400001)(966005)(86362001)(52536014)(7696005)(478600001)(55016002)(110136005)(26005)(186003)(66476007)(64756008)(66556008)(66946007)(66446008)(45080400002)(76116006)(6506007)(53546011)(8676002)(9686003)(316002)(8936002)(5660300002)(33656002)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: M8H1uH4G1Ad2kf35GBf+oGogQxBvHEFrPgPRfsRd7OKwdjQpIbwyQ+KL0rX7pgwLIlQbcWsbPxZkA8TfBw5RPOm1m11Cctvg2yxbdRQs7gkyDk2Pv101VQYQBNiw6uIixn30druXLED1CtFTnTHgd6AYnoDK10eXT2eDPRDN+djCZlyXkwrud1ZUAzCpaPuGf3SSP/RATMCjwLMzoimC/CScrxkQEhfGDfJnM7/74UahkJIOYZN+VhpuNFY3iRPN7DhPz9gH+sd2cVe8TzDLBPYlzg0r88Pib71evt3fbxb5Yv04arqTyRmkVLP63Xnt8z4sJtHtrlfnJayDgmtZXaU3ff0cJLKWm7pk81WAXcDsTPYcyN6GrqpB3U5kWLY7CKrXNeIFMF9NgLn5pqLgAjOeqqjmZeXP6Q0VaPhCAl+fumiRyWSZzUbkXA6KOr3uZStR6Gqx3wBUyQKU5Q5/4Udl/TbDIye1nN6jb/SmbGtotvvXIzpzVJqaM2d5bfhOQJTFXnsd3w58u5NwmRrYYKs3DxYBYXwKcquVc3XHQTnLpb1zBu7T/zNiqaWxEaX92YSkbUGVF8zez06dCjFkpEpcVFMC8f0Cn6eRsjpkr6WA4BT8DYt71zhvamkcKJTKajPZhRLHQRMvUF5UArrzhg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2433.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af03d3c8-87af-46ff-81c0-08d86f7ffd32
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2020 13:57:57.1700 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Va7yvtWRwWuiVbWtko0sqjjAyBgG4j+3cj8KreD+ZCSWGENzI0A32l+4DlojyjTnqUYTrrzO91vH2A91A3jrDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3742
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
Cc: "Huang, Ray" <Ray.Huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Huang Rui
Sent: Tuesday, October 13, 2020 5:15 PM
To: amd-gfx@lists.freedesktop.org
Cc: Huang, Ray <Ray.Huang@amd.com>
Subject: [PATCH] drm/amdgpu: fix the issue that apu has no smu firmware binary

The driver needn't load smu binary on APU platforms.

Signed-off-by: Huang Rui <ray.huang@amd.com>

Looks fine to me,
Reviewed-by: Madhav Chauhan <madhav.chauhan@amd.com>

Regards,
Madhav

---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 9d31f9339e02..042ad5e4292b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7049,7 +7049,7 @@ static int gfx_v10_0_hw_init(void *handle)
 		 * loaded firstly, so in direct type, it has to load smc ucode
 		 * here before rlc.
 		 */
-		if (adev->smu.ppt_funcs != NULL) {
+		if (adev->smu.ppt_funcs != NULL && !(adev->flags & AMD_IS_APU)) {
 			r = smu_load_microcode(&adev->smu);
 			if (r)
 				return r;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cmadhav.chauhan%40amd.com%7C2bcdef4a06454092df7708d86f6d7f8b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637381863391100528&amp;sdata=gc%2FJ93Fwzz72RJEJnNKGzZV%2BBfKuG2jHUZGJE8PuBxA%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
