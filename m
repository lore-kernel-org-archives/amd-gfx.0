Return-Path: <SRS0=l6GN=4A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DF0C2BA83
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2020 08:35:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B469620637
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2020 08:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CjYeZ+Hl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B469620637
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60CDD6E9EB;
	Wed, 12 Feb 2020 08:35:58 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0BDC6E9EB
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2020 08:35:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKOy15M3lEzONwQRDKjKiW3hkw3xm/Tba/h/XDFs9uCQU4ouCDwR7GlbOgr/f1IJhLFhU8p6gI7Ggxj+eqLZW7ZImsHvyrQ/ofmm0xNUxkn6rS5/cHitob7vBKGetZLSFr8wMYLdcf4jVnjzJa4VaY2U3UhOrIl/OQfwoFZDTNdgLJUtdH856hunXW7r8X8j6OFvKcgF9YdIu1zG8d4LYGSvSaKEi43Ab8Oip8vk520YsPQ9tdVBX9CeWUM9p9un8jMl81damWyFECjYvBBta+qN25HIFuAonMO3F3MbJXEGr4TNCcA0M+Pl14C6efllZRzwshoi86oKid5H4YlOBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knLbhRpC/3Jxd6k5iWu59c84d74qMQKBQyLjKG8E/bE=;
 b=Kh0JzwejF7d9hloXue+zCdOUV6VcJOqmwGouGn81edRphj52onsunzvmj7VXpchA7AX81IoDZhsNleVKapGzTp+5Klm9kH6XN212j3ZFBCQ2MulPGBsLpBdzthdS/FDZz55ONjp2uXRtx1D59i9URWhogIhEQzKysyZkIr8OzaC/1oJUezA+LY5C8Xfty8mZTL1jFbFblSFkbToeQqB2jkb/k7t41SkhXq/aGRJLTU/wdwh/dI3MwLcpBPS36ynDc+y8vu1ANoPmWVW6UqcyNAgVmcurnNE2T47mBBGTHHDU4P34IH5Bf+S0w5QHkOMY7+awAZIE602Nc5p/5lARQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knLbhRpC/3Jxd6k5iWu59c84d74qMQKBQyLjKG8E/bE=;
 b=CjYeZ+HlJqJW6sF0wyLKRjYaRi0xSvblMhWEv/jZ88H180tPjfSaxYDe2vB432Hmxec/VQC3aAAE50Z1VxWu7vSpgcH9573b2laiNtFaftYxw8E6k8FqPnl9gisWMxhyyXN6Un8OwWIXSQrmJbz2QCTxBiQfnGWb0Du8o+q+JDk=
Received: from MN2PR12MB3598.namprd12.prod.outlook.com (20.178.244.84) by
 MN2PR12MB4221.namprd12.prod.outlook.com (52.135.48.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Wed, 12 Feb 2020 08:35:56 +0000
Received: from MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::10ce:b4fb:586d:8b9c]) by MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::10ce:b4fb:586d:8b9c%3]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 08:35:55 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: correct the way for checking
 SMU_FEATURE_BACO_BIT support
Thread-Topic: [PATCH] drm/amd/powerplay: correct the way for checking
 SMU_FEATURE_BACO_BIT support
