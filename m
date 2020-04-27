Return-Path: <SRS0=xwvD=6L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C15C54FD0
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2020 04:26:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EE4F2084D
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2020 04:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AWBE2HBG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EE4F2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C26D489FCA;
	Mon, 27 Apr 2020 04:26:04 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E99F189FCA
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2020 04:26:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKxmoRqxPTuotdUDsXNqDTYDnojhSEn5fLnjbb00xxjpOd2PJXujTioXnbfKM97w2vSli52JiYvjNkQe7tlCPrzkQsqb4SL5ohhdHbLNhWNL9SphTKDT18bME9iGDW8OTRtjmgcso4O64zO55nApJecWDDJrgf7Zycn9oKb4SmxQ8GFtJr87CZnSFuQ0lWd1q2wo8sB4uYEWF+GmAr1hRrJyrKlUf9ag96VALTQ9rkq9so4m2WdMojAbP1JvLxX4dOuFpsDO0Xbo1i1YXwZXR8pTWoKpZLtQE9Xy9XmeGeja7Q68y7H++YS5kpccjOyFCqcsR7y9hjsSQ84+MZMxlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fxc3qORY4nnRNaqwQ0X06m7eCcRvQ2K2+xnoDT5ccHE=;
 b=PvXNn3ipFgYBDoJwU/hCKpQ50TKSwAAeBkeC/c+pId1a9t+L7B6k6+851eLCA5eEDzpfpedycFzBDyHxrLgC95HpwL33aU67WdyGU5MI6xUdLqwIsZM4H+tWTyZp4uLgEUfjeLs5byWVh7+gsVyAsYFVLS6VAWnLhB6Y5q4MziL9tSTA8aP4TV0m1JndRVKsF6NzU6MtMuMaMY74sKsVzbOKXueYqOs/ZSCY53RZtvozznS3VQm9oYda0+gqv+DRgwZQzJtA6U9hlfA2NMAad87c2/s1Hze1+fDTTEZjTd8Mvy206DCtlit11G6U65m4DM4r2nosF9gMXoep2R/2lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fxc3qORY4nnRNaqwQ0X06m7eCcRvQ2K2+xnoDT5ccHE=;
 b=AWBE2HBGK/5S9FiwvkmvQXbyFSShAcTLisx/j5n5q55JeIC0m8xR7sdhoSEbHBDcG7YOBGFlLJdHY6j2tBIQ6WeVZbRetZKoujwQwco4gfbKuXnyJWepvxJJCKGgcRsJswkRVNlGxCre4PQ/cK7MYrXIRrXbl3s6sok41wCLLk4=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB2892.namprd12.prod.outlook.com (2603:10b6:5:182::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.22; Mon, 27 Apr 2020 04:26:03 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd%4]) with mapi id 15.20.2937.023; Mon, 27 Apr 2020
 04:26:03 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix one vf mode
Thread-Topic: [PATCH] drm/amdgpu: fix one vf mode
Thread-Index: AQHWHETllTaqLdRLPkWrC2qwVl26UKiMXoeggAAAt0A=
Date: Mon, 27 Apr 2020 04:26:02 +0000
Message-ID: <DM6PR12MB4075AC2D5C65D5B661C7FAC6FCAF0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <1587958502-10638-1-git-send-email-Monk.Liu@amd.com>
 <DM6PR12MB40756F527F7715A384A74632FCAF0@DM6PR12MB4075.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB40756F527F7715A384A74632FCAF0@DM6PR12MB4075.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-27T04:24:35Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=ab523217-3d8c-4a90-903b-0000e76cf829;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-27T04:26:00Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 9b7e15be-e2f0-45b0-b4cd-0000f1ddd1c3
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6ef54e9f-e2c2-483e-84f6-08d7ea631882
x-ms-traffictypediagnostic: DM6PR12MB2892:|DM6PR12MB2892:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2892892B88E08356EFFEA634FCAF0@DM6PR12MB2892.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0386B406AA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(64756008)(966005)(76116006)(86362001)(53546011)(478600001)(33656002)(45080400002)(4326008)(8936002)(6506007)(26005)(8676002)(55016002)(71200400001)(66476007)(316002)(5660300002)(66946007)(7696005)(66556008)(66446008)(81156014)(186003)(52536014)(2906002)(2940100002)(110136005)(9686003);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rlVh2kaiqAsA3hj/rJY1lzIzzHjwBpDBBpVEx5EAcxOLUwo8RyJk67VpegYohXGP2TzSKFgy653qLPFcryo67ifTyJEV2B3rMnNr+Yx7U2YvhHy7LmDM8VsQr6LjhhXsTAT4OS2bTadeTVVe7SEthYcyrB4MBk76Ot6g7TBAqkY4LHhsF+qe6R3ojauYA0YBbruWLhxyG6/S28zxnmoSESAuo+LonA07WYcVvkAznAnW+4M84BUuOcV633ODHCLF2iVZ8c6yFuvsi6f6YEguCUTTvJP1GVbkmC+ePL4lZUvOLCSORjrIC1+fGTykWDSo0iq+CvKujg6Niz+2WDYI2a+KanAhB8J6Rq5U6GXGKvZ7RhQ8SaxiYYNRUR2IgTu4VgCLth9Id/yCElI4++x6guxub07p3jKKpvXn/Nwn4yijHXx6xRUtaN5qyqpGHFbb8ubQUa+ytMz0PsiDqONs9bjTAS4fCdI4+4ClVWLiwUE=
x-ms-exchange-antispam-messagedata: /syVM9+EellfCF8NHnbFFc7Ype0m7G36bv5iiPotM3zugX5rs9+y8nkYpu/g4XOZ8OfAXbPe/8Ba4vszHv9swOGoqIFaUG6gFRBuYSQ716oAms0mWdsifmXP324XLOA6lhE+LbaXr0ERBUQqP//6KadbgQAQ1L10TP6PpOQTpPeMAnP3tACb4MvGCMe8g9I92PDG8dvFHkn4cFwlN4qb3ixXUdHqy+gH4VBv4IHUHfTp1L3ReorN6zqXibcpXhrPs0n+5r9UY5hRe04n2JiBur8o9izbO2l2Ex1YshAjpkTG0rF9A+yB5Pwcu0euavEnsJ+EZ5XxT8jtR9jjNV6C4Jghw5Vleas5K7LboZZvJOG4Fb9jvalKx9YSWpUiiXjQPHf2odZN5e7R5tKO2we2Mx/8kIZHugraO6gDdfObB3b/WJOpZ2Gc46oUAhWFUF4M/B6hnikj9CTSdwKkFG+LbNQSZ4tmpPTo5qw0slXUk5HrZu5CIv3Zm1BDW23aEJ3m7ko7oDqBYpCTpiE8sg7kjOv46DW9HMoePA1gATHgk9Rgy5DAkn78TLht6XcjvwrWlMAiIT+VBDlul79yGnhi+ZFsE73U7HHm2Z+4uNdlohny9OE5KLNPhn8T5StWOtvbvH0NaffaDKUQNDJcCn+ouOTOURB3GnNaAcyCS6swVNQAe5kkNGwUmElsP47QS8Ow9Sf7RZjPmTXFDtc3aSJ7l3ifA383BhgL1dZ0hqQHaDbVSl8fpJQW+T1bwYIWrQpX7RuyJgC3cSclpbFEFsk/4SXkVbj1S7+OQOzcFz4nO4E=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef54e9f-e2c2-483e-84f6-08d7ea631882
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2020 04:26:02.8455 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6zQDhhz9azOUZ49N7aanrBpnlbFJjklqx3tPFCQfOaa4TmTYN+dioPWQbvHhgdXPfKH4OW9/ZkQE6eXlqyv91w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2892
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
Cc: "Liu, Monk" <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Sorry I shall say hold on this patch until we reach agreement on how to support onevf mode in current software smu design.

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhang, Hawking
Sent: Monday, April 27, 2020 12:25
To: Liu, Monk <Monk.Liu@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Liu, Monk <Monk.Liu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix one vf mode

