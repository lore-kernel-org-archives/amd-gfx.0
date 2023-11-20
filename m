Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83EF8C5ACB3
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Nov 2023 02:52:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80A3A10E220;
	Mon, 20 Nov 2023 02:52:27 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C461010E220
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Nov 2023 02:52:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MdrGpVLYUI/8JDJcGNJFP1iM1XK6e5DLq4nWAVhfowFdfdadt45Np23kDg/ZB7T2yqCWp9WARG9ZbTRVipgx24SyIFN0lY/i34If0J7VEFh0NjllTWKTy79VrjJBJVYWteObEuROGa7PYnZXLuo7ad0ZVlUdLvUdsQ4mMxNnZFUoEgkJNW2L8WwWkUPMzjr8aF89nGo1ElbPdIiFCI6CGwag5q6eGPFoCRmDdR4Gbm2QEIP4FMFBphcbc8rW0l20eqipA0b2dPS2UU75bx030cG0800T94iEsz1tqDy+HLVuX33dtwJUjDqOQj2QsFNxEwwhfTfS7JpSVk+ZI3R1gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUtr/wGGI5TAPYBKr6QJU43v6MfiYQbSCw9xArEwM5w=;
 b=aOXdS1eU9cH8jQxNLHUdy00ugWwNykOMiKZpEKc7eHk1zuyO0zlKWo5mcECxC+63qu9iW+nLEY1aWl3RmZ2Xn4cbYS/WrLLs6QYlTb2Urx9dZyzTYPvLwydgLoTf57A7yAiqTkKf+jyiEe5YtcIU3i9q8pkUCfwbciNZsylpqOII3Nn4nVv/mLxTCxWIj8p4wQkMcd1qu08Fhw3pXqnVYkN9rg4yqQ28X+glLZs3dDnIkWsDonq4zy7Hak85zYnNf6RWopQZw1yBgDBBJwpRxBwvdsPBOQRCRY2kYESDc5adnXUYns9zftwdD/8pvzju2LFvB4rPiRKLvaKpznTHgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUtr/wGGI5TAPYBKr6QJU43v6MfiYQbSCw9xArEwM5w=;
 b=hH9E+1IUhXA26cYJEhjvfh8O5GFde7NUB2TR+BAcDvllNodHO3Z0jSGspV5QapBxS5LNiOS7zvenUBWYNAAmLWLxmnGpmrYhBz8fRTjxp2v8RzP/B34rrsOMdxnfY/Gzsp+cx+OdsG5nl1ba6dsbrXT1N9lbYsXRZ6TcdDb7sSk=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by IA1PR12MB7664.namprd12.prod.outlook.com (2603:10b6:208:423::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 02:52:21 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::ca1f:8b18:846d:234e]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::ca1f:8b18:846d:234e%4]) with mapi id 15.20.7002.026; Mon, 20 Nov 2023
 02:52:20 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: Update fw version for boot time error
 query
Thread-Topic: [PATCH 3/3] drm/amdgpu: Update fw version for boot time error
 query
Thread-Index: AQHaG1w5wYfm5tjAPEm3MiFljyhiDLCCglKA
Date: Mon, 20 Nov 2023 02:52:20 +0000
Message-ID: <PH7PR12MB5997D53EEB51C64824ADF5B482B4A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20231120024855.27697-1-Hawking.Zhang@amd.com>
 <20231120024855.27697-3-Hawking.Zhang@amd.com>
