Return-Path: <SRS0=Xhap=HJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8E4C433E0
	for <amd-gfx@archiver.kernel.org>; Sun,  7 Feb 2021 03:01:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E86264DEB
	for <amd-gfx@archiver.kernel.org>; Sun,  7 Feb 2021 03:01:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E86264DEB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5E0D6E52E;
	Sun,  7 Feb 2021 03:01:39 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2058.outbound.protection.outlook.com [40.107.100.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AC426E52E
 for <amd-gfx@lists.freedesktop.org>; Sun,  7 Feb 2021 03:01:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWbcFHuAMqvWW6fAV81cXC5l3xbJjcbKRn3nHGh9nYo0DysYf4VEn0S00Fpqwf3qOEgzOB2Rf+SqrUW/nLSuUY1c8s3Uo1gTJrirytUxCC2yobdlSJm+diVUUf35cqrMA2hpCvj9KgmAhgAlZnR9xc/QJPDmbbQJe8Lp1AugtTv9lupwfkqHtmP6bV/t35KoK+U57hpxcv2tVM8xvtjhJwP1+btR5XmHMmJV8pmJl2w3IyYe78xrzJFDFA3oPdSNGu+1qwYCSfSKSfA3DhKxJ/eLg+bJ1cifTPhaYp7QMJUMxoeLJ7Eyz5jhF1ujhzwjVJRR+6aAqIeIkUnBMbOrTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbDancBaYxvogNoOG6XJgvpQqOmrkAoa2y3OXQD3SV4=;
 b=F/35xmxQxdRgy1sf5n0vQZKrF52s9f9ZbVH9ueHd27yFMqx9FEb0GCAM8WSMWLtd/PQqnD7t7NgJlqtcfXUzlEUUxYmlJf9HafJWsr7iz/x/+wnb2N7C1FK/xBLplsPFxjR6JwwPlYKGUbmcIaLzgPT/VVwpCZVGxIkoxXxzVtTDKVThkepg28lrnnaMWBiaFjUpPDFnjxlQ0MbcqtO4Rra1SgdQyytdlt373Sg3kdSIReOmo6a0BSA4Tkuu50+BuGa1rcyOHwbTOfxHBgDn/j15iM6vxsVm8FdBKHYm5gNH/vWEIcTT9UFguIUyPdGzqUemr521mKV6qiDzYJFG+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbDancBaYxvogNoOG6XJgvpQqOmrkAoa2y3OXQD3SV4=;
 b=yKNtBG2QTNwm6kbuoKqDxuvtS9CIMROxTMm6gaB35RoZ0iVFbaoNl2Wfn75D2W2SqgC4GMIHa8WbrT5OhZAhKBCV831/WWLEZbfcb2Tr/f+SGV1GJ1ceilVZWiajP7zNPMRntuO9FR5XCnwk8znmZWG7mfgjq7yM6bVLuY+S8ag=
Received: from BYAPR12MB3640.namprd12.prod.outlook.com (2603:10b6:a03:aa::12)
 by BY5PR12MB4019.namprd12.prod.outlook.com (2603:10b6:a03:1a8::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Sun, 7 Feb
 2021 03:01:31 +0000
Received: from BYAPR12MB3640.namprd12.prod.outlook.com
 ([fe80::f16f:c71:adf4:cde7]) by BYAPR12MB3640.namprd12.prod.outlook.com
 ([fe80::f16f:c71:adf4:cde7%6]) with mapi id 15.20.3805.028; Sun, 7 Feb 2021
 03:01:31 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: enable LCLK DS
Thread-Topic: [PATCH] drm/amd/pm: enable LCLK DS
Thread-Index: AQHW/PQYdv2zUSqe/EOndH8ORar0bqpL/qaAgAAAWbA=
Date: Sun, 7 Feb 2021 03:01:31 +0000
Message-ID: <BYAPR12MB3640955B668905E21F02B2F08EB09@BYAPR12MB3640.namprd12.prod.outlook.com>
References: <20210207015344.21442-1-kenneth.feng@amd.com>
 <DM6PR12MB2619B62E1F33F5853CFAB74BE4B09@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2619B62E1F33F5853CFAB74BE4B09@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-02-07T03:01:26Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=f66fea63-255a-4ce5-b614-b2b8ea2ed132;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2ca9fe01-9de4-419d-126b-08d8cb14abd8
x-ms-traffictypediagnostic: BY5PR12MB4019:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB401979A171A26EDA91F6EE1A8EB09@BY5PR12MB4019.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: INF6f7xxbftx/YpXVKgtsvwNF/2zE956o7iNmF5p0lAeDn5NnLojHWRnSmsaIXIYDzwIbR3Hvzl9uRDq3kUha4tJ7/mULwAsEyiu9DoJahqJ667yxJP4xG+xSbBVm7mvwc8qpC+/IYfIUZgFK5ru6vtSTcyzx6gAVn6K/eRNjqV8gWP381KNiqrsfjucZHXwdgMqhG1T3igOZaP4zQega3caNa7HG4A9ugWDIEYiL9Ma9BkU0/SL8hZYHQKXy/Tghh8LAQX/DpP36N59lmUAZbfxln6oYOX9xJ5qMw4FWCzKVWYjO3Th1zj/JoHKYp2HVDuxIL8pBaEsAjaVeN2ry6gKW0Wb2pvzWpHmbN4HdYFd0WmR5Pz7qT319vYjylkFYyhY52USxwrRWf2y9VyYwb6NKjIUxf1Cy+kx5MP5h3n/JG13N939xsI9cGNCUTuFfWIdl0vOIZfaJ4G5iRGuv026SUj3SkoOW79HjT/UFfD1HvpiDWJfnDxL5ezxNIQpPUW62C0vRhyQ6WmkWIbxBCfrI3wED0v8zWhBm7edrAkmgidFJUA3WI9hkmQLjnrq
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3640.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(5660300002)(76116006)(2906002)(83380400001)(66476007)(55016002)(66556008)(966005)(64756008)(9686003)(26005)(8676002)(316002)(66446008)(52536014)(6506007)(7696005)(53546011)(110136005)(8936002)(71200400001)(186003)(478600001)(45080400002)(86362001)(33656002)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?4B7xVDE5V8mNuvPnJm26g62jWywVtqI15O59Yhj/bSCU8rm8ER95QWjUSCSp?=
 =?us-ascii?Q?Xw8ZeZ2SENkQ60cFTRYApLhyA13TNcgT8cCHruclbaLvKKtlGgr8cyEyEKTJ?=
 =?us-ascii?Q?8owuWluP6oGakcAc9jE/o9N3TZS5L6rPQebvspdHbCxHJDN8q0feeaVq74Wb?=
 =?us-ascii?Q?qXKZowIPXiKHugFV14+9t5I5VCK551mY6RYDCWExSHbKuEkv6mMNYmA9Ny9j?=
 =?us-ascii?Q?F2F8z6srRwvxLAS4vJRms35gDZDZk4e+BdWA3zz38qNG3NvMI6g8/hsptEnB?=
 =?us-ascii?Q?7NmagB9QgMoIt1Lk059XvKiuD4E7KMujf2WwTEFFuCW8A/EiFPqCcS5T+9Af?=
 =?us-ascii?Q?wjHPLa+5AfieytlgwiavOh3AZDtoakBZZj71e4+RaROczGBi542dxdtGhmGe?=
 =?us-ascii?Q?Cw3qCkMw1bYtFZSw++2OfUIRd+CMSU4OtVuVfECSDs09KzvQ6khQCcV9/xq6?=
 =?us-ascii?Q?0SZ/qg27iecB9G7Pxz7gbdFRmo9LOcMFdTa4kaouSsrt7nrvOxovzU3P0Te3?=
 =?us-ascii?Q?jawB4NXGZhlOH70AM4LjAiVr6EKtTXPcIKmi4E33L+WHAgmMA37V6eHlnGV3?=
 =?us-ascii?Q?efKTXAjYVdD0k076dQjvch2unJ4Jukr/kWd0tm99U1E/Tf88TXQGvDUc6oyT?=
 =?us-ascii?Q?w7tCPsr8HxclmQebUTFOiqotsHByAGCH9xIOTPyPA0YppFyYxMZt5zCn15a/?=
 =?us-ascii?Q?OIjyb2Q1K5dcFRR1eXFnkMcQpAFdznc67rP3vLrdqspTg/c39udb8bvPf8rG?=
 =?us-ascii?Q?oPFd0W2SUjdMi2UJH8BwGD5n0YfSJySyng/7fRhrBoLn0JoFE7kO5AwuTMwx?=
 =?us-ascii?Q?ngFhbly6SZaP5GQg69Zpt/S2mJz6Ks+49k9zVVMLADRzbAMIdFP7b7ym0Fp5?=
 =?us-ascii?Q?pk8XDHIDkG9w2sVGb3RmABJBD8Dg6fnpeSAmIkMKsVMPPkH/6MzMhsXs5AIb?=
 =?us-ascii?Q?tAxCae5ZPcT/uYp3+CNWlT90N0KNNmHM7ZHdaTsaxNLHm4zQZSkXteDKCm5C?=
 =?us-ascii?Q?i+t81eRy29G/QalPCKQ58WNqv9lbiUtWRDNRiJeUebCpuIvPXWEOPsVc2QuZ?=
 =?us-ascii?Q?vW7E7ZXFWd0uqPKugxnrYehFwQIXrBr0ya39zxEw8wvkf5ruAH01DcT1Ybnw?=
 =?us-ascii?Q?08+dq6qjEqPYAV1FUn92tuLYXlUyhSyZ2iwNj9G2qkS//66MRNkXYwZF55b2?=
 =?us-ascii?Q?dEVGuTBDt0PWX2iL+Iy6vsjQfuMzA8ptXVSn/UQt0X1P/i2fDW3NXYRZhZJu?=
 =?us-ascii?Q?p1UOjZ1IaHBI6WPGkrquw4wnEViZb1ZxhfZgRGhMOjoaytEJ47j6TS5738Tt?=
 =?us-ascii?Q?Z/DM986lJ7i2NC4XleeszDqC?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3640.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca9fe01-9de4-419d-126b-08d8cb14abd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2021 03:01:31.4125 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g6t+IGYwQE9CKZK3wjBSF4ZjWy7+uaNCZq+/wlHOLRFnaBEzFUHEvF7nDhAL+YaB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4019
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Yeah, the condition check is better.
Thanks.


-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com> 
Sent: Sunday, February 7, 2021 10:53 AM
To: Feng, Kenneth <Kenneth.Feng@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd/pm: enable LCLK DS

[AMD Official Use Only - Internal Distribution Only]

Do you mean ASPM is the prerequisite for LCLK DS feature?
Then do we need something as below?
If (aspm = 1)
ppfeaturesmask |= FEATURE_MASK(FEATURE_DS_LCLK_BIT);

BR
Evan
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kenneth Feng
Sent: Sunday, February 7, 2021 9:54 AM
To: amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: enable LCLK DS

Enable LCLK deep sleep and it works if we enable ASPM:
modprobe amdgpu aspm=1

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index b9e47f3b0231..d208a434c7cc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -242,6 +242,7 @@ sienna_cichlid_get_allowed_feature_mask(struct smu_context *smu,  | FEATURE_MASK(FEATURE_DS_DCEFCLK_BIT)
 | FEATURE_MASK(FEATURE_DS_FCLK_BIT)
 | FEATURE_MASK(FEATURE_DS_UCLK_BIT)
+| FEATURE_MASK(FEATURE_DS_LCLK_BIT)
 | FEATURE_MASK(FEATURE_FW_DSTATE_BIT)
 | FEATURE_MASK(FEATURE_DF_CSTATE_BIT)
 | FEATURE_MASK(FEATURE_RSMU_SMN_CG_BIT)
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7Cb1e8027ec41e451c768608d8cb0b3b29%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637482596398826719%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=hgcKYx59KUGzn7YCQsOXsU0uJXVDIeoduFba%2FQDw1Z8%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
