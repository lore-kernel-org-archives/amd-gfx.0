Return-Path: <SRS0=vakm=IA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78660C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Mar 2021 01:24:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D17806186A
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Mar 2021 01:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D17806186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F2FC6E0DE;
	Tue,  2 Mar 2021 01:24:32 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 525146E0DE
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Mar 2021 01:24:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHaEMgjYKIcV6Uueblte4zqQZS8ocYfvimpQRK2mc+jA7eKc2zdoEtlqBGUv8aCcejI6EE7HjRPAQXSR24bM+6U6neynBfdR+M6YJqfjXXe5S6kMD7DNo2XYR9/vFFPw6hqeNwgqw+64/06KFRECiWDA1/TlIewdOHH7HI0JL306j3c0GJe+wLoyBshWG4ra3fJfKYujgwT6zZqt8MUdeMNb/sk3BsmOIsMfk4zloZCSE9hXbSYw7iRcBjge2UK3B6EKo2T77DW0Zxng9cbHbyPFL42qUPFNu1ME5UEOt+GgBX3EklZhJ5EhJpnZn/XxVtX/ST7BujQG9BVYKnLjZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KxE/9ScdH+9E1ig4MYRxN29ALJXnXKToO4gF/iLV2g=;
 b=ECHYsFoXjWTg+O5Q/Zn6nriJX6yUCIqwCoBx2fXIasZAHEfWQTJOI65/JCcbl535OflYJgblfDdvW/uLL7TU+Wrk8UkfAfK+LQRyIG/28fpyRx0ufgwdilOMK7vwMbtcOAXQsDLe9TPKlxTJN9KbS47TUr6fHl9v26qkIk38veqEcMcUy7cX678OVRk7zJyZ891/cObwQvLMEBcbWrx7j8v9gkl2TK75hX5PgWJ796rycItgOO/9Zi4Huo/OLlVQY03UZvxHGVctOtt8LieOzgHUHRjO5i9uhS+qRP0whAZCKZjW5gOEFNMs+yOYxKoVarTbh65O1iXRfoy4hJQs0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KxE/9ScdH+9E1ig4MYRxN29ALJXnXKToO4gF/iLV2g=;
 b=maG7PH2EmpWYjrT5Ouen+Ma+D4B+TWss2lUstzjkgOOPLA27udRRaWI/cUB1WuMW5K0XKAKgcO1lpu7tpLgBd1fFXmG0A+hu0Ef71iu1OzfbPSefAjsArdym1DgxiYMT4SNR57D5tSWRgtDI02IzX48I45reMy/ZhRI2203cO2I=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB2357.namprd12.prod.outlook.com (2603:10b6:4:b7::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.23; Tue, 2 Mar 2021 01:24:29 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0%3]) with mapi id 15.20.3890.028; Tue, 2 Mar 2021
 01:24:29 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm/swsmu: clean up user profile function
