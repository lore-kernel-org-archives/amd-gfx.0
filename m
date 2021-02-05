Return-Path: <SRS0=LS4N=HH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F41C433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 02:18:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E825C64F3D
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 02:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E825C64F3D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 795BB6F3AE;
	Fri,  5 Feb 2021 02:18:30 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50DC76F3AE
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Feb 2021 02:18:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9bQygoqamUpG3WBlUmJIKvzSwBsN19bjIwao6Fsfr5+rWnvBo/x60M2LnPpGkGLFH2N6gXLBctXMEXctU1e3ZIcXeNqREtkWkO9sYTz25PL1IAIipPIUAiC97HmiNx636Dt6LOxE31y6c8FsN0d1GEtNb7xQRT+WyWt51Z+oyb1E+JVofLiYhzTZtIo0rIyx+qE4C8oRkeiUP+RXmO3F3geCmHCEMxLAXBUCHpaR32tjX1LhbnRLsWH3KOSi+d+O/pV9W2WxqYzV6xMuD1o4hD5RcRVRQ3XlnHGxo9+BK8jOooqIvBjuxz8ElWNc2+xsJq2acTDoHT9ANLLx4OfZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcFaoAOQXLBBzEAABDkq5BV8GKjGAg1pyvoGOJS0Owo=;
 b=jNiJj6cVq2FtytAZWmcrcjSIDqczae1sIQurlD75YTUv7vk9STbV9pgCUfZxkkVjEv32FHD56lfRY/7Aohz/n2gVyl/tgmH8pO/cFmRGcv3EEICIKhuHWF7UPg9gJPeste9DcUQY/DsPrIOlC+wZU0bYTWX8Ymd1zQwonGCLVcfyrdDL1DnlP1ElI3njij0oJlP6bAslfjzqSmlaFXfhG5Vfpk+EgA4JCwiYkfncvmsPqpq8J+JTBZnIuLnrGZa/Nfb9awSTEW8mt7i/FjGNRbRsiXQenTm7AEjIQVVEhJh2XiW4GVJCCIsPyFRL/TaxmH/SyJY5SefVC3SapkFlIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcFaoAOQXLBBzEAABDkq5BV8GKjGAg1pyvoGOJS0Owo=;
 b=cqV5GaNSY6jfbG/H3Tv0+X6IlBAE8NAI4wL7hr6PT+RUJSmHMIFnVTYx8j9u3y4EPu64EGiIqK/1Kyzvj80Tgxu13f2JAKnIFZsUDrdKLHJOvcViSgAnzMOfSx7N9HpcIgb66/o48+FyTmjsFRC88dyeI+7NvwhfyJFRv+iy95w=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4748.namprd12.prod.outlook.com (2603:10b6:5:33::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.17; Fri, 5 Feb 2021 02:18:26 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0%3]) with mapi id 15.20.3805.028; Fri, 5 Feb 2021
 02:18:26 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 7/7] drm/amdgpu/nv: add PCI reset support
Thread-Topic: [PATCH 7/7] drm/amdgpu/nv: add PCI reset support
Thread-Index: AQHW+yYtuPwssI4sMk2z1LzYXqSfgqpI0/IA
Date: Fri, 5 Feb 2021 02:18:26 +0000
Message-ID: <DM6PR12MB26196C0A34817BA9DB639200E4B29@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210204184706.168934-1-alexander.deucher@amd.com>
 <20210204184706.168934-7-alexander.deucher@amd.com>
