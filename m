Return-Path: <SRS0=QeQy=ED=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8FEC4363A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 11:38:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0764B246C7
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 11:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DUaSoJX8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0764B246C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 878E56EC8A;
	Wed, 28 Oct 2020 11:38:01 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0A3D6EC8A
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 11:38:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kVQW+LglVaC2XAX/wTbWQwunPynKSmJs6itMfFtAxRABiiUOPFBPJX3K3hi/0KFRVeuof5cihAQLrHE3xIjbNb4gixHg4ndGpTbCSjSrnxYjnL+PQli5r40s7DStTVv5AfGOWSgNTpCpiLlahSqeFfxOh7/nFGfR7i4CSTFoi8nFKGB5jJFkMXIs9hfks4R+6YbBHeq5rYFLgoeK7o+SlH3BwJLuBQ9LhiOgpRAAdQLqVRxSL+coxrsn0dYUtSY3jphMvAfabLny8jMQzP340S/sedO61X2W00GGkXVGZkaXEYV29B+0SVuWjee9BfzmL6SdtNgLfG1j0seM2s1FtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTtxzdHk+9xprMczEmtvMsghG4iOjoWEWj3Row/7bnw=;
 b=FW1XQ++9g7RpE72yY5RbGdQKZUnTJqYtrQ0NIev0C2FHalpVvhMvZ6vNAo2SDWG9ZMa39mizW4SULLaXKiEKFgQ9Gihq93hD+jc+W612lJXdZfow22aXnyYkyJh9gquUYraCsYAZH0xXOYugghLN+nwpAKYADckmfgcm+cSV4j8yUqcjLjItZ4dslwEZDPZNxPMUIW4Z2id+N0V7hR93RaKg2WmTpZoO70N4zEXpVGMRlbIamYBE8faEmwaGiuzEFVZSBKu4iToQrueb5bpG4r1UBjHma6iwP/EheGi8ny91UNrBsdvwl3lL8Bqbu+ojLYLXzOKthDCfVD8ejVufdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTtxzdHk+9xprMczEmtvMsghG4iOjoWEWj3Row/7bnw=;
 b=DUaSoJX8MNLT1BcCoFOymKPHFaJZ20WSePs1zvSp33CvSoLI814icAwznVMPBj1z+ZWDNMvSLeTq45Uz9TXxxqIoLlwPaxNQxVSpc9y0ImdmUSYsQENEUfTdrC0opgr3EWCVKIg4CSI6AsU90F9yE/6D7rk6flUpR4J4i1gEVOs=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR12MB1772.namprd12.prod.outlook.com (2603:10b6:3:107::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.27; Wed, 28 Oct 2020 11:37:58 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233%9]) with mapi id 15.20.3477.028; Wed, 28 Oct 2020
 11:37:58 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Gui, Jack" <Jack.Gui@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu:  simplify pa_sc_tile_steering_override
 check
Thread-Topic: [PATCH] drm/amd/amdgpu:  simplify pa_sc_tile_steering_override
 check
