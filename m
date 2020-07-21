Return-Path: <SRS0=9beK=BA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C11C433E3
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 08:09:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CB0A2080D
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 08:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xpwhJq7E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB0A2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F06346E433;
	Tue, 21 Jul 2020 08:09:31 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 882D16E433
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 08:09:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0/9B2MmTNUcyKJcoh7rrXPuMGSayd2K7GUO6mNhNf+ZksLbHH6Omq0PyrlQpR2P2oQUd1hNc56uxx1KqDiMWt78rw25lUb6uD/P0NRUr2GNMUBJDlLzgNGdtiqSTEhkBMYH8uXVxOsCz7DLD/sRYGqVDsaeZIVwG1Nu0DOhB3MvuvX4o5iRJ0Yja/uEjF8bD795vtGGORF/k2E+VU0lhnonpDU4lTS9tUeneoLxKVc6dzwaO3kadLATFut4i6LWlze8M/tlqqheykf0Gg5jBRQOkjmRBgrj0tm3pzGiuSTiQALvHnFPKtXHAkwyY8cNK+wFUEaMkodUhfoFQHa/sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXDFG+0AMDUxmEmGDi0zEFP2r9M2H7tjqKIFWDsGWW8=;
 b=KccgqF+FjglM9lRvmu6uzUjK/Jm/SLZYNL1jWML9rkOGJYd/i9d57jdnoViUliRTpU9+kvqQetqwu+0z1AxOZcNVj9bPKkoZ6qo+OfO8EI9HRJkI0k52oF9yrO7HXOy1OSvCQm1dT32ZBE0xGUBWU5toypw0XU/mKVk3BoanuC6Wb2Z5BYaGghRSR4vowY3fPcfThpzbYXvVcFbdOXaTZl/PuNotzBzMSkfm5N4xGb659mpY/C1YSbw36E0kZjIB0EU/vncg7/rC4SIMs8Qvth3SS0Qs16asgjKVRz24OmRxzzt1zb2o0RenZ4O1LSqCTk+skdxCHp3NAyHq4qZ+HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXDFG+0AMDUxmEmGDi0zEFP2r9M2H7tjqKIFWDsGWW8=;
 b=xpwhJq7E7Zy3iXE4SRXzpZvweMKjcQwtj5Yrjwz3T0QoNb26J8AZ62QOV0C8YsooYt8IiIhebnUtMFF3icERAyESCgD8E+4tcosWD2XELa6N3jzcenWxKlvcOPCd9rMrGQxtI+nGCQhbt4j98i/cyZT/IEcEW0bbG8KJ8i+DTIU=
