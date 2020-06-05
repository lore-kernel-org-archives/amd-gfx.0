Return-Path: <SRS0=/kPV=7S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABCDC433DF
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 14:38:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D25B206DC
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 14:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="O+ODsNqw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D25B206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29BEC6E913;
	Fri,  5 Jun 2020 14:38:20 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BF456E913
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2020 14:38:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eKi0E6S5qGKoIHMFGlOyKbNGGFfe4uGN2KPateKi2BrMaRwly2UmlZmLVIW+flv+hltCyRB+01Z5KkAS+u6ga35EAjMO0j3cwOdFoO7KI51/2mJdANlq5xeYJMlo0McQD4QUXiy519G4iY6tU/O5dQ/NEcdhgEw9LV6RABkRLT3kgiEIy85VtBJ5frF0aAHRsLKJOjMhaYzi5yKTLbbOUE4PsHYwSwQtjZZTr9kxjZVydIULNueXKKye9hZnV5cxS1DEcMj9TCbtiBQKVKkw2OKj7BSEF5/nIWLiPRNhMJEJXfOosN/qbK2WrvCWu2vsSEEU0STD17/d2HUgdWhlrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVcMxsqX9/octqBlOnGNfiMqebLGs+ZknOqtfbIxZro=;
 b=hljoZBZzP6y//1/zUt3sPwSm+yp0Wx1wqNcL5xOX/M/yaLIL9XIn3NkgzZPCycRXbEBDYtgh7wU58ECcnxX6xhdimG7YVb/B8HY7NK+GBVtjbA7Pf0dR9zggusZJYt0nvwxEr3IPzWXLH661HEguz3MnkzQMQciqCi3ch0VSmJMOUxfx0K7Wr8Ih1X8ht6kwbS7HVz6Ac1K8fVHbSY4jMXccmcXzFY7VuTcYfwRBpaSBBLMZl0H/nDrhdgxG47uGmnsnPoCYPaXVEO4EI3g51ENg4FBQ6cWgd39Qwtb4ZpnpYuiXDUkbuWmAh3B5Mc2Pm1K/pskCVKSDpo1HCPljsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVcMxsqX9/octqBlOnGNfiMqebLGs+ZknOqtfbIxZro=;
 b=O+ODsNqw1i6XNR89hWOIlHnrdGlUkLt9LgfP3JqZhLdKHr41LlDTDmDhlX3ypXvzTYDrOg73mjOJp9YMl9QFu51JrYK7KvTNH17hDomRvU1Pn2gXJliYGRCnPWRrs7QbzoTmDrSCIM/Al8YskolfPZbaKrd0oOHlfi/by/qNfVM=
