Return-Path: <SRS0=7JJ9=7Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC456C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2020 06:04:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B75CE2072F
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2020 06:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yc0Jjj+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B75CE2072F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88AF06E184;
	Thu, 11 Jun 2020 06:04:04 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB7486E184
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2020 06:04:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ag+aQzW2DCPM+L5w2SmwHLf0braz2aHTstv6prbeX39HU7vCnT6RqgmMXc/d+zdeRdxwQPOeuidcrA3/PcwNtzd+abbRvzV5YvaNM2g3whBPS3+qIn3OK/opxrTkQY94SvbYRNFdFP7zp4SNQwwf5nJFYb+OvrfOKlIAf7uVFlvaAuQczSbtvtTcEEcziWsrMut3D2tUM8CC+NlYN+d2c+uz3wrpoYd/nwgETm05ETCDFIM1nOLedq+dxRdW3jF5oKKDTt34XPl9XdZiQUUyEqEbgfEky2j+7TGn6lifm7BIrCflhQFSVlPqwNSBMTD+T/9sDMNYw8afQhnaSTVJAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYdwGILYUVqYmWmh99iAXuu/p4AVX9LZ1DBOxUBw1zI=;
 b=hsPMA/PdYrBbK3oKRWIF6miP5oUL6YJATofAjN46G7XtzGwKfHFfpauwVgqc8l8u5hpQa+0bfg2uGsZkWhyntoQdJT3/DHxzFz1hCNMSfstap9P7z2kpUBjhdomEa/AIroRW4Msul4hSPB6TLYPmqziEOc/txrOmdq+aiPUQnxxlAG1gp3Qtbrxnr0wF6bCDycspCeiU6bJT+2HEWkEm5Yw/EdGogv+SkU+UlkYGXh0EDTVmU3C38IpwDsU+eRSaepzUwbmox+iLEMCq6Up5EkBsEIXX85+Sf/NJm/e4/jter3FUc715yYj3V809K6ZzJuLttukQElnyH2yPYgqnnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYdwGILYUVqYmWmh99iAXuu/p4AVX9LZ1DBOxUBw1zI=;
 b=yc0Jjj+EL8VrPDp8u1Hu9RNnJlY+b4AWOx2kt6kCSsTvkULhfaNyt3rTtqggSfzvEJj8Qw2wPanKpcT1Bk/Vq9Vgyzvqq9t1Tx5sWTF+6Vk7XJirDNTB3GstdpO77Rxxuk7MCOUaDjZOJpF/fFG8IT3AJrJKRpqIFK/yzm2mBC4=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM6PR12MB2828.namprd12.prod.outlook.com (2603:10b6:5:77::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Thu, 11 Jun
 2020 06:03:57 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::1833:ccab:8c0f:4570]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::1833:ccab:8c0f:4570%5]) with mapi id 15.20.3066.023; Thu, 11 Jun 2020
 06:03:56 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/sriov: Need to clear kiq position
Thread-Topic: [PATCH] drm/amdgpu/sriov: Need to clear kiq position
Thread-Index: AQHWP7XSZZX2r8Qf10qVk4PKWTN66ajS7K/w
Date: Thu, 11 Jun 2020 06:03:55 +0000
Message-ID: <DM5PR12MB170828CCFC5C02EB1E46367584800@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <1591855311-13218-1-git-send-email-Emily.Deng@amd.com>
In-Reply-To: <1591855311-13218-1-git-send-email-Emily.Deng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8915c8d8-eafc-49af-5473-08d80dcd39b9
x-ms-traffictypediagnostic: DM6PR12MB2828:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB28287C9A473B7EA78833B6C984800@DM6PR12MB2828.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:227;
x-forefront-prvs: 0431F981D8
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: my1VFFb3IcV+EytD8cHXOLvTdnDRjNDp+R6QwzlhiDhuf6XV3vxRCt1rOAvJWrJI2a2qkrn87OsMMTlCKqEZcdq9N/by5L1T4DWo7KKrG1QnP2n1LMOp8vlUltb83IoNDu128aXP/ObvVZ4J913NnIIwJ2C4oqv7HnMZNYF1K0lKZ8gA53IEhS6ebzHCcnSWQtGcyWqOrJWqsCAVjprS9AAT1tsjJZwpwMnBn47JdKMRd8t+FJ4knKfmtAbimDr25LMYptgqbgfE09iO+ukUvnzCGthLTcliCwi70qAVQuRATAzrH6TixsvdxSW0CxQ9Kfs1WwCAqqBhMb6H1paeSo90LoG8ZSngEtP+NWm58iE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1708.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(45080400002)(966005)(55016002)(316002)(9686003)(52536014)(26005)(8936002)(86362001)(4326008)(5660300002)(110136005)(83380400001)(64756008)(6506007)(2906002)(66446008)(7696005)(478600001)(66556008)(186003)(66476007)(71200400001)(76116006)(66946007)(53546011)(33656002)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: fG/gvIxBuQeCQmiCFGTk8VDgZY5tL96TJUNHD1uuh74dA/y4thRP58FFzgBXAp9mx15twJw11bv5hhFOmZ5BCUdnepjBAIOf3AEdPVr9lkjZBOGK0E3biMienfudTq1J1E4QCKFIpKuE2kpafRZz7Mifw4MKhncPcu20fXKOCoIQs+d4mAcSGVuHGhnnhEIhCBiSJS0Wbcj3KNcGjRRaMpu782kamNAyNpaeFBdj5mjdhMBAa9u8zYS5FqOUai0VYBCCmHR4r6tiMew4/e45aIJi+pEeDdWy3s1Kj9l+76Pkf/z8rfRQR6m18J72kVtU4Z/OW6Ii6S+6XG4MT9qRR65Bz2Uv9axFwL855Cocr7UkF0KNjpVdH9vasWm8dJjm260YjlsuemaW3HJfahGsapsAF5qc4okQhfe9UmT3aI53AHuc5e5uYjll1DeWPL/6Y2OxYUBEE35fL0BG8eiSPmDkPoxkPSdnzE2Fh7YgQz9dx4OdMOEzNmzkOK6RBTx9
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8915c8d8-eafc-49af-5473-08d80dcd39b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2020 06:03:56.0139 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QyeT0W3sqmTYauYmjkaPNnwm9/ZPPQtgwlw4lQxKA0KHkVrAyQ/FEcFMAFZ0cicZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2828
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Monk.Liu

_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Emily Deng
Sent: Thursday, June 11, 2020 2:02 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deng, Emily <Emily.Deng@amd.com>
Subject: [PATCH] drm/amdgpu/sriov: Need to clear kiq position

As will clear vf fw during unload driver, to avoid idle fail. Need to clear KIQ portion also.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index e9045dd..323285e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6876,6 +6876,7 @@ static int gfx_v10_0_hw_fini(void *handle)  {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int r;
+	uint32_t tmp;
 
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0); @@ -6890,6 +6891,11 @@ static int gfx_v10_0_hw_fini(void *handle)
 		DRM_ERROR("KCQ disable failed\n");
 	if (amdgpu_sriov_vf(adev)) {
 		gfx_v10_0_cp_gfx_enable(adev, false);
+		/* Program KIQ position of RLC_CP_SCHEDULERS during destroy */
+		tmp = RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS);
+		tmp &= 0xffffff00;
+		WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
+
 		return 0;
 	}
 	gfx_v10_0_cp_enable(adev, false);
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cmonk.liu%40amd.com%7C11371eb6144d4daae1b408d80dccf332%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637274521202983236&amp;sdata=6R48%2BO%2FaIUVocnpshBOfCRYwaN8T22SmArosqtXwRkQ%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