In-Reply-To: <20231120024855.27697-3-Hawking.Zhang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ae63cc5d-fbda-4bcd-9d8d-71a2b3524344;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-20T02:51:54Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|IA1PR12MB7664:EE_
x-ms-office365-filtering-correlation-id: b87b9b16-cd56-45f6-74b1-08dbe973b744
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o49kyjdhUsdHiZwx589z8boaeWK9r3KihNmPjmLFTS2Qg5WvrS+V9ypeQpNLHZ7t9DbDlMGZi+6N89/Q9nF3QqYxQbmWFyROp6I1Ws6OAU48iqoAcSnB8h7nLjMCkGogT7UTDjLX1fhoyDG/qvE0tJQ/ezKAN0vyYwsTy8EUK75lylmgJQOOuG+gWp8F4oAx9cLhRjUICqD8yfxghLT3dakJTmlonSzeEnwJlZAyda6/KhDOiNVnSLDN9ukFF4/QQmHhFIcZZLTyZcN/MvSltfFaXjNG7mXcDYEylXyJ8yvSmZVJNFOhN9ruM2BnHAi5IIToHKH9YQA4eD6YqWMfgQMs3HUpYMcIIXyC6SIYp4pa416BPYJGbimvnpNWg7q3YXO+cMFaiTDH9ef75EYtkq+2q92PaWTnrSj3iOnYKlMKP4GPJ7WNXk909HuFLop/Rbkx1CvR+CNBERMPkM9aUhI9sG3zD43+1KuwmPIZ5TLuq+jn10JQ6QMh4FiuJmKNAMYhItDFnS40QRsVLT/gdOEWkhCZwhQz5XDsa3uIZQGZAlMpnwLaKI+6WugqMhmyppwZB1nSwoVsvmIL/KJxAbzDU1NBSvPR/9DQC0J8IgXBQk0Y5gukiYSqjXA81i1l
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(366004)(136003)(396003)(376002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(55016003)(38070700009)(86362001)(71200400001)(110136005)(7696005)(6506007)(76116006)(66556008)(66476007)(66446008)(64756008)(6636002)(66946007)(316002)(33656002)(122000001)(9686003)(53546011)(26005)(83380400001)(2906002)(41300700001)(15650500001)(478600001)(5660300002)(38100700002)(8936002)(52536014)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?osODdvuE8z2PgiWW6d+XlPAs2IdEGEqqZjP/b+MqOGuyKenjFwEIRLTiuMRJ?=
 =?us-ascii?Q?qnRN20xsoAbvQi7LDl60QisFsf4dJpS0nrNXNL0kJGUPCrkGaGbml+7c8ZDi?=
 =?us-ascii?Q?423mxP4u4hbPtcc5cwGwCwhD5Mpkungu+BKpYBMPXb4VfHjRLw9I10b7bwZj?=
 =?us-ascii?Q?t3ENZxF0Ss0ZkwigFnjlBn4W4n/++pETZsxep7NhbHNjpfLg9Cyik3pIHd2L?=
 =?us-ascii?Q?IePo79FQT90zEM5WfibQt+nGinmUYK1xREO4gRzn62QCIJ5PJkG+MtKjBJEK?=
 =?us-ascii?Q?kb5Jb7CJko7JizEOlnuNhvD9b+tHwNET7Ztin8yB11LnZsssSkGCP9N6VdkW?=
 =?us-ascii?Q?uXQznYEmklbyz8KVznfln/P/c0WI32X1y4nTHLqg/fa9qRpi9kagHvdyArLD?=
 =?us-ascii?Q?jHhxSBLlS6Hp9dgCOOULEsXhIxVa9QoBer6MpX5Nf7GJWEbE6qtsodMTRwOp?=
 =?us-ascii?Q?kE7R3/1yBsDMXvYw8ctN8ZdiwL8SipFiX+b9LkjRg+e0pI+Rswr0eoKQvKSP?=
 =?us-ascii?Q?F+ZzAIUcUZZXCDcLfe8hPfichgoASNSfwkCL9OV5t78UmE1k+0aPNRMkcPD8?=
 =?us-ascii?Q?LViKnl1Ph/SZo2QwHeTD5wIoMYXISQtyUqvJyjfAnKLsQWJVzRvpTHcSDbLI?=
 =?us-ascii?Q?hMQPbdEyheXjw3WjRfVuPrsH9z5w+VhdNvynHZ9FYgoPfr3zynPGdmc3tsM5?=
 =?us-ascii?Q?d561gOlJa4ByqgoQnXG1Yj3gZeKLouzuv2VJ+Xkb4yOvoXcTqLXtnnK9Vtly?=
 =?us-ascii?Q?aOcUf61BrmstxIcsnzlIQW7oAy+1EtXw8h9V5D+V8rL0+FmNbGgultIT7Vei?=
 =?us-ascii?Q?/+5vz01WFEHBShJCkE6SRT13vW9mp9FNiaMltFs/vKFGG8d29f5mTHCI3Mwj?=
 =?us-ascii?Q?i2MKrAJiAVjyzHH5ythYFu/AL0zr4eHi1oQFteWUlQOxo0RHcTNgq0n8skHL?=
 =?us-ascii?Q?vXR4saILyJ0euphH9YIPY0+xkM08BYGzrEpb1z3WMdNLbUIF+nbT0th2EI08?=
 =?us-ascii?Q?fOfiYluMDk1LLZVhnIc3hCy3QVwdHFv5Oc92QE3cTpaxwl/+WMaVsLUdzK/q?=
 =?us-ascii?Q?iJgZud4POljPi2UDuattoR5H01mzOoR5GHY5QF2ypZus1OrY3CASvLGREcxy?=
 =?us-ascii?Q?HNHJdnq8x4Db641F9mrr7WnJwSKa61nUKprHO8pPsB65TnShwfx4JaL3TJz9?=
 =?us-ascii?Q?ekZci96gqAVw4/CT+tdJbxr/GIV8Xt0za3s9MkbSjPICAYNKiKm7rP67o5id?=
 =?us-ascii?Q?1udH1z57tJ/hDDZQAo6WECX7iTHILR3vSwMFj08lSWnmOQGxAS8EYSLlCmsU?=
 =?us-ascii?Q?P8BngGjTJlQaelspB/SrGfsaVpCXQ8uuY4hM5TiTCm+M+ZwmV+Og+HO8BWN7?=
 =?us-ascii?Q?HARtOr1StFPrircpWwRr+r0J/ta7ERBUtsHBKZ6BD1BfpFFx+/eorTg2ZZ1p?=
 =?us-ascii?Q?S5lWggOjqRE14Ml7pPMELvSQZPyZu6sUe5boaVnh36MFmJ0wNAhJFM0Unj94?=
 =?us-ascii?Q?EaI39smFS6cI9R1ySs7//uRQsoKJguUd4lWC3+oK2tyTK82Aj1NFgfv2M2Vh?=
 =?us-ascii?Q?vcbJk/d7z8DWhACLrzE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b87b9b16-cd56-45f6-74b1-08dbe973b744
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2023 02:52:20.8156 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lj1nKTzyN23qn2+pcqmgVcz06D58/olZUj1IFlgMq4oKiMXDkNMxhczN7TLlTHji
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7664
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Monday, November 20, 2023 10:49 AM
To: amd-gfx@lists.freedesktop.org; Yang, Stanley <Stanley.Yang@amd.com>; Li=
, Candice <Candice.Li@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Update fw version for boot time error quer=
y

Boot time error query is not available till a10109

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v13_0.c
index 3cf4684d0d3f..5f46877f78cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -821,7 +821,7 @@ static int psp_v13_0_query_boot_status(struct psp_conte=
xt *psp)
        if (amdgpu_ip_version(adev, MP0_HWIP, 0) !=3D IP_VERSION(13, 0, 6))
                return 0;

-       if (RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_59) < 0x00a10007)
+       if (RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_59) < 0x00a10109)
                return 0;

        for_each_inst(i, inst_mask) {
--
2.17.1

