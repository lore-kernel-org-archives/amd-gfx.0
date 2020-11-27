Return-Path: <SRS0=Guv+=FB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D313C63798
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 01:59:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9839F2075A
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 01:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vovBHDPF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9839F2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC4926EB18;
	Fri, 27 Nov 2020 01:59:21 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A44A6EB18
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2020 01:59:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DkGirTbwE4iiknMf/Il9ReNOWhD8LP3QNVgeN0TBtmzirpXqlr4IQWhAf02Kjh7bP6cjff/V1tBnvlLNsPYbacve/kRzZE7iRcySWtNJyK+KDJShOIotU+hyDDsuxaChtS8UbX7+Bv0MMoeQCdcDBukKf7D61Pf+eixLQlNooNmuhhhOrCMiouGSk4qUNF6a5HMUwPF3wJ6iGcYoN4qwggREnswmJb9LJNlSgVlcotyRHwpTeWl3cdbRiBCNbI3cPbqwKtHBZxGZ/BVGYyBZKEjn8KyRmoj3oFMUARHFo0az2WFjxs73TT4NTgvhMwpLwLq3bS2U0NlKh4DZeeyQwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NhGKFfWHQgKYXfgQwe3YqA3Rw0atV+YC2a7mVORarA=;
 b=GNxTNKhYQ0NI8R3KtecXHYugA7jW4VhakDt199REYtNpU404LlI0Weiv3/03fBoWLDQkmEszCb/Lb56jlquVrD24hfuibEU/Ixl+d73oOvBwwG5btg7N9B5olkUoPkwYb/mGQtQIR68SJyQAjZ5NmWjDrzDsvFFOhXldvf3m9tSt4IpfUf3Izk2tNEjgB1sO0gbIpaY2npOSf5RXGJJpkJTtZUTuC6z5LuD1FEisH7ct2d88NB9t5aVHt+DXfq4HFDXDdnRQh0RYBw6DQy95T+ZjZVhReqUpaXxATyag8H9HfvFl/RKvYD9yhC80MbZP+FcirQBVrod793luVOub4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NhGKFfWHQgKYXfgQwe3YqA3Rw0atV+YC2a7mVORarA=;
 b=vovBHDPFrVuUlVi2pA2BYb4GjN6471um0C+bHKX3Mm1sZFlhNjV1yGhKcjY2GoJAh3EdUGFGM0iMLE0+FlggYdk1GyfmEnVcJ6taX9sQEJTv3ZcUqQM5yWKbdZCJQAeyXBwavJ7bvRkVxo0y1Wn/cnLrYbfZRsoGI/YPD5Gg+as=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB0219.namprd12.prod.outlook.com (2603:10b6:4:56::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.23; Fri, 27 Nov 2020 01:59:20 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3589.030; Fri, 27 Nov 2020
 01:59:19 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Chen, JingWen" <JingWen.Chen2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhao, Jiange" <Jiange.Zhao@amd.com>
Subject: RE: [PATCH] drm/amdgpu: skip power profile switch in sriov
Thread-Topic: [PATCH] drm/amdgpu: skip power profile switch in sriov
Thread-Index: AQHWw895ZK5ou452/E2iEy5KkrxOqKnbOiPg
Date: Fri, 27 Nov 2020 01:59:19 +0000
Message-ID: <DM6PR12MB2619EB7920289820E3DF7034E4F80@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20201126083756.3864267-1-Jingwen.Chen2@amd.com>
In-Reply-To: <20201126083756.3864267-1-Jingwen.Chen2@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=504535de-6e26-45d3-b257-73c3f01ec08e;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-11-27T01:59:03Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b6363e8f-5b78-4cdb-5579-08d892780db2
x-ms-traffictypediagnostic: DM5PR1201MB0219:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB0219855986A2B3D719413D1EE4F80@DM5PR1201MB0219.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pA2ytb/oB34ujW7w0WPZiH3UVgQOK/EddPbf6oMkB5SngRoPr3F3F0nW3GiuIPpUVooTVS/zPAq2/zr5OmfN19LtN7xEsgmSk4HAiX2M4Qrliy72IlNdEVTJq2HmLKIviy0KTkxSqeOyzrgnmjKPoSNfkUNHVahu8tZDXcZG636ZPxYN/J4ah97Xn971efiu5tgfZQXIg9rf8N1o45l0RSb6Bw5YynI1tQ+ovVnvNbwFfGeCzas9SzXILswOx147DTvdEg698+vakp4vr+NGk+iJGRK9WzXqAHc+NFXQd9Lv7wNsukn1CxC3w2V8/ASwPHSJZ5ZOSzQ7GKzMn+zFZBcgqpPQsRx4pP7mLYgzSXQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(52536014)(2906002)(71200400001)(45080400002)(83380400001)(7696005)(8676002)(86362001)(5660300002)(76116006)(26005)(66556008)(478600001)(66946007)(55016002)(66476007)(316002)(9686003)(8936002)(64756008)(66446008)(186003)(4326008)(33656002)(53546011)(6506007)(966005)(110136005)(6636002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?qh0nVB9HvnqEiU2jg+YjjWRLDtlx7ZPGITVhAIcEcz0dxhVkjf6yaY2ntiho?=
 =?us-ascii?Q?2tQhbpDm3maQhiwcjEB/tLLQ+6W+h+6DXbnWQMCoyRh82amvJ28MPc1xqKu7?=
 =?us-ascii?Q?joLtkulQnxDqX1tQhYnyOB+M+S4o9piWMCSOcsR0z2BFdEriQpdvNXHff53i?=
 =?us-ascii?Q?xFwl4Rkk5txP47Yj7Ep8ecve0vELPobzHyRSAgGjRCtbC1Be8RE5bi4NquZP?=
 =?us-ascii?Q?r4KFYeA9ErHIJWDL3loB0msE+tw2I5KHCfC0xEna1ivQiaUp4nnxpAbi9YkD?=
 =?us-ascii?Q?Oub8hjzsHJW02oBuS0Jo5h1TnN30ephWevzaPuVvBdc5C1/zPmmYWzZQdG1E?=
 =?us-ascii?Q?h2uS5iBUkOD9PIxD+bWZvwal0OZmiGBLLQYBpUqGs6r0ZOTecB/HIJT80Wux?=
 =?us-ascii?Q?6+aH77XaWZsh5qIFq2g1FR3d2nX7A9EG+AVdKvf46Za+4p86x6HlzJ/p6yho?=
 =?us-ascii?Q?Rpgp3Iw6PTvgkVa4UCLVeLkX/wtNHB0Gm+w8vmBKSToSIgBy/BG99U4ca/VM?=
 =?us-ascii?Q?hkpkHA8YFaQZ002h+v6PEfeCfWw2XEFtgQf1dXd1JNZTmFXiiTLpmFvw23cu?=
 =?us-ascii?Q?RxSi7/jlPtQ0y44a+aucDNaV1UYznJbeSDwAuxbaljg+1+jErccwzXIqJ3iK?=
 =?us-ascii?Q?b13ZZ+rtwOkN9mUi+RjCoQCqujKE9yFBkbXxldLKv9+XkYbCoRqRDMYey068?=
 =?us-ascii?Q?hYN9bocXACn61q4bvKT0mSQhJ0eu4tW2Fa/O+W3p1XKaXw4dUEeYkFbrYs2E?=
 =?us-ascii?Q?TzYy+QLn/RsoZx9bJ9EvxS3INi4kbKynnCcJPK+tWktkknk6obMNNJ9Hy7Gm?=
 =?us-ascii?Q?zM1YEMh8Ruq7+Z5RG2tQsgkFtqBPJ+G9AWbuq64o+D8AKww6B+heockuDoTZ?=
 =?us-ascii?Q?c6//ohzeJxH9KCLxk1DXn3l7EMKIfXPhVnATcf+E1fuuYQwlWX+zX25Kgelf?=
 =?us-ascii?Q?he7PoD77KSk2HZH1cQkSecSh5ZFqx2w34Zg3jEMErTU=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6363e8f-5b78-4cdb-5579-08d892780db2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2020 01:59:19.4660 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q5AhWzpq70awTqmq3WydRKJy9jRizF3yT3qDZrtPZ8YT6YtfH4Dsw+VB98u4CXBO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0219
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
Cc: "Chen, JingWen" <JingWen.Chen2@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Acked-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jingwen Chen
Sent: Thursday, November 26, 2020 4:38 PM
To: amd-gfx@lists.freedesktop.org; Zhao, Jiange <Jiange.Zhao@amd.com>
Cc: Chen, JingWen <JingWen.Chen2@amd.com>
Subject: [PATCH] drm/amdgpu: skip power profile switch in sriov

power profile switch in vcn need to send SetWorkLoad msg to smu, which is not supported in sriov.

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 17a45baff638..8fb12afe3c96 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1168,6 +1168,9 @@ int amdgpu_dpm_switch_power_profile(struct amdgpu_device *adev,  {
 int ret = 0;

+if (amdgpu_sriov_vf(adev))
+return 0;
+
 if (is_support_sw_smu(adev))
 ret = smu_switch_power_profile(&adev->smu, type, en);
 else if (adev->powerplay.pp_funcs &&
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7Ca24d4843e0a84a161aaa08d891e69af0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637419766916626849%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=uJk3bchf%2Fen1BTWQXiCN4Dcb3iRR%2FdZ%2FqwQ9%2Fgebo%2BQ%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
