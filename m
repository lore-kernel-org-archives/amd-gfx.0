Return-Path: <SRS0=vakm=IA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0997BC433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Mar 2021 08:09:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 914166146D
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Mar 2021 08:09:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 914166146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B7076E90D;
	Tue,  2 Mar 2021 08:09:18 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770048.outbound.protection.outlook.com [40.107.77.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 493436E90D
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Mar 2021 08:09:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TlCy7rvNrSlopnqoxqcBOmYqrOmNC3nbtd1B5JQUmtvtxDzK4IFNHys30Ld05Hi5QMunvunfQzX7j5TyTcy6nI9jKmcUqfkZLNk+VsZAuKnisuXr3x5ktGGrYznp5IvaLe7KcwolEk5CIiZpRMdYdYeDnAj41PpcLJntMjeGWEVBBzSTS0olsFTV8bXX+Ie0VhhbvtZgd9UVYACDCHGOSFDgpSEOSk4S0OdyTpzeQZeVsaRebO4qYtzqFhrNlRPgfqQO5hKMs6qKLaYc5ANhv6kSNW7eO/lXwrujyJjisGWh49AIF8BZq3bCOVC4pluc+xZrjZGIaS1HxBxi3q2UHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LC3FId4zkdzMWzbXgHiI7TJRuQXl9U4Bkn0M2PMQhpI=;
 b=nRHxlza/y1yzwVZb1FFkIvcwR9qfGE4nGBeuQgLyRiNq16sv8olK5ZuvOxIDd91MsAancwi4hWDva3x0lddtE3dmeH+GP9VUE2mfjkcvdkYq6Ql3QFG8ZSVUH/LbyN7a1e2uwj+IxjzxrMmS2Me0DZH2chN+SGD5m40ogh3LJLxk0JOMj0/MeZBSU4bfwpBKs2OCQP+riUHW7kHNkL1NiuA5B6FCvJRTQKqL2vOWr4m95F5XQN44d2/UqfGgxIZSYkIzDBeXBR9eJrDGftMf6zcWKg7NucASqjahXlcZ2hJXdfNC7U7f2QDJep4rZtZ+NhjcjmImRFk6rigPKJGFNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LC3FId4zkdzMWzbXgHiI7TJRuQXl9U4Bkn0M2PMQhpI=;
 b=5BWausxq3K9LLFmcqbIBq+6b0h+7GXBt+/SIRyDyytDFGH0XQEE0PK2V2KqgiZSA9LitvOp+82hkZbKPS/HNUYyWpFcES/rlX59TyxLpOcBmEYAqr71noNxRkZZ4HWPSAyQsPUom31FFX2bfJOPbg0f51x63lpanWMYMQgMLsl0=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by MN2PR12MB4535.namprd12.prod.outlook.com (2603:10b6:208:267::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Tue, 2 Mar
 2021 08:09:14 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::c1a6:7b2b:9494:776a]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::c1a6:7b2b:9494:776a%4]) with mapi id 15.20.3890.029; Tue, 2 Mar 2021
 08:09:14 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix parameter error of RREG32_PCIE() in
 amdgpu_regs_pcie
Thread-Topic: [PATCH] drm/amdgpu: fix parameter error of RREG32_PCIE() in
 amdgpu_regs_pcie