Received: from CY4PR1201MB0136.namprd12.prod.outlook.com
 (2603:10b6:910:1a::19) by CY4PR1201MB0200.namprd12.prod.outlook.com
 (2603:10b6:910:1d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.22; Fri, 5 Jun
 2020 14:38:17 +0000
Received: from CY4PR1201MB0136.namprd12.prod.outlook.com
 ([fe80::b1bf:dda1:dd1e:8e30]) by CY4PR1201MB0136.namprd12.prod.outlook.com
 ([fe80::b1bf:dda1:dd1e:8e30%5]) with mapi id 15.20.3066.018; Fri, 5 Jun 2020
 14:38:16 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: skip fb size query for navi10 previous asic
Thread-Topic: [PATCH] drm/amdgpu: skip fb size query for navi10 previous asic
Thread-Index: AQHWOznZ7yGzp+QmFkWgZfrH32eVWKjKDhaAgAABeYCAAAEYAIAAAkGA
Date: Fri, 5 Jun 2020 14:38:16 +0000
Message-ID: <CY4PR1201MB0136DEEB3CF9928122B0DDDAEF860@CY4PR1201MB0136.namprd12.prod.outlook.com>
References: <20200605130412.202089-1-likun.gao@amd.com>
 <DM6PR12MB4075B8807E76FF2925063F35FC860@DM6PR12MB4075.namprd12.prod.outlook.com>
 <DM6PR12MB40752665F199B53B99DE432CFC860@DM6PR12MB4075.namprd12.prod.outlook.com>
 <DM6PR12MB4075E21E04CB874BC2B9BE8EFC860@DM6PR12MB4075.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB4075E21E04CB874BC2B9BE8EFC860@DM6PR12MB4075.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-06-05T14:04:41Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=4b76a02e-c23a-4b0a-905c-00002e517422;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-06-05T14:38:13Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: d423c6be-341d-4dcf-967d-0000bfb0059d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [101.86.222.246]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f1294a16-1705-41d3-857f-08d8095e15c8
x-ms-traffictypediagnostic: CY4PR1201MB0200:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB020083BE915C77663DBB5475EF860@CY4PR1201MB0200.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0425A67DEF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZQ30/2cjhN2UCHL9qW6lmseXjh/2OnQ0e+Q0er0wKMBmTwiXnyod9LFr7SEUAV0zbGPIS4C8wYnwEinOgKT13LABC5oxDvB81bAvSvibFNseTSIONnJPuBbKit+jnRZ+A0XHt+/2WxSgJO1Rccx66rV6kgmXN7usDRW5xRTCrmPBR+wEXzjL81uzRODyCvPdKpw1BRwYzZlLQ4WlKgOGIyfSz/i1435Hrsi7ZO4oKxP97WrzvFiPzChISkWYExGCKG5a+8ovrIHuHyGUaQHc/CwArqvDJpS70jkJkoyh8bIQ1KF5AH9zwDE0oAFIxkRclnpVp5f7JjSn4P7iMYPvapQAPAmqWgqpoUD74BFmNY0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR1201MB0136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(55016002)(8936002)(316002)(9686003)(7696005)(71200400001)(110136005)(45080400002)(478600001)(33656002)(86362001)(83380400001)(966005)(76116006)(52536014)(5660300002)(4326008)(8676002)(66556008)(64756008)(66446008)(66946007)(66476007)(26005)(53546011)(6506007)(186003)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: wd3IT4iYoMBM8NT8EHeVot1qa4eg6XYTyvQrTaVYJfscjy2NfTYaBuj4gSHYxL+KwFf9AUxrGH8dqxzSAvaJG8GVUugYONvPrO/DqJyoBf/Qp/4MHGwj46s1JpMBn+qLRlcxHvmR9uWnlnxyn/dzH42ZYiz+Sg9rK6z3ESBJUIimIxeqm17FQhJBQZuvm++z0OzYO0Iy9PVy+tJP97VxDwZGcCmsTbWGWdbongTWCEZyEThTtdzeF9a5ICNUOpoFS5LUcXUnCTEz8LmEYIpAW3+0anPoLGl3p1W8NTqn5dKtXmOFNZm+M3ig8LoBVZn24jKeFHgFTSD0x8qfsz+363PBKNPOjFlKtDAYsPXYg6k/AVSN9AQj/nlyuzufDd5pA7KOF/GkScetjLm17wxiOS3iw/loXeNJtQCdUcYDY9dXfOXTRuyFyqygjXQCqnLmZSKjI0+BjxeCsA6Re1EJ6cZIRAQH4Nklzyo04uDTw5U8DxWigO98abSKIKO6B9hE
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1294a16-1705-41d3-857f-08d8095e15c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2020 14:38:16.8194 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jPEiP4oL9xefMGpLN5rXt30OnIEWuRPuFpyGZRjIwx/i/WveOgZAx06QIfz/hrDz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0200
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Sorry, please skip for that fix, on the newest code, system will check whether ASIC is newer that navi10 first and only if it was newer than navi10, it will reserve memory for TMR.
So, the issue will not appear on the newest code struct.

Regards,
Likun

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com> 
Sent: Friday, June 5, 2020 10:14 PM
To: Gao, Likun <Likun.Gao@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Xu, Feifei <Feifei.Xu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: skip fb size query for navi10 previous asic

[AMD Public Use]

It looks more reasonable to me to move the AISC type check to the following. We usually don't add any ASIC type check in atomfirmware interfaces.

	adev->discovery_tmr_size =
		amdgpu_atomfirmware_get_fw_reserved_fb_size(adev);

Regards,
Hawking

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com> 
Sent: Friday, June 5, 2020 22:10
To: Zhang, Hawking <Hawking.Zhang@amd.com>; Gao, Likun <Likun.Gao@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Xu, Feifei <Feifei.Xu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: skip fb size query for navi10 previous asic

[AMD Public Use]

Wait, I see the risk. the amdgpu_ttm_init is general one even the prior Vega10 ASIC will invoke it, and they don't have atomfirmware support.

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhang, Hawking
Sent: Friday, June 5, 2020 22:05
To: Gao, Likun <Likun.Gao@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Xu, Feifei <Feifei.Xu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: skip fb size query for navi10 previous asic

[AMD Public Use]

Does it mean there is legacy VBIOS that even doesn't have firmwareinfo table and introduce crash?

I think we expect the atomfirmware interface return 0 for ASICs prior to Sienna Cichlid

Regards,
Hawking

-----Original Message-----
From: Gao, Likun <Likun.Gao@amd.com> 
Sent: Friday, June 5, 2020 21:04
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Gao, Likun <Likun.Gao@amd.com>
Subject: [PATCH] drm/amdgpu: skip fb size query for navi10 previous asic

From: Likun Gao <Likun.Gao@amd.com>

Skip for reserved fb size query for the ASIC older than navi10, as those asic do not need for TMR region reserve and may get an invalid value.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: Idbc57805b8070f27ba6c3cf22f1892d6dab92f06
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index a9adccfda4c0..e2a64ae7bcaf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -603,6 +603,9 @@ int amdgpu_atomfirmware_get_fw_reserved_fb_size(struct amdgpu_device *adev)
 	u8 frev, crev;
 	int fw_reserved_fb_size;
 
+	if (adev->asic_type < CHIP_NAVI10)
+		return 0;
+
 	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
 			firmwareinfo);
 
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Chawking.zhang%40amd.com%7C3e694422d2454046603e08d809596b07%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637269626942920124&amp;sdata=n7NDuLsmSx66FSf8OXd4rpq%2FLXNmTEAo%2BiWAuqSRbC0%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
