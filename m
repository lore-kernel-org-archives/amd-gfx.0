Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B8CC38142
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Jan 2023 08:58:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E205810E31C;
	Tue, 31 Jan 2023 08:58:34 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 078FF10E339
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Jan 2023 08:58:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g99Opp6rNN2rfQTFBI7u3eAesz0gKy1NU+mKXLbgd7UIuOz1GnNxjd2V/XLokipprJOoxF37MLdtlRo5Kn0QEJ01zoKSvjBZkfybNsaYEfSGELOqxbOJI9iyF7I2zWmqQ4QDboV9X14mj+QziYZ07Fj1lRMLeNjcd5dwcKqI2KP3YSN6fGjtjD1JV2sPP8+bqQMgrKoT2xZTIVAjSkAq2+hvqPHlvcC3jDxppAlfTyIXNSvw//9nKCsPiJQXpOq2nWvSZpSDB8yfauVHmXcIX8n+X0cu+WqS+HCUgDRVa8nNEuod0Nk9dWhy4mlRZJlH/2//2yjq/uAUSVOXJNxJWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnkSgo/tQ0ZTs2J/F36Jm7vHY4WOvsiiIG4UlQhteNk=;
 b=PqLqV0/PHyCL3C440/xVkZG7ZBcWK9bXDFS8LuUojazuW5t4hAfzQUMLFcCwuTIteOF22C0Tisjt3Lqvcwi2CCZ7yioQZgsYEW86cPT+UdcDt7V3Kf0G6drsreJNnBxIPnuGRCnWcDOoWpowT2boMS7StLh18/dGhnoVOZmcUjD2tN8rHwsgrQslt8ytJel4iE8l1SbfonafB19YTdeUW3QNgckBDcZbjwrNl3/KgcbVTIlnoy83oP5oss6+Y8rax1b8BHjxB/l8KqrWAdh3atINOTf1/y7RhUSJ7eb3677JrBqutal9Ht3jxOLvxoAx4WaIaJzyEifwMKD1J8+sQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnkSgo/tQ0ZTs2J/F36Jm7vHY4WOvsiiIG4UlQhteNk=;
 b=S9iNHSa+ZzUNv4MBDjkPjBtgIzI1UKs34R4eJ3+veEcMg1dIl+vd6gpLH1VNw9X/L2CT0rhgIg7xuFJc38Tj6iebObdzVoHsJ8aHZV96eJwpmSwlqSyMcO7hfoJQgoUuP/KvrINKWEajwLZLjA69yS/HU9Fc0CDMRuvYkhBA6wY=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DS7PR12MB6165.namprd12.prod.outlook.com (2603:10b6:8:9a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.25; Tue, 31 Jan
 2023 08:58:29 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::27cd:5a5c:4713:83f5]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::27cd:5a5c:4713:83f5%4]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 08:58:29 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yao, Yiqing(James)" <YiQing.Yao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu: Enable vclk dclk node for gc11.0.3