Thread-Index: AQHWrQ9xr4yVemYOsU+7OV0AQ5rpD6ms41Og
Date: Wed, 28 Oct 2020 11:37:57 +0000
Message-ID: <DM6PR12MB40754AE3F667E5ACBFB4CAB1FC170@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20201028094759.10381-1-Jack.Gui@amd.com>
In-Reply-To: <20201028094759.10381-1-Jack.Gui@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-10-28T11:37:54Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=6b48973a-2cc1-46b3-87f8-0000d44310c0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-10-28T11:37:49Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 86288e07-0235-4dd4-8f85-00000a94c2bf
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-10-28T11:37:55Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 923b8400-1a89-4fb5-8e5e-0000a2c43860
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 39e38752-633a-4b1d-3071-08d87b35eb19
x-ms-traffictypediagnostic: DM5PR12MB1772:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1772E66B4F6BA3D778FABB91FC170@DM5PR12MB1772.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U2EUBdAHc0AVDE7VgJbIwblEcD/aOhF47hwDgSA534UiOvbotmXtUE4M8JtbTUBJ2WuhbzPcUjApNJbSffo7snhcbuYqbm6+b9lNVmaLroEZXBfDOCZExpwXP9fO5wzGdblT1UJO4mRYQ8X8PMhMxXGMJ85X18Mfue7lu2vD56wZHOlUgD3Z5DyGqLWNTgVCXYCJvBdjLpiJsuZJ7+0FAJvVVFTbNpahaui66wHHpooGAjlRf/jxXC0fK08z+EPxGjN0iIpuLOkFeGBpgrWM/OdG27GeJSpyybo0pBkiEbRZ2RYnGHlTnFMLOKw7uyDoiry0lsSqyF6Y/q2xVTYQBA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(52536014)(55016002)(33656002)(316002)(66556008)(66476007)(9686003)(66946007)(186003)(478600001)(7696005)(53546011)(83380400001)(5660300002)(2906002)(26005)(6506007)(8676002)(76116006)(4326008)(66446008)(64756008)(86362001)(54906003)(71200400001)(8936002)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: Hi0RglEpT/tBxnPmYvbSvzyVvQLsyVV/aHbgUuOi3ccafJ8RFxvnuf3U9W/QGPR+BjGuBDwBv7Gl2ERiFOhFH3YUjQyh87bby3R6hHMCJMwB0U1YJTL76qWnZ38PPIf1HRjb13klwQluZllhFYjl9y78V155gw/nLV4EAJJ2ipCHtzH04HghCW44ta6ggJf0WkIQJmUc1sS23MdAxeIzw9rI2M1SAXUbg8xASngJrzmJ4n3sonRd1SKlE0Sb5JWRhqACTL1aFAxKUbDgO5+PO3h9WOtzHuztYPK0IzXic2A2mfUoEmsdAtLKO2dzLC6qBxZPSRzwsL4dNN1ahw+cwWxg1l/3eufPzOb+QNMz6mXhrJLTw3k60py1U+eogyuSevE0LjHrKbHU3Ihzlp+XyNksiXlwkIZOQxijtNeQxEsf0HreRRkFEJF7JCZ7u75fPvqkRwsmYEEH3Hreg8HxbDcsalOr2YN4tV3sAuK2JbtsNP0uHhjzbQBDP/vHHCgb+UXWwEHSalsemcE9RCrxhi84Xo8ygnHlhyfqOZJmdhdxLldnTTNUV/kGtp4JbjXiDpnCL+U0vKtmf6LuGxae3Aijmg70m5WFy/kXh0NXfJpBN6AjCkALWNdhqyUjc8RsyrQzDIjbGvAsVGZJ2m0QVw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e38752-633a-4b1d-3071-08d87b35eb19
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2020 11:37:57.9530 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +w9pIntF3+uXbQgB5ktIv+SRD4pbUMsqaRL34BuwZiXqD6AoA/+XtsS5KT1M1xVNNWPfNgEsPJSRgOzQllEIsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1772
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
Cc: "Xiong,
 Yang \(Felix\)" <Yang.Xiong@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Gui,
 Jack" <Jack.Gui@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Chengming Gui <Jack.Gui@amd.com> 
Sent: Wednesday, October 28, 2020 17:48
To: amd-gfx@lists.freedesktop.org
Cc: Gui, Jack <Jack.Gui@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Xiong, Yang (Felix) <Yang.Xiong@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amd/amdgpu: simplify pa_sc_tile_steering_override check

Use ">= CHIP_SIENNA_CICHLID" to replace per asic check

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Change-Id: Iddb3bf1ceb79ecba69a07daba1c2e33d94eac24b
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 3256d6b368c8..df1b111df9dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4756,10 +4756,7 @@ static u32 gfx_v10_0_init_pa_sc_tile_steering_override(struct amdgpu_device *ade
 
 	/* for ASICs that integrates GFX v10.3
 	 * pa_sc_tile_steering_override should be set to 0 */
-	if (adev->asic_type == CHIP_SIENNA_CICHLID ||
-	    adev->asic_type == CHIP_NAVY_FLOUNDER ||
-	    adev->asic_type == CHIP_DIMGREY_CAVEFISH ||
-	    adev->asic_type == CHIP_VANGOGH)
+	if (adev->asic_type >= CHIP_SIENNA_CICHLID)
 		return 0;
 
 	/* init num_sc */
-- 
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