Received: from CY4PR12MB1270.namprd12.prod.outlook.com (2603:10b6:903:43::17)
 by CY4PR12MB1270.namprd12.prod.outlook.com (2603:10b6:903:43::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Tue, 21 Jul
 2020 08:09:29 +0000
Received: from CY4PR12MB1270.namprd12.prod.outlook.com
 ([fe80::98b2:95b6:a029:2820]) by CY4PR12MB1270.namprd12.prod.outlook.com
 ([fe80::98b2:95b6:a029:2820%12]) with mapi id 15.20.3174.030; Tue, 21 Jul
 2020 08:09:29 +0000
From: "Sheng, Wenhui" <Wenhui.Sheng@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: add msg map for mode1 reset
Thread-Topic: [PATCH] drm/amd/powerplay: add msg map for mode1 reset
Thread-Index: AQHWXx65tWE8e0/o+Eyc9wkV5qnFJqkRrKjQ
Date: Tue, 21 Jul 2020 08:09:29 +0000
Message-ID: <CY4PR12MB127017AB5F12A8DFE3F02CF78C780@CY4PR12MB1270.namprd12.prod.outlook.com>
References: <20200721052039.1246295-1-likun.gao@amd.com>
In-Reply-To: <20200721052039.1246295-1-likun.gao@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-21T08:09:11Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=972a73fd-3240-4974-9a42-00005af50b0d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-07-21T08:09:11Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 24dfa01d-cac7-43da-8c9b-0000b0261dc9
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b60598ff-bc28-414a-78de-08d82d4d64bc
x-ms-traffictypediagnostic: CY4PR12MB1270:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB12703C906E9CB5699A0452A18C780@CY4PR12MB1270.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 30H7YcDHrI/uusDU5imoXTJl/Iuh4EpE3aAs51dffH4Nr2f+DhZ2H4yUjwzkeiK/gEawvFCfOP+uhPRU+KhxJxL5OmjS9lHu1IJg2eUsJwXJvXfvHLUTwAo4IfeO+5w+F5CxRT40YQuBmBKwL/ajEQciUb8v5/MZ9wMww3A8HAWqrWEXGFNdFixtu9Un7HSIqdbOgVVS2ItWLQoKvpxDRvj7ruD5KKrb29JIXpaHe+zTUkHXYZmDVV7umCp6OtsngJgq534IOsFkMYAtMU2CdV2atzGYO3XuJ7Qq6kvSux1E93/OV/8TAkqPbOmPRMSt
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1270.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(33656002)(54906003)(316002)(110136005)(7696005)(71200400001)(2906002)(83380400001)(8676002)(26005)(76116006)(4326008)(478600001)(9686003)(66946007)(66556008)(66476007)(64756008)(6506007)(53546011)(86362001)(5660300002)(52536014)(55016002)(66446008)(8936002)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: n9i5zdah/MMd5N7+2PBuRE2Y2WZ+oF2RARqwCPEo1eTPWwch8iOGIWT+c1i903hr6YDDotGtCv09v1XF97RDvyWiSxd3xtu7n7e+c24XPkeyu8OrkvajbF/ImL2nGgS5KLCjPW5WzPEsYQ7zQC9fCYrnVnz7SjKyTKTeSHNK4P30eO0z0gYzysVJu2Z0PB1lj60kh4SysrZQgpVpgiWSnn+vF9tABR+QwnoRtyl2MTosLK0dwoPJO5Yet+I85mPECB5oWUZQ6Qgd8HdK0eGJMS66OJ/8oqBEkby4uGW8PO05BvQhm7G7c8HPyhxhxlWRrB4Vhh0p+ok6chR2jDY+rvqK76rbdom4shHO7N9DFA71GSGdXRMTnhSwsRuAA2pXFFDUk1xG7yRkMaM9N6jDKsjMUaQqj3UU4qwsfk9dK7c8x+qxFr4PZyJN3svJQa4QBzNTtcoGiQjtPDOvcuHMZ+q9kKYwRwa5f/45MDIfYI2j10zaZOnWbBjgBzIlTS2b
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1270.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b60598ff-bc28-414a-78de-08d82d4d64bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2020 08:09:29.7910 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nzKsz7Nh1/j/azVSr6Qtr6pIoHobT4NXRd4UsznlTjSEFrz89HcgS7uAMkrQrxUxdRPGgQl6qnlNJf4dL+ZFeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1270
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
Cc: "Quan, Evan" <Evan.Quan@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Commit : 81a5f33903a30574 has already contains this change, not sure why it disappear in current branch.

And does it make sense to set valid_in_vf to be true? Mode1 reset shouldn't be supported  in vf mode I  think.

Brs
Wenhui
-----Original Message-----
From: Gao, Likun <Likun.Gao@amd.com> 
Sent: Tuesday, July 21, 2020 1:21 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Sheng, Wenhui <Wenhui.Sheng@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Gao, Likun <Likun.Gao@amd.com>
Subject: [PATCH] drm/amd/powerplay: add msg map for mode1 reset

From: Likun Gao <Likun.Gao@amd.com>

Mapping Mode1Reset message for sienna_cichlid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: I9b8d39b10c7723af4589577fdbfa4acd5af6e85d
---
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index cae8e776fafe..bf3d6bbba930 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -118,6 +118,7 @@ static struct cmn2asic_msg_mapping sienna_cichlid_message_map[SMU_MSG_MAX_COUNT]
 	MSG_MAP(PowerDownJpeg,			PPSMC_MSG_PowerDownJpeg,               1),
 	MSG_MAP(BacoAudioD3PME,			PPSMC_MSG_BacoAudioD3PME,              1),
 	MSG_MAP(ArmD3,				PPSMC_MSG_ArmD3,                       1),
+	MSG_MAP(Mode1Reset,                     PPSMC_MSG_Mode1Reset,		       1),
 };
 
 static struct cmn2asic_mapping sienna_cichlid_clk_map[SMU_CLK_COUNT] = {
-- 
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