In-Reply-To: <20210204184706.168934-7-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=1bdf8fb3-895a-4cd8-b72a-219bcf3d2930;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-02-05T02:17:58Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bd2b0bdd-4eca-4712-5469-08d8c97c526e
x-ms-traffictypediagnostic: DM6PR12MB4748:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB47489CF37BEAE35F8B35B2E5E4B29@DM6PR12MB4748.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iIUgf+bYFS9MPuP1DfmH+f9hOPjAmw4D6WL4vZMZhwlzGVEZmzQ65BhKGqclz0ZrGojpxtirR72dCB+OsGrpcLE915bkJOxdZUW2P+MBIKrxW4BPZLPp0aiVb3Pdh8+x5SOi4wkuSH/HT2gZ5820t101j4PVbAoWC4hh9D+/AfBKyZKhZ00JJ/wtH7OlxNP62EMz5+xwmjsjM4VIP9ZD/3cxUZzbk+/NAbtsaYr4Awdco0QbQr05i3VaS+n4Uv+FP9a2dHF1FUWRmTvCr4/B0Nl70pthp+pQjLZOnzk2Qlh3deVZP7imHdN1UCGwgpOaNN9cIOSC44veohkrErciDn49krFgAWVvO9pDeH4BdCiAEkIZqxTR9OxRHZYqR9VpxjcbraOcv9xsgFvM3rNP748E/XIAkJXnjTHQKYhZ6RJOIENcEBqPmD+pqMBVQE/67bg4C9qqzr1Xqh3+6lUMa1fo8k0YbEpEQT7SiK/H9EAg0aJwfXSp+/owRfKQWLrHqumiOjKkoFhgOqFBOJwNcXq1CTinaBhLmK5NePMI8tE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(39860400002)(396003)(136003)(110136005)(966005)(66556008)(52536014)(55016002)(6506007)(26005)(66946007)(33656002)(5660300002)(316002)(8676002)(64756008)(66476007)(53546011)(76116006)(4326008)(186003)(8936002)(66446008)(86362001)(9686003)(83380400001)(478600001)(7696005)(2906002)(71200400001)(45080400002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?TB0vsWv5/71Pf+sBZoL9qgEzN0cEYuU9SewWM2xuz0OGA4nEZ3xyzd/lLPu6?=
 =?us-ascii?Q?t1Ku6oQWR367GTyMSy6lsTcmwz+PHfi/21tAicZwkFV/JT0KQJS9MY3zyck6?=
 =?us-ascii?Q?6VrygHQ7bvSf0IEkm0Pm94dKckO/L1YK/E1zGxTVMeeOase79/BmTFHV8vN4?=
 =?us-ascii?Q?uHnwljU97XNYrcH+lnSTrBpWVjOC96RVYaP8bF/r8Kt8KgVrygW/XeLN8DFs?=
 =?us-ascii?Q?wuWJthQu5hf05731tbDwqXAD88WP8KHdivSjg9ZpOLtaoO3p3wD5+gVENRIq?=
 =?us-ascii?Q?q6cuYp2yqH/mvlNw0GgUZ3k/5NwTwrAOnCFOr+VdNhxUWn5Ef93/EEPf64IY?=
 =?us-ascii?Q?RrNc4t18icTpttDr63XjIA5q0Ftn8MOZWi6UOL+GYPpKyGD2w3kgncmhKVpH?=
 =?us-ascii?Q?SZKuGQGiRgnPLD48DggRIByDuxgmQalh5/eNcXrPL08GD44BuBd95VcFHxAD?=
 =?us-ascii?Q?pOG8bSJb+WGv8iEiOW/tUE23nDHpaF68SlH94lvTSGuWxgSSkmDDaiO/z1N1?=
 =?us-ascii?Q?aQznvoKuTr/dNCdJxbSiciX+iD7ZL/Fcl/EL7ee451wOS23NMVzI4UCnU7bl?=
 =?us-ascii?Q?S9gmxIcgFgQ3E7VMx2ujpBXnTcTrQAoge2AH2w3h45c9J+KCclV/CM828InC?=
 =?us-ascii?Q?zE81mgX8RTOc1F/ClrElhGO7mk+BzvBe6cw+NhFlGYR3fW5f5W0jvY+9XcrR?=
 =?us-ascii?Q?YDels7hEHwnaSUQ2jl4ty+DUs+WsoArb/ysdJiWmGZJz5JokEVXRgU3zcSFU?=
 =?us-ascii?Q?UbDAPsSVt+yD0XlOSdq4XMglYJaZHO/vPOVNAyI7GnzLpC2tBIoHPL7YgcR7?=
 =?us-ascii?Q?7aWXLdGJmzMgHpjEupQfuiaE/5i4ovaG+hGybEJ9Ph9zga/FeLC71LcSZwzf?=
 =?us-ascii?Q?z+ikZ2akGEl2VOiUOYDi9BKrfWydvhmOv7Zi3RxW9q+c2/g46PJealnrZfYy?=
 =?us-ascii?Q?xoWnlyCjUDSn0S+FhmgGnJ2uFXWHcjbWUseSfLO6yuKrK6LeIuVmwn3C4Aoo?=
 =?us-ascii?Q?nruwk+bWUXNxsocYR3fuf2HjM3wX/GmeO86BjVUVQkIsv9Gjgpqaa57mDloZ?=
 =?us-ascii?Q?VqvU3n8pV3fYcseRxs7o/9zlFrElTpCqenDC2pQjk9KTKVJwN93np5TqLctD?=
 =?us-ascii?Q?cwbdYznCR3jS/8f9/MLAYHSZWlWC1Ov5APWp51VDvZjbkK4bKiQjnhQfOTOa?=
 =?us-ascii?Q?cfk8zBASAwlDxBsOGrlDIfS826MvoPDBYNhD3H91J+nnqLo2dDJmm6ejBS/J?=
 =?us-ascii?Q?MhCza+qV+8Yw0JDkhiA3KZxRZUhfg9rSifw5Rirn18VG7XZ5Xin99nsJKb7x?=
 =?us-ascii?Q?H1nmCveJQHyoO440Tdyib7/i?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd2b0bdd-4eca-4712-5469-08d8c97c526e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2021 02:18:26.7745 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ha/4ofW4txSBGfoJJbsGnz/9++D87GMc6U2XO5068+W90vgFz4J3+6S8zACn0aYI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4748
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Series is acked-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Friday, February 5, 2021 2:47 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 7/7] drm/amdgpu/nv: add PCI reset support

Use generic PCI reset for GPU reset if the user specifies
PCI reset as the reset mechanism.  This should in general
only be used for validation.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index e6878645df93..227e4a5db10e 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -564,7 +564,8 @@ nv_asic_reset_method(struct amdgpu_device *adev)

 if (amdgpu_reset_method == AMD_RESET_METHOD_MODE1 ||
     amdgpu_reset_method == AMD_RESET_METHOD_MODE2 ||
-    amdgpu_reset_method == AMD_RESET_METHOD_BACO)
+    amdgpu_reset_method == AMD_RESET_METHOD_BACO ||
+    amdgpu_reset_method == AMD_RESET_METHOD_PCI)
 return amdgpu_reset_method;

 if (amdgpu_reset_method != -1)
@@ -596,6 +597,10 @@ static int nv_asic_reset(struct amdgpu_device *adev)
 return 0;

 switch (nv_asic_reset_method(adev)) {
+case AMD_RESET_METHOD_PCI:
+dev_info(adev->dev, "PCI reset\n");
+ret = amdgpu_device_pci_reset(adev);
+break;
 case AMD_RESET_METHOD_BACO:
 dev_info(adev->dev, "BACO reset\n");

--
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7C6b300fc57a984e5e0b3908d8c93d4f31%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637480612452615567%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=uRNSs4Oil%2Ff14MQFnbRYw%2Fic7Trk77eyesIppwQx37k%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
