Return-Path: <SRS0=bDL0=IJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC727C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 01:42:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24FEC64FB5
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 01:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24FEC64FB5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 913B96E400;
	Thu, 11 Mar 2021 01:42:02 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680084.outbound.protection.outlook.com [40.107.68.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D828F6E400
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Mar 2021 01:42:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILoxU7jbPy9SZeZh4iDIN1+w9jlXr406l5PLoNFWgAgioudB8CqubHhEeD4QxHJmJf+3OnWG36DZiZcbhmLI/LIZVAW2jSDh+8XXAP9NvSwxoVg+sYt9EsIcZKuyKKKitm0ZcWAmmi8hwsC3HH8DN/pKTaqLL3ekC/5z12s4jkB9QyUGOH8XnoKoJPZPfi14ueFY42NL/JxRC5qe9eTuxLQ/kPP0HlEc61jFdXLpklx7PuZ70sfW/NBGldJVHWbwvRjU6hxuKgcRCTlD5Q4KfoxujjD1NQ7RZqKMQlDNUMSBCZIJAriwg2tBx7Dfn+4TGOflsjXqcmkWf3M4rO158A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/85dUjbf6mBbyw72eqSjVhfoBj2oEeJcoHZBOhaBe9I=;
 b=Pp0D0Cd+Lo0jnUxGeii3lhLrurR7ramgZn7e6WBkA5Gk1Co+N/hW3x12gLzLVNnjlR+ApCC1ND0kd+AxfIrzn/tol7K/z33pyENMgIkdojK2Kk4z9HJS18xqpXPhuAop4Cr6+yD52UvS3ECsuNrcwHegQ5oMBgGPqFP6UWEtQEuzntpRg7ET3IpZ5GytlgerkfAue3Qc8/NTLC0W4CMRVQCoWKDkrPZDW/RDthRjB0gqtx83fjEnlLwBi85dB06EkaBGnbO46gN/pqka48Byb1GyDteQNcJnrmqMZBeuOrKLNBIxYutyRyW1UzTxmprHQ0WybL707bfoBpJ+Qgel+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/85dUjbf6mBbyw72eqSjVhfoBj2oEeJcoHZBOhaBe9I=;
 b=gYlVSdKUD17mcj8cjEYu9mgK+ur9sQ14o7YKWFkHQyK+poG6L5HU6x/EBI3guEhEaJ0/lJQ2S0NWZtjmS0xK49kWgDAedkhcx2lMweBupSeCcw3Go8fHIRbinrsZOTId7Xg4RC4FBuiJVdzLMz7zNdt939JJ+sbkrWLt/9dgdmU=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4926.namprd12.prod.outlook.com (2603:10b6:5:1bb::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.29; Thu, 11 Mar 2021 01:41:56 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8%7]) with mapi id 15.20.3912.029; Thu, 11 Mar 2021
 01:41:56 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: Enable light SBR for SMU on passthrough
 and XGMI configuration
Thread-Topic: [PATCH 2/2] drm/amdgpu: Enable light SBR for SMU on passthrough
 and XGMI configuration