Thread-Topic: [PATCH] drm/amd/pm/swsmu: clean up user profile function
Thread-Index: AQHXDstrB6IFYKNwQEKzMVxjUSzuyqpv5Vsw
Date: Tue, 2 Mar 2021 01:24:29 +0000
Message-ID: <DM6PR12MB2619A701A935C108D6BFB25BE4999@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210301185122.977-1-Arunpravin.PaneerSelvam@amd.com>
In-Reply-To: <20210301185122.977-1-Arunpravin.PaneerSelvam@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-02T01:24:20Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=47865a44-a443-4bac-8e7f-ab70c9bb34ad;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f4b1547f-64b3-48e1-6d5b-08d8dd19ed43
x-ms-traffictypediagnostic: DM5PR12MB2357:
x-ms-exchange-minimumurldomainage: lists.freedesktop.org#0
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB23578CED1683944B242E45ABE4999@DM5PR12MB2357.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 057IU6uSkqK3stfgVtY7wbk43PpFqUDOPraB48rb3fVy26w51H9OhsgFh6FG6X6fYrwgjOzoeuLCjWCNxZJ+XtzuebJS6kuDNXQPDtplMQzibQOd+Udh+nr7bPOWgykW9Bu2nkhh1KLdu040qeW5tYr0TnfH9EldnDyvHGOs7z+IvejCfOIKSAnUvJd0FLJoQSLLyFQzNkxbNP/2w1r8WLBlE2hZCSj0uT4F+rSpGfyBjlDpj/WgF63RvIVOBrtikVMKvgRCoFKiXefspIiYyapceps955XF4Ax2mniVatMmWkFeiCgJaiLsVHLAIARBHt54hJP9IadAiuMZdin3Hlv1GQX4NqS0X17drvzFauRXiYijzBpRsDtUg9v60wiqnLAGq8c5EAImdc1ByoJaOEYa8dUXnSQAQQAR3IxkFfPU35ure7wOiKK/rQp44TuDHPoziuBH1jkoB934pFvdv9E88mraePFpp0vH4kjJVLyZF4CHN27Ral7jTy4WV7lCu+ij3m6sasuAHH5vUtskScCkNbelPL5CHfiN8ReaTCYwJiR14e2n10LMnKcItnwB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(366004)(39860400002)(346002)(396003)(2906002)(71200400001)(66946007)(83380400001)(8676002)(26005)(8936002)(5660300002)(66476007)(52536014)(66556008)(66446008)(64756008)(76116006)(33656002)(966005)(9686003)(6506007)(7696005)(316002)(110136005)(53546011)(55016002)(54906003)(86362001)(4326008)(186003)(45080400002)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?J9U2oA1D1fq1VYFl2VQGL50dnW8VwqLCNCnAG4kFVRlw1uvaFYxXW0DFWQBf?=
 =?us-ascii?Q?87JHsIiuFr6ZmZjg9RLtLp3asvGKENQi5faE9SUMedfSiJ7DW9ksN+kPwU1j?=
 =?us-ascii?Q?Im7oP3QP0HUyO1ea31WCNFge9AwKrxBs3bjqzHUYcEsl9VqNBlyqhRineedl?=
 =?us-ascii?Q?8lFkQW6zlszzFYgjqYSB7EllWaA8zH4anaOpHQ/TW/zlhnYQM4FZQy6ZUXMc?=
 =?us-ascii?Q?nStIbFYvaEvd5e8CRQWXV/X2gA9WuE+mGeLztKSALnaBZUpR50zfIKXAadFC?=
 =?us-ascii?Q?aEIFsBSS0bLa87KXud1AM3tB1E8z36poNJl2u8F9oVAvfY8ijX2b9N4y+3nd?=
 =?us-ascii?Q?IzpZeKqz4ScDueBjA8iYP5NBbmvZz7+QbCRVJQvSpU/ItN0XORHLwDOQ7e0j?=
 =?us-ascii?Q?EB/rOk6BvJz598qgXSqcaIb3KAI5Nc7ea80fLo785B8hxSqTfOfdDVKfdlq6?=
 =?us-ascii?Q?2w7q0Uutnqbm3V+WyCskOxC3+qq49/xMVyNOfKyQxD74vmi3pvc08BK1cruz?=
 =?us-ascii?Q?acIVgvKBHu3/hnPkk6SQSBhRXbnc4iVJ2WUSVyd8TRuqVJJVzOo0od0vNXzl?=
 =?us-ascii?Q?40YBr1w1M0AdGW+uQSEdANBBayLK98s/W7obP2EZ1wedXxc38apFXWu4tdR8?=
 =?us-ascii?Q?duFm2zibOZBHQHYcrVLR+lxCjYKKgTCGzXcYoPgTmToTbIbFhnO0SNEtRdgA?=
 =?us-ascii?Q?tAe3NGR0VpBjDKSlJl5yyFO4bZcIVfnNjC7s/o7Bl70F6gwSnbFFgI0TD5eZ?=
 =?us-ascii?Q?IYllznND9FI1GBhM7Fr2inOKE0m5ayaNfSpFm2Yi2mBepo9rIux2jgWLmfec?=
 =?us-ascii?Q?ine428KZRobTVB5smHfFuQwdMwde9JYrjFwAjyH3OY4CyMZ+E0pV1aUEGF0F?=
 =?us-ascii?Q?BPUXVbYu+v+PkUIzgcbLjZVdAmefFrssPa3Qa2EsgrACztNyOoqdNCjTKTs/?=
 =?us-ascii?Q?LpPaYl00M6+iPRh5LEIwwcPqVfYZJ4up348oW1EFH9cCje9GgGBt8mG7pJJl?=
 =?us-ascii?Q?qGuoeEH/0nSAGoC0Zb34YSX6TtJGqiesvU2s0mRQ9y9RJ1Zu4T7/2YzH19bk?=
 =?us-ascii?Q?TjvZIvdI6AiDFNG/dPMi5CCTN7d46zCMPo6AFj/IOCQKnLjmNxHA5JjDS0SU?=
 =?us-ascii?Q?SsUcy42wrSmtMUIK/ig2TPaxA9rCjgbJ+qiWZXDdTNuhdPYQ+7Aik2rbwW0U?=
 =?us-ascii?Q?MDNltcdTeCK6ny47pDc82j0KR0xgePTr/N+Pfpz0+04kRIhATjqagKPyVjvV?=
 =?us-ascii?Q?fC1NiTGq1/2VdZMnb1C+vThUvpXSTWHARsCUQ7RqOGk217QousBiec4r4L3m?=
 =?us-ascii?Q?p+mwpp0nkQRKIIXsp1UgsTZ7?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4b1547f-64b3-48e1-6d5b-08d8dd19ed43
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2021 01:24:29.5976 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X76U1soY84cuo8c2a5Sagj0AwTDRkr5ilxJnvOcVqrZegi+n41ZEfG6W7C0Mz8KJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2357
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "Paneer Selvam,
 Arunpravin" <Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]