Thread-Topic: [PATCH v2] drm/amdgpu: Enable vclk dclk node for gc11.0.3
Thread-Index: AQHZNU6qoaiFwjPYT025/zXpOY/plK64OYwQ
Date: Tue, 31 Jan 2023 08:58:29 +0000
Message-ID: <BN9PR12MB52578E0E3C489A84229B6D61FCD09@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230131083250.3323885-1-yiqing.yao@amd.com>
In-Reply-To: <20230131083250.3323885-1-yiqing.yao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=eccc2ad3-97b7-431e-8ca4-c24989f91f64;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-31T08:57:44Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DS7PR12MB6165:EE_
x-ms-office365-filtering-correlation-id: d3d8e6ad-430c-4e77-e7c2-08db0369529f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ddQzpEOj8RDDg+YVQJg9if/I0w+nmn/jhuoqVxpP7XyV69ffEEyKwCwyKxC8ackZfCAEuIBwGk2Z02iJMpwIS8yzXSiasrsbyGpJ4a6pWBOVm23LasF8+cW139C8pBWQFYhoJFDVRJre0YlhmeB7jb/89NvxSzBR6PO46WNaneizIyebndDlTRgkNpdip5g4Ys0EWM8OdMe3ONx91YxxdkNnVH3inVm5FAOLqw8mLihYspbN5UuZ2BNPhWxkfFMnCMgX3Ohz1Kk6D73pQGByERtpLAVXmtUV7NoWlZX5uLa791/G8aZffS46DUvB+rKJJtctARtvcPHrJ2zD4Vm/X+E1k8CByTK6MdA3ghxTyONpvc7f2izjhgIq63AZsKjKPvLmkV5H9tfjy4CKLn/bmaUd9JjI2U/Z14MPpYO3m86KpDLlvwwpnbbW6AIQdcZLf4ROn4re3m4pwcz/4dN+PmLPKVEfhFnYXhAKc9AIl5o1NCfNNP9OG1HDx/WQl7rJpAwqMt97GpdFbDoc2lFqWOCayYcOrmxlUPCamuvPMkWs2rnmCoWZar3L3n7gqbXyAakfXTNHk5NCVE56vopqXbfQhgUFlk3+cGEGiTuKtPyVCp81KafXTC03hCPOfOIGxvhsvITSCVl5GTJP3X/jxNoqbBnhxF+2odc9+6Cis9sPo+VBiiR+bW+aPYRAFJqH9WBRVpNAhAyNZoEMq097mA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(39860400002)(366004)(396003)(136003)(376002)(451199018)(38070700005)(41300700001)(9686003)(316002)(8676002)(53546011)(52536014)(8936002)(6506007)(186003)(26005)(76116006)(66946007)(66476007)(66556008)(64756008)(83380400001)(4326008)(5660300002)(55016003)(478600001)(54906003)(2906002)(110136005)(66446008)(7696005)(122000001)(71200400001)(38100700002)(86362001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yHnQVt7y9oDSb7FptGXUcE82yZ3bogXVim2inmnVCPOwjQokHcPAiqa1dIXl?=
 =?us-ascii?Q?YGurjYzquxGT3RbiAIACZd912h2xa0maKLth8an4YvtxAoVSaBghfanJmk/H?=
 =?us-ascii?Q?wTVfUY8U90xuaq35eFhsWxUzI6990hbUwbdHCuGPlu2pXSxCYf0clqsC9ttc?=
 =?us-ascii?Q?vgAxfb8rFGqkJsvTWevcFGi/sZJ5PYl7asmGtX8KLr/GvhLafy8VVkE/SEFv?=
 =?us-ascii?Q?2eR0WamAAhJi0myUqhIlPrJNpiPDntJkFE2ZuV0NcUn9MwgRRe1V9LCz+/qv?=
 =?us-ascii?Q?YlJSK/ClYl7AifQ3C88WDABo+4tt3vtxa6MRb1KWSjcoXSHcjHyBjaPr+7Dz?=
 =?us-ascii?Q?Zxlqeh7tL26VmfRyxEldVkJgzd7kI1tHjTQAztEaTfH75AGsKsnmyahkIbky?=
 =?us-ascii?Q?2malx3TiFxSuqpkJ413eZA3UVJY1tuePX95IzysGxNYsvKPxP4Y2UjVL81nn?=
 =?us-ascii?Q?z1RJvl4U9nw3zwNYWcliWNMOFj2xOOumODP4Y0I+rc6mWpDMgHTAWcAQT00B?=
 =?us-ascii?Q?NXp7HcYM8SBbgJFiN7siMBiV0GoICRBLO0NaWi2Ca0O8X9o0s05TDVzTBFKR?=
 =?us-ascii?Q?Lu9WECkPuGzJcrWq+pjdewUEl2BRTgIoIvL2aXGcX893YojD4WlZfJVEi4zh?=
 =?us-ascii?Q?kKJf13fPqb3mowusJbeOvrCgZwz1flBf2mLirJeUM7vTVj/lcl5tbTCXmApb?=
 =?us-ascii?Q?JRIWucZQ6D+eqIbtsicDHbp/V6zssEqfwEF75s260GSyxAReBAORu1NH74PD?=
 =?us-ascii?Q?+vd2wlSuiApjdGzCJIHb+SPZYxmXbYng6wl8ZHau2IAnk+BR2z6/RWtq5oYF?=
 =?us-ascii?Q?f/OxRZDWYnHGbaZJ9tJyAxJfuhjF6uldN32uRr4cpAO96eesj/tQu6YjA4Ul?=
 =?us-ascii?Q?8CyOQLh41ZbEuYxTeytczGYQVv/ZMeU7mcr5XzUDHtVmBkBsfWJcVjd6FUy6?=
 =?us-ascii?Q?nLo/mBRRWH+rv9F3mxPZEvrsOID2mH/+/7zjYrY58OG73Hjy75lwmdXrqqJY?=
 =?us-ascii?Q?4kLZikmJSwRS1rdjfzxViuXR9HjiBquRnUWpDOu4QeMKzb2giG3w2EX6HVTm?=
 =?us-ascii?Q?Vn45nnbJknRpBINEgfHIpzRNJFjf8zpObq5J2IuwyskyjNBNohOpETvjrrzT?=
 =?us-ascii?Q?6alohki3iprUmb0ucmlSV4VLiGh6VDMbcK0HDgunKjxHOIXgE/mwsjNe/Jy3?=
 =?us-ascii?Q?D3XR/lxqzTqeEGYlndrTe3VvvTesJtseShVNCo/yjir9ZBYSeLm2J1aOZunu?=
 =?us-ascii?Q?Rwcd5PF9IW8wlJTK4kuJD4JaqAtXj9TDfJbqXNJWGcUlGzsfM+t022uqAAIw?=
 =?us-ascii?Q?N2CkVAaBgHkmAYreCMImHXqF2n7vRCg0db2n5zHaZbyOEn7in30U6WXPsPy/?=
 =?us-ascii?Q?8J2Tz9WZzeZQ0Wvr0aPtCdWI7hFZMWX7zVygZuGcArVQy7nC6XdKgwik3wRa?=
 =?us-ascii?Q?wlmHPQ+xUM1175fv9cwQqF7LUq2qnTTL/N78o2j5/ji/3Rvr4LCrXbRM9ZSX?=
 =?us-ascii?Q?oUHtEa5x+Sp7ZXgn8RJx5niENsN0LvUIO6PaIkOYmCqikuwrByIN2Qo0ZnT3?=
 =?us-ascii?Q?6QZrovZo7I9YzeGz4vA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d8e6ad-430c-4e77-e7c2-08db0369529f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 08:58:29.5405 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DKsgf7UTblbM4oFHtMFth7Irl6rk3KDBW4kV3MwHHzLyGyMIRPJwNCWpggsWLPvJF+6WHP+ZDFBPkVFTElfH6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6165
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Yao,
 Yiqing\(James\)" <YiQing.Yao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

V2 is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Yiqing Yao <yiqing.yao@amd.com>
Sent: Tuesday, January 31, 2023 16:33
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Yao, Yiqing(James) <YiQing.Yao@amd.com>
Subject: [PATCH v2] drm/amdgpu: Enable vclk dclk node for gc11.0.3

These sysfs nodes are tested supported, so enable them.

Signed-off-by: Yiqing Yao <yiqing.yao@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 76b9ec64ca50..bd060697d982 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2007,14 +2007,16 @@ static int default_attr_update(struct amdgpu_device=
 *adev, struct amdgpu_device_
                      gc_ver =3D=3D IP_VERSION(10, 3, 0) ||
                      gc_ver =3D=3D IP_VERSION(10, 1, 2) ||
                      gc_ver =3D=3D IP_VERSION(11, 0, 0) ||
-                     gc_ver =3D=3D IP_VERSION(11, 0, 2)))
+                     gc_ver =3D=3D IP_VERSION(11, 0, 2) ||
+                     gc_ver =3D=3D IP_VERSION(11, 0, 3)))
                        *states =3D ATTR_STATE_UNSUPPORTED;
        } else if (DEVICE_ATTR_IS(pp_dpm_dclk)) {
                if (!(gc_ver =3D=3D IP_VERSION(10, 3, 1) ||
                      gc_ver =3D=3D IP_VERSION(10, 3, 0) ||
                      gc_ver =3D=3D IP_VERSION(10, 1, 2) ||
                      gc_ver =3D=3D IP_VERSION(11, 0, 0) ||
-                     gc_ver =3D=3D IP_VERSION(11, 0, 2)))
+                     gc_ver =3D=3D IP_VERSION(11, 0, 2) ||
+                     gc_ver =3D=3D IP_VERSION(11, 0, 3)))
                        *states =3D ATTR_STATE_UNSUPPORTED;
        } else if (DEVICE_ATTR_IS(pp_power_profile_mode)) {
                if (amdgpu_dpm_get_power_profile_mode(adev, NULL) =3D=3D -E=
OPNOTSUPP)
--
2.34.1