Thread-Index: AQHXFf98wBun80IPEkmspGLf0yBe5qp+A0kQ
Date: Thu, 11 Mar 2021 01:41:56 +0000
Message-ID: <DM6PR12MB26196232735DABD672830D8AE4909@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210310224805.10266-1-shaoyun.liu@amd.com>
In-Reply-To: <20210310224805.10266-1-shaoyun.liu@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-11T01:41:54Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=975a67fe-9639-46b9-8e3b-bfcd4df54ae7;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b7dac3cf-88af-40d1-b2d2-08d8e42edb0e
x-ms-traffictypediagnostic: DM6PR12MB4926:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4926B2C1A1DA547AD2A169D2E4909@DM6PR12MB4926.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +Y4rQY+MdnjuW90Ol2iaAmQ2PUnmikqFnUZIdzLwK18HiihlllFoF1QIEEEMOzxuFyIoywb4rh4R3TU5pdihPQIX0IFPv2YhRJv+FF9I47st+Qp/7Xk6+BFwtqiHzjTSv+TQt09JFjE7SRyjHoJiuSFl3Pai1B93XcPnJReWW8SqjKt3A5HDdwrfVWlrwinbJooBO+zUQCjg6CjGbBcWFCXijtawEyRYhLLvxsOfobPOJDYkWbkg4I0Xm+uthXHsP4v0c6Jtr+HBpx6hFgEY86V0qnVXMestYwCLXJiTvgu7d+I/WGMa3aXDoisa1LJMCG06MYHEVwz/qjYZfR5vIV2YCgyOupD+gZVzjijZsJRn8qIHFLSycydz9+PM5YhznhQ35GzYlhD0+0kH5SWtajeSeUzhxiXfcGJpF407pzW0q4Az8Tk8VcdJhtDwCVx/jNhbS2vtUPDzxkeRCAhmtI/NcJUGVbVRSilB+6eidtBWMUBFlDRDOCLFlZD3B+TH8bdUA24Ilr02XrNuYnpVYlzQ0zpae7svEVEprq4cBJgRFsmxSm1l9BBBQgid0bjc
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(6506007)(52536014)(316002)(83380400001)(110136005)(86362001)(4326008)(7696005)(5660300002)(66556008)(9686003)(186003)(33656002)(55016002)(53546011)(966005)(66476007)(66946007)(2906002)(8676002)(8936002)(64756008)(66446008)(76116006)(478600001)(71200400001)(45080400002)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?m1YlmxfPsAO96HMUg/ifwzYUQLLXhqJPIblbiewarWVQwMmQk4EqsUaZOMBd?=
 =?us-ascii?Q?7X82IQ/Gnuw/W92D3RV8YxDn9n78N1fZaomPjvKtKinz/36ctShBKT/7pOwx?=
 =?us-ascii?Q?owo8yg+I4aHHY2FbKSts/Fh6OUXVZspARqKsJTxzjTXKxj19PG8ELDK1zq4g?=
 =?us-ascii?Q?HtnBvFY0SpuXecePNGNRoh3ywVoaS2hrys8kN+3p0Afsy1foGCvbjkPUU54v?=
 =?us-ascii?Q?/W9rHwzlPp/6QyUTdgu+dxcR6qZxRUPDfDJA9oEiOICET3piFXpIyhqCGTHb?=
 =?us-ascii?Q?62eDaq+J7XadKwHQfA4ptPPH1BZQLHwpB29l2ZrDwqZnQdOYOAfA2C3RBtzB?=
 =?us-ascii?Q?bddMsF6SnpYWcspY8CWhJ32c79WGXVoHD17V1QcdjKX9+gpBDiWi6XlBa0qc?=
 =?us-ascii?Q?rDdX3/i+XFMeAe7gZUnWLHRFYMiMG4aqDl3qo/vyJ0bCDGI1U/p+ip6iZHeo?=
 =?us-ascii?Q?Caa5mCZm84wz8pS1B5mO6aN3gw6CJYVkdhyuPZeUJ1gdT4HyGPNEBw5gndGo?=
 =?us-ascii?Q?avrgQth5gKtMcWm0KvcBdMLwBSbVHJ3DS1/AZ2D3lZXi9IT0UxzoLZJ1vRRg?=
 =?us-ascii?Q?TTfY5iyNoPSSXiGwtaYeJNwcKsVVmvdEiihd9VGSIfaVRiXMkbiEICbuT8SS?=
 =?us-ascii?Q?cXcaAxkDT9t7Nzd0D8OgU36Wb0h0FL4rgEJsUPw/+9eRMZr+lzhvbiYcUWZw?=
 =?us-ascii?Q?9gOpdHtPBXEQw1mM0tchc3koUfQ9B6HaN7Y9uylbdWhiYpheKFt17+6npHU2?=
 =?us-ascii?Q?Ri35CldtV+Q2eeKPUSxb1L0xRO8oAdw/4+019V1CNr0IvKhVMK1RXix23L8X?=
 =?us-ascii?Q?f/9KohXFZ2KkyohNuf6tpy+H/3viIr8bO9Tn+D4sCPS+h+4/EPYe95kaoyl2?=
 =?us-ascii?Q?7PP8BvSeJ3pvQjYHzJ6qiXx/6n7aICjQRarZRlzDHIAN6y2EyfAnkCxn1F0C?=
 =?us-ascii?Q?Yz5IXcRgNH1ZAPazk0FOG6mHMaUqaff8/TFORX3et2y4y4tcnpdc6dHDeU5r?=
 =?us-ascii?Q?sdYhey4brfO8jN4UyeaEmdNC39GJU3XymEGJ9rJsYcWGYeQ45tzFdI9Z4OpB?=
 =?us-ascii?Q?TNuMB4XcDl5t3HW7egJXPiGq3x1Uo6egkhsayxtfyTXW+broXnZhis8gR69Q?=
 =?us-ascii?Q?awPmcewMnN+Bvu/LRWsO3gZp3+oUs6tHhNjudN0gHCBCn1Y6sP21zjCmP5fN?=
 =?us-ascii?Q?TWpM2/aFhE1jfNNIPVzFIFEiJSUWjJzzm9MVemag5ANBmhHE2Kt3EVCKFrBb?=
 =?us-ascii?Q?44L7798U4ts3KJY7zLyC8dw2jyRkN97VJxdnz4qlCmnbfJbQrP3zihEfJwl4?=
 =?us-ascii?Q?tCzzyEPR5/mMdDE+HZ6IUf6q?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7dac3cf-88af-40d1-b2d2-08d8e42edb0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2021 01:41:56.6208 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1QV6pL3n0Xahi6YbEXuZk6Ry1YVUk643btH4q9I/tedfIIm3cAdXKhvS7Xc52Thv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4926
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
Cc: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Series is reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of shaoyunl
Sent: Thursday, March 11, 2021 6:48 AM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Enable light SBR for SMU on passthrough and XGMI configuration

SMU introduce the new interface to enable light Secondary Bus Reset mode, driver enable it on passthrough + XGMI configuration

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Change-Id: I59aef0559aba418b764e7cf716b0d98aca14fec5
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 4640cafae619..e142b4080976 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3630,6 +3630,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (amdgpu_device_cache_pci_state(adev->pdev))
 		pci_restore_state(pdev);
 
+	/* Enable lightSBR on SMU in passthrough + xgmi configuration */
+	if (amdgpu_passthrough(adev) && adev->gmc.xgmi.num_physical_nodes > 1)
+		smu_set_light_sbr(&adev->smu, true);
+
 	if (adev->gmc.xgmi.pending_reset)
 		queue_delayed_work(system_wq, &mgpu_info.delayed_reset_work,
 				   msecs_to_jiffies(AMDGPU_RESUME_MS));
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7C22bce51c0b2d4f9a00e908d8e4169bc4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637510133081451493%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=p1H2622MyBOZF4OSPY3Sl92A7DTDNEMtp1a%2BIwwV%2FUo%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
