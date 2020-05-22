Return-Path: <SRS0=+s4F=7E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B879DC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 05:36:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B5FA206F6
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 05:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZPiIIqlR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B5FA206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E0376E983;
	Fri, 22 May 2020 05:36:14 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DFD66E046
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 05:36:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCw+m0TpHGSjWY9RiY03ts+h5kVYJ7KGozTd1ljo4YcEjokp4Fz97fp5NpvvfhFDw2/aBna/Y1JW4jCp9p3L8S2y/DUVCreFPlr7LJsTPueJGMCU1QJXlrWzy+pbbR+V2QuQ/btE9TOhhbFpQJ1DGrDD6faneMUJarutSJKKKf7T/oYl/UUFzdkHhCTE4L7lq4oEOVZUv73Nyssfi9htzJLHmsar2ZBWTsAXm31L5EwniOaJVH1wyn5Xc10oSiNyExaGefPrNhmTvwrX7e3fkaFd4/Qpqj2ACvb0GDlhKfQ9rJcq/B5otJHUxs3XCfTkcZqVXhab+baMpr/dg2XfJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ii0AfLz1Oiw4O6M33XvGTpsY/5G9OsJB5fkwAg/WuzU=;
 b=HxNhEkkw9Qrp2HZOC97yjThxXbkaNud0vmbuPWgDwf08fy4j2+2c3dfLchssjam0+PbphCJztFnZi2gqsvsYGXk76ccKmPyD/gYmh/M21WpppCQtRSqWvrCj4kR3e8V0puICprcTzCjIV03ExGdgOqtfo+MoZq4l6os88RSBNTV2StwZphtmi3DPUGeDprC94Yg5UxnEJwFtw9nOrNsbCL2GNqJb5RnYnHonBgR7ev7AQmJkFOKplderC1OmXWBVSGAu4TxEwHmD52Fs6p8tZT8zOtFxV5SoCkbZ43A8cBdze2I2rVcsCNxgcVDKBSyoy+90iyDpbMF5bzxEDlXcTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ii0AfLz1Oiw4O6M33XvGTpsY/5G9OsJB5fkwAg/WuzU=;
 b=ZPiIIqlRJaV/Fx4CteLF9Y5fEsXe1q8lVpbah1G9sFZkBUS5vRowAuuvKyQ8XW06SH36+h8OJgLgkqEQSuFx8lHBOQnAiQNBo232/pNRNx+8zGcsy4dBKRqLJxEO/PsDNzqHUT6iO98AbtyyIrgwSIzeLnatyb41EV9uHRyq4wc=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3498.namprd12.prod.outlook.com (2603:10b6:5:11a::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.27; Fri, 22 May 2020 05:36:11 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3000.022; Fri, 22 May 2020
 05:36:11 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix pm sysfs node handling (v2)
Thread-Topic: [PATCH] drm/amdgpu: fix pm sysfs node handling (v2)
Thread-Index: AQHWL4zbm4c4VwnEFUqSSYZj9dV6UKizlp1w
Date: Fri, 22 May 2020 05:36:10 +0000
Message-ID: <DM6PR12MB2619414838BA020535F24EF5E4B40@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200521162654.1643801-1-alexander.deucher@amd.com>
In-Reply-To: <20200521162654.1643801-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=21a4a6dc-8046-44af-8c60-000091c1d041;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-22T05:35:53Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aa5297af-cc41-4d1d-2455-08d7fe120902
x-ms-traffictypediagnostic: DM6PR12MB3498:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3498812D282C107E3FD34EC6E4B40@DM6PR12MB3498.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 04111BAC64
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8QEoc0M54znm/6kjF8ns66rcPw8uPniiftKTF1qQj5nA2xRlmu7vGn8LP1zGPFw+5VjUR5vwk15xk8bKsUf1hbBoEQPZvhYAgn83Nle05/iFgE0uOSB7GNP7TcThKLpC++TepY+3c/smPo1VRq9r4MdKhnm4n4O8WWTqflXoebRfjUUaWTSj63BQT0RTqYgstMns3EDwsu2qni6SjGaod8K7gtczJjykfBTOx40aUUwTgTIJW3S+G0S5vRg4UWHyUbCNQzl/P4337w1ehIM/OH97w+jTCFWZiqsmb2Xz1K1dW3+zhOMNb3eM9Hc7Va8NFIqvpT1xIbX1M5TnNp5izJNSVpmzjo6r9JZ2oY61H/n+4/jUeDTq/mN3Ijp8QJJACU4MpnWVALs+wzGlZZZA3mQe9NR2F4Rm00NkuPvYEvvdQ/4Mw4RKCvo9WggPY4ryTifdM32X419uEaBWrkkyPWBDI0nr2itHOv6eywd7rg4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(7696005)(6506007)(4326008)(186003)(71200400001)(2906002)(33656002)(966005)(66556008)(66446008)(64756008)(66476007)(53546011)(52536014)(76116006)(66946007)(478600001)(26005)(316002)(8676002)(9686003)(45080400002)(8936002)(86362001)(55016002)(110136005)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 9aHppiDNlJw4J5ylH3LDEB73iekMFvfzgVMshTfAf8Xt1pE2rmP0dTf4kIEKOciE5IhpZZhJetxnZFCHOc/Yd2DTj6P2J7gkYzdTtuIbPeFftdWvc94F+mrU8xRxs9tGlfkP4M94ThBZ4dootGXikFTlTX+LyLk65Z9RdJP9gTxobDlhJQdDfUtCR1V81QMp1ktuYc6Cn2wZN65nT2dWj2vxfoEImmtKrxERE+JRfH1yU0uKP/TL1RYoRc/zAoTnHQjZZtJCAnAMJIUSB8xpHsii74fB4Vjo+t9F9UY5dA+xsGsby9ZlK1USqfsbX8A3M+epY6smknjFuTkOIx3BnFy5RWavBIRzTbnQNpNq1K3sfxxZzyTfBsNHkTlvL2a7jA+ZaYygOQ6hAOFZ33skfakqdZ7Oa7iBDZkWwuPZivq7CnhrWCnkbWhX+4mC4pCeHuQ+TspowBcn1kG61yl3ePhAja5YfoheLt7ETITZ0mjUf+qqbHXj6htL6pDRMZJ4
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa5297af-cc41-4d1d-2455-08d7fe120902
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2020 05:36:10.8567 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nv72ljcwk8yPTZaUY3q/6XsBW4h2QFKU+nL9ieVr1Uj0x0TX3HH6vynBXOECrZ5/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3498
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

Acked-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Friday, May 22, 2020 12:27 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: fix pm sysfs node handling (v2)

Fix typos that prevented them from showing up.

v2: switch other files in addition to pp_clk_voltage

Fixes: 4e01847c38f7a5 ("drm/amdgpu: optimize amdgpu device attribute code")
Bug: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1150&amp;data=02%7C01%7Cevan.quan%40amd.com%7Cf0caf70513f64f2e30fc08d7fda3ce90%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637256753077066180&amp;sdata=HPUaGNSuRuqo4YndKafc5hAwTI88lalIOBXoUtJ3DPA%3D&amp;reserved=0
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index 2fc51f815eaa..e06fef6174e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -1731,10 +1731,10 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 #define DEVICE_ATTR_IS(_name)(!strcmp(attr_name, #_name))

 if (DEVICE_ATTR_IS(pp_dpm_socclk)) {
-if (asic_type <= CHIP_VEGA10)
+if (asic_type < CHIP_VEGA10)
 attr->states = ATTR_STATE_UNSUPPORTED;
 } else if (DEVICE_ATTR_IS(pp_dpm_dcefclk)) {
-if (asic_type <= CHIP_VEGA10 || asic_type == CHIP_ARCTURUS)
+if (asic_type < CHIP_VEGA10 || asic_type == CHIP_ARCTURUS)
 attr->states = ATTR_STATE_UNSUPPORTED;
 } else if (DEVICE_ATTR_IS(pp_dpm_fclk)) {
 if (asic_type < CHIP_VEGA20)
@@ -1746,7 +1746,7 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 attr->states = ATTR_STATE_UNSUPPORTED;
 if ((is_support_sw_smu(adev) && adev->smu.od_enabled) ||
     (!is_support_sw_smu(adev) && hwmgr->od_enabled))
-attr->states = ATTR_STATE_UNSUPPORTED;
+attr->states = ATTR_STATE_SUPPORTED;
 } else if (DEVICE_ATTR_IS(mem_busy_percent)) {
 if (adev->flags & AMD_IS_APU || asic_type == CHIP_VEGA10)
 attr->states = ATTR_STATE_UNSUPPORTED; @@ -1758,7 +1758,7 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 if (!adev->unique_id)
 attr->states = ATTR_STATE_UNSUPPORTED;
 } else if (DEVICE_ATTR_IS(pp_features)) {
-if (adev->flags & AMD_IS_APU || asic_type <= CHIP_VEGA10)
+if (adev->flags & AMD_IS_APU || asic_type < CHIP_VEGA10)
 attr->states = ATTR_STATE_UNSUPPORTED;
 }

--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7Cf0caf70513f64f2e30fc08d7fda3ce90%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637256753077066180&amp;sdata=qenyCI1dUTbVXWeXiPWH2qKvSd9bVlytNeED9IR%2BX00%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