[AMD Official Use Only - Internal Distribution Only]

As discussed, we want to keep this patch until we finalized onevf mode support design in guest driver.

Current approach to add one_vf mode check for every smu function is not sustatinable and error prone when new asic support added in software smu

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Monk Liu
Sent: Monday, April 27, 2020 11:35
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Monk <Monk.Liu@amd.com>
Subject: [PATCH] drm/amdgpu: fix one vf mode

still need to call system_enable_features for one vf mode but need to block the SMU request from SRIOV case and allows the software side change pass in "smu_v11_0_system_features_control"

by this patlch the pp_dpm_mclk/sclk now shows correct output

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
Singed-off-by: Rohit <rohit.khaire@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c |  8 ++++++++  drivers/gpu/drm/amd/powerplay/smu_v11_0.c  | 13 +++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 5964d63..bfb026c 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1183,7 +1183,15 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
 				return ret;
 			}
 		}
+	} else {
+		/* we need to enable some SMU features for one vf mode */
+		if (amdgpu_sriov_is_pp_one_vf(adev)) {
+			ret = smu_system_features_control(smu, true);
+			if (ret)
+				return ret;
+		}
 	}
+
 	if (adev->asic_type != CHIP_ARCTURUS) {
 		ret = smu_notify_display_change(smu);
 		if (ret)
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 3e1b3ed..6fb2fd1 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -764,6 +764,9 @@ int smu_v11_0_write_pptable(struct smu_context *smu)
 	struct smu_table_context *table_context = &smu->smu_table;
 	int ret = 0;
 
+	if (amdgpu_sriov_vf(smu->adev))
+		return 0;
+
 	ret = smu_update_table(smu, SMU_TABLE_PPTABLE, 0,
 			       table_context->driver_pptable, true);
 
@@ -922,10 +925,12 @@ int smu_v11_0_system_features_control(struct smu_context *smu,
 	uint32_t feature_mask[2];
 	int ret = 0;
 
-	ret = smu_send_smc_msg(smu, (en ? SMU_MSG_EnableAllSmuFeatures :
-				     SMU_MSG_DisableAllSmuFeatures), NULL);
-	if (ret)
-		return ret;
+	if (!amdgpu_sriov_vf(smu->adev)) {
+		ret = smu_send_smc_msg(smu, (en ? SMU_MSG_EnableAllSmuFeatures :
+									 SMU_MSG_DisableAllSmuFeatures), NULL);
+		if (ret)
+			return ret;
+	}
 
 	bitmap_zero(feature->enabled, feature->feature_num);
 	bitmap_zero(feature->supported, feature->feature_num);
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Chawking.zhang%40amd.com%7Cbdd39fed708f40f172e208d7ea62ea73%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637235582882901954&amp;sdata=FN9JLQo8MeWUXHpRxrKRanwd7B03LjCrXMuD%2BjjjZRU%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Chawking.zhang%40amd.com%7Cbdd39fed708f40f172e208d7ea62ea73%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637235582882901954&amp;sdata=FN9JLQo8MeWUXHpRxrKRanwd7B03LjCrXMuD%2BjjjZRU%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