-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Arunpravin
Sent: Tuesday, March 2, 2021 2:51 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Paneer Selvam, Arunpravin <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH] drm/amd/pm/swsmu: clean up user profile function

Remove unnecessary comments, enable restore mode using
'|=' operator, fixes the alignment to improve the code
readability.

Signed-off-by: Arunpravin <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index f5d9590f2178..7d7ef4fa2887 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -315,35 +315,25 @@ static void smu_set_user_clk_dependencies(struct smu_context *smu, enum smu_clk_
 	if (smu->adev->in_suspend)
 		return;
 
-	/*
-	 * mclk, fclk and socclk are interdependent
-	 * on each other
-	 */
 	if (clk == SMU_MCLK) {
-		/* reset clock dependency */
 		smu->user_dpm_profile.clk_dependency = 0;
-		/* set mclk dependent clocks(fclk and socclk) */
 		smu->user_dpm_profile.clk_dependency = BIT(SMU_FCLK) | BIT(SMU_SOCCLK);
 	} else if (clk == SMU_FCLK) {
-		/* give priority to mclk, if mclk dependent clocks are set */
+		/* MCLK takes precedence over FCLK */
 		if (smu->user_dpm_profile.clk_dependency == (BIT(SMU_FCLK) | BIT(SMU_SOCCLK)))
 			return;
 
-		/* reset clock dependency */
 		smu->user_dpm_profile.clk_dependency = 0;
-		/* set fclk dependent clocks(mclk and socclk) */
 		smu->user_dpm_profile.clk_dependency = BIT(SMU_MCLK) | BIT(SMU_SOCCLK);
 	} else if (clk == SMU_SOCCLK) {
-		/* give priority to mclk, if mclk dependent clocks are set */
+		/* MCLK takes precedence over SOCCLK */
 		if (smu->user_dpm_profile.clk_dependency == (BIT(SMU_FCLK) | BIT(SMU_SOCCLK)))
 			return;
 
-		/* reset clock dependency */
 		smu->user_dpm_profile.clk_dependency = 0;
-		/* set socclk dependent clocks(mclk and fclk) */
 		smu->user_dpm_profile.clk_dependency = BIT(SMU_MCLK) | BIT(SMU_FCLK);
 	} else
-		/* add clk dependencies here, if any */
+		/* Add clk dependencies here, if any */
 		return;
 }
 
@@ -367,7 +357,7 @@ static void smu_restore_dpm_user_profile(struct smu_context *smu)
 		return;
 
 	/* Enable restore flag */
-	smu->user_dpm_profile.flags = SMU_DPM_USER_PROFILE_RESTORE;
+	smu->user_dpm_profile.flags |= SMU_DPM_USER_PROFILE_RESTORE;
[Quan, Evan] You may need to change other checks(e.g. "smu->user_dpm_profile.flags != SMU_DPM_USER_PROFILE_RESTORE ")
to use "&"( smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE) to pair with this.

Evan
 
 	/* set the user dpm power limit */
 	if (smu->user_dpm_profile.power_limit) {
@@ -390,8 +380,8 @@ static void smu_restore_dpm_user_profile(struct smu_context *smu)
 				ret = smu_force_smuclk_levels(smu, clk_type,
 						smu->user_dpm_profile.clk_mask[clk_type]);
 				if (ret)
-					dev_err(smu->adev->dev, "Failed to set clock type = %d\n",
-							clk_type);
+					dev_err(smu->adev->dev,
+						"Failed to set clock type = %d\n", clk_type);
 			}
 		}
 	}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7Cd5866f2c3da84366c72108d8dce28c7e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637502212874693914%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=%2Bwe2XHK3BiX8VpVv9Ut7rJ28NJxUtWaCXo4wVpngxoM%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