Thread-Index: AQHV4XWRO8xjvhOAk0Cn/nCkoj/F/agXO4gA
Date: Wed, 12 Feb 2020 08:35:55 +0000
Message-ID: <MN2PR12MB359825DEE3ADFD029B3D90048E1B0@MN2PR12MB3598.namprd12.prod.outlook.com>
References: <20200212072447.16743-1-evan.quan@amd.com>
In-Reply-To: <20200212072447.16743-1-evan.quan@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-12T08:34:51Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=9985b06e-bcfe-4314-80f2-0000022447f6;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-02-12T08:34:51Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 4d82befa-59c5-4bf2-8f15-00001cafd908
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kenneth.Feng@amd.com; 
x-originating-ip: [101.88.133.221]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0cf07fdf-e336-4b1f-2a18-08d7af96940c
x-ms-traffictypediagnostic: MN2PR12MB4221:|MN2PR12MB4221:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4221377C68801AC3A88AA5CA8E1B0@MN2PR12MB4221.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0311124FA9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(199004)(189003)(8676002)(81166006)(81156014)(52536014)(8936002)(7696005)(9686003)(86362001)(2906002)(55016002)(76116006)(66476007)(66556008)(64756008)(66446008)(66946007)(26005)(6506007)(45080400002)(53546011)(186003)(33656002)(316002)(110136005)(478600001)(71200400001)(966005)(5660300002)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4221;
 H:MN2PR12MB3598.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9l5gUc+aXRTbuyfoJRBz3Z2oY+WOc2bykRhK+ABHVGuxQTTvHg+tdl2URE86eczbI5V32EzRS0o55zp+bSCRBAf44lg8jRtoJ54cmZL408jSpRMirFI1SJ23ElfA9FLjhyTcrL2zQAXMaXx+8jJBW2D7i/tOXBgJt52rDJuB3i2jqJAchytWYS1L/QPeahYhftOapebXblrXGc2ZBkWWCiBUxhVR/D8F6SV/xLEj1eThFCPVr9lvwOqhwxuHpc8uRFPnNE7+sG6mWzT7TuckcpRkFXabeSLSpStpHoE6dsvw0J0Hg87yodWs8SAAzDa0mD+BEUpY3k9yN5VyCfTU8Qm4k102vVTAUeOTFdgbiMcwD5/Lfwao6ooMgdY4uffkDS+MQLvFXM6ZY6/PR0ykTtFve+n5ybIjgzGGs57nVKst/BZm50bwHXDWUQlCxlDV3qyb1wU7MuiUtKNTrb1GyUBCzQCRfcdxt7uC4w4AYZKl916ENdbd+xXa28i0cF7bGXLk8Eu0aZZ4ELo0Nzip+Q==
x-ms-exchange-antispam-messagedata: lz4em3QOMShqWwSdHfee4hxJUeW9M0iMyITnhnhiZQxEnjccUzFtDZwcSWxmW0zm5/OglW/YWFd17hGZcpgT8YYsN22VvCDBIMU/IYHXe7ZpxO7UsgNcbjuzHuAflfIXYZvjLF5y124q1PNIaR0CUw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf07fdf-e336-4b1f-2a18-08d7af96940c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2020 08:35:55.8345 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wAzAh8I49lJ5YSsC7T5YekYC9iUP6+a1wr/n38dbXvGx3jRlUwKiphpxsIpkurUF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4221
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
Cc: "Quan, Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>



-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan Quan
Sent: Wednesday, February 12, 2020 3:25 PM
To: amd-gfx@lists.freedesktop.org
Cc: Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH] drm/amd/powerplay: correct the way for checking SMU_FEATURE_BACO_BIT support

[CAUTION: External Email]

Since 'smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT)' will always return false considering the 'smu_system_features_control(smu, false)' disabled all SMU features.

Change-Id: I73956ffa51d6da8375c7c377895a221e13d31594
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 7c84d48c19e6..6d4c99b016f9 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1489,7 +1489,18 @@ static int smu_disable_dpm(struct smu_context *smu)

        /* For baco, need to leave BACO feature enabled */
        if (use_baco) {
-               if (smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT)) {
+               /*
+                * Correct the way for checking whether SMU_FEATURE_BACO_BIT
+                * is supported.
+                *
+                * Since 'smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT)' will
+                * always return false as the 'smu_system_features_control(smu, false)'
+                * was just issued above which disabled all SMU features.
+                *
+                * Thus 'smu_feature_get_index(smu, SMU_FEATURE_BACO_BIT)' is used
+                * now for the checking.
+                */
+               if (smu_feature_get_index(smu, SMU_FEATURE_BACO_BIT) >= 
+ 0) {
                        ret = smu_feature_set_enabled(smu, SMU_FEATURE_BACO_BIT, true);
                        if (ret) {
                                pr_warn("set BACO feature enabled failed, return %d\n", ret);
--
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CKenneth.Feng%40amd.com%7Cda38ae9058e84371c27008d7af8cb337%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637170891151776945&amp;sdata=XSong%2FYpksq3mnwhNs6LCB%2F1zDypOppD%2FzcXKm6zvK4%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