Thread-Index: AQHXDzqnmgW4Ts3lZ0ia4OOa1W+ugKpwV9yg
Date: Tue, 2 Mar 2021 08:09:13 +0000
Message-ID: <MN2PR12MB4549AD10161346BEBE0D58A797999@MN2PR12MB4549.namprd12.prod.outlook.com>
References: <20210302080348.7101-1-kevin1.wang@amd.com>
In-Reply-To: <20210302080348.7101-1-kevin1.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-02T08:09:10Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=8881b2dc-44b3-4bd5-9ad0-c2c24cca4c8c;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.159.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3add9935-9906-4d16-8cd6-08d8dd5277e6
x-ms-traffictypediagnostic: MN2PR12MB4535:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB453562CFC481174D1654EDE697999@MN2PR12MB4535.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nCiEQD0l6YnDAPdqUVScmZ0qnQzdtrxFb0yfQyT69wMt8denmCiT9NXAygqrckejRF5XLUJNULS/f0fS1idBjSttIJajqtd1GjIy6qBbfxqmsdEl7wyLh4k0Cc9JSm3sMsJQVOgyId1KmvCwX35iG5xI3aX3I6wwhs4BgCTo4um6DmUunkrmXZgf2lTJnO/s59FdRIeuwFdJfZN+JbG4D2bV2hB5l5AkanNfHa+LGLYFPIgKN0Mi+JP5Sh/s5LU9XHgeXzwndFzNMNDkRvBbavr3qzwLwdqV9ZJ3aDfKb3Qh6k6J+G94Gn90SqZkgOvJOsiU9IgSh/Aan9jJtJrMjuS6PJid8cB/MJWIjMMPSHtwmKzEnq2awBL0pmAZ1LV/3ccuXieR45GLMmcIhImAlUhR9zBnmiTp5u/GVPCXHlCuIMTsv1Cp4JWbq0lB7O08oKiXLjCnvKgy3WqEoLOyTf8pwj+/dkgNhZQIwdSISr46T+RzrvZ/aq0U2TWgThuIxYPfYgkVt83THRssv3C7EQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(110136005)(7696005)(8676002)(186003)(6506007)(53546011)(26005)(33656002)(55016002)(76116006)(478600001)(8936002)(5660300002)(2906002)(4326008)(83380400001)(316002)(86362001)(66556008)(52536014)(64756008)(9686003)(66476007)(66946007)(66446008)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?M+SqvllhHhoo30HarEter46nnLsBaPI+Mc5H0Iecz5MonB9tY9FqzZzCWtIo?=
 =?us-ascii?Q?3+11EDmJnzSZ1sR5A38oveCWfIKArBspUVLdlpBE5tj6sBegEQNE6bdATgXx?=
 =?us-ascii?Q?6wuFrnTOn8DKWqqKqtWM2lCHbeyCDkRrE0AK65NDRhS9kzos+ZtKhKPQm45V?=
 =?us-ascii?Q?f/uhhc97YeAMOT2IGLVHwyUebsmfSE8qv/WHgH9qN7PCsAV+8kJ62jB0hyL2?=
 =?us-ascii?Q?P3MCKkE/KKXiY+i905MXS4ugD2OkEANb0ThPblGQzFRcStfvjcMv54eszg63?=
 =?us-ascii?Q?NsYmLvyZosE/eX8Swfn2X4gNtAV29zQ2VjE8mGRPuyAdfSGjyR8AvHsmrBDN?=
 =?us-ascii?Q?IWOhPpO3+Papnu2D9TwMPHptWC2w4P1+7hotSQCyT3bAsb6uU4ffphJwwpZT?=
 =?us-ascii?Q?/w94Es+ZKLWg2RN6KeAp3QjTnGzZ65jPDvBu1mjzUMS6PfIw0QCKXf5GNL68?=
 =?us-ascii?Q?gq0NWPYW127FqdTEx0SZ3VNa1m5aqVtRtI8sNfwTekpnjQ7dCcjd7lD0P3D1?=
 =?us-ascii?Q?xVNDmT7MtmNXHw385/2fdJ+7PYRgB4agdH2eSuUoA/ugwpl+zmiXdis2XXAH?=
 =?us-ascii?Q?mWev7Z4EvKxDPbDRqA7fMCAHVfCcGGkguWNehoBYhdN+E8dTGYXXXb0yez4j?=
 =?us-ascii?Q?GERHe3/zP5w3gRnNVFfews5q50AAG8Jm181eQhvt2n9xVodT2oEh5cMM4es6?=
 =?us-ascii?Q?FWviIwJy7H+tc2ecjUzFPDRs6C+Z4PTg/cochesjt9IYWAlOEhHh6caBZvQi?=
 =?us-ascii?Q?ByutYprMx7Ht6NBRyyagfbKW03u+6fN/GhEmmby5+LCr8QwFHWpwGHJ1gTnQ?=
 =?us-ascii?Q?0cnG10u+u0OvJecStGfqDqOFTz2sCMZsxlIk3PFxcKN1eYx8bgR0drHfLG7A?=
 =?us-ascii?Q?+oeRqeDMTvfRsywLRTFRlhcY1edr6qMHu9DANzrB/pawL5rDNGErMVQwoBG7?=
 =?us-ascii?Q?jNny13j13U3AcTXQyDVOQr8i6qZdJm9ZoiWPNy67ZfkhYFVbHBPbCWju+xmL?=
 =?us-ascii?Q?GN7Bm6KZiyeApe+W808UGpya4DC/GX3BIrOevTwSpuAck8gP9x4MIwY1bhgw?=
 =?us-ascii?Q?S/ZIL/Rl9/k1RSKkfmcPYBxmGYG5lnXEgnrnIx839V5ShEvkEt+7LuI/z5Qx?=
 =?us-ascii?Q?6tbA7l7e939O2XT5C8OpkRYbIZH03w1JpynbJImD22kvvPrHmOOu+v0kAckS?=
 =?us-ascii?Q?J7ZeUNM/m5vM5ATADwyy0zyMA2Qx9fHgO5kCNrEgWe3atb+nDUnOlAoGkoee?=
 =?us-ascii?Q?v1hvQw2n+X8CU9L6bzZJ3TB52dCrSEkDpltfEP1c767+N4Legiw/rdXRG5rF?=
 =?us-ascii?Q?AztrJz8BW/pDxaa5BXZrBZed?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3add9935-9906-4d16-8cd6-08d8dd5277e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2021 08:09:13.9359 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZfheSZyVVKmeSM6QFbSleLk6pkm09Nn/ttF6HNzowf1HeXYM63SCE/uTz8FRz4IZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4535
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Same can be done for pcie_write also.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

-----Original Message-----
From: Wang, Kevin(Yang) <Kevin1.Wang@amd.com> 
Sent: Tuesday, March 2, 2021 1:34 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Subject: [PATCH] drm/amdgpu: fix parameter error of RREG32_PCIE() in amdgpu_regs_pcie

the register offset isn't needed division by 4 to pass RREG32_PCIE()

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index a09469f84251..f3434a6f120f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -317,7 +317,7 @@ static ssize_t amdgpu_debugfs_regs_pcie_read(struct file *f, char __user *buf,
 	while (size) {
 		uint32_t value;
 
-		value = RREG32_PCIE(*pos >> 2);
+		value = RREG32_PCIE(*pos);
 		r = put_user(value, (uint32_t *)buf);
 		if (r) {
 			pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
-- 
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
