Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE28DC3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 10:42:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A5B110E276;
	Wed,  3 Jan 2024 10:42:44 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2055.outbound.protection.outlook.com [40.107.95.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F48D10E28B
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 10:42:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ycoa2HKfoLAg3wUFRXCTu0NZ9qpvC4AWo45vR+g8S/ETzBQIc8toPi3aRN7kF4byl2UxPemD3g1s+pNy1nTSu5bn3bhRKt9aSgxAHBPYbtsEvpPAWTzUjugxE7REDTMJhn06lyfevw9wLi4Pb0YE1YjNnOcEoCSAuVVFnI43TJGuFAm3K9XmsLFp/0+rzm3kyT/Z7I0IzRRG9Q7faWLUBM76d4gV/0xrjFt2OtXV6vcIphI3yZ9ifZzx7Z1tLhYE40/QSEWv84iK9khHaAg1tEsMzko4+mnGXUY0qmg2qPS+4Q1II/ksrKbg+psornfB/ZNiEch3xnupuwB/oHkhbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=izD/RQX4TySyUeFUt9m9gtV3Cbs0jAJSHLLXVFFCy24=;
 b=iONA7q6extVyPE98Wy2Mn5pFJn2Vutw+02ZTh0eELN9CPYbZaIt8RisIAJyIVlA8XrMJFrIWLcNWdaSbvo7PzfF2MDniuJvBtxVad14tnCGMXz6DMtVpr3TXw+UKaUyVRyXxs+IC3LKUjNntzsuudaM/XCA3mZ+Ig198DUmOddFRsk0+ubnkJGC6npbFbhX0GM+y7Z+x9viJl2n1JxfSm+7FRwPE4CpenVounQqdHInZY6AzFIe5zIRa2/V6Np2glsTLgkVkF3GtotJUXqgDqN0NNNZ8F8l15n83bE5/+PcM6OEs6vShAPpp6KoUSe+XK+mhPmgwxy5xani9bLBBFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izD/RQX4TySyUeFUt9m9gtV3Cbs0jAJSHLLXVFFCy24=;
 b=4x/ooafLFq+LG2vdjsI1uDmolUsJygMqFaygcbZWBCm0WirafQyZz9WC5X0khks1AC5JicWI4uIUq31BYJCd23qNqUPqr1LdvB6rZBRZ6kHQleIAM5wk8lkyHZVzTei/pW5LBuv5u3js7AdJh42YNXigMzQhfbNM5TUtXrKJfUA=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by PH0PR12MB7863.namprd12.prod.outlook.com (2603:10b6:510:28b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 10:42:38 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::61a8:83e4:c057:7790]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::61a8:83e4:c057:7790%4]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 10:42:38 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 02/14] drm/amdgpu: add ACA kernel hardware error log
 support
Thread-Topic: [PATCH 02/14] drm/amdgpu: add ACA kernel hardware error log
 support
Thread-Index: AQHaPhtLqfXwb1Q4NUCMjL6tVWYZ+bDH1EuAgAAD/GCAAA15kA==
Date: Wed, 3 Jan 2024 10:42:38 +0000
Message-ID: <PH7PR12MB59974A57816AFAE0C788BB588260A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240103080220.2815115-1-kevinyang.wang@amd.com>
 <20240103080220.2815115-3-kevinyang.wang@amd.com>
 <BL1PR12MB5254BCA35F540F3169D8CFECFC60A@BL1PR12MB5254.namprd12.prod.outlook.com>
 <PH7PR12MB5997A84D82FDAFF8A3B42A6F8260A@PH7PR12MB5997.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB5997A84D82FDAFF8A3B42A6F8260A@PH7PR12MB5997.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=61f822be-dba5-47ee-bf0a-7524a42547c6;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-03T08:37:14Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|PH0PR12MB7863:EE_
x-ms-office365-filtering-correlation-id: 9c9731ce-a99b-4f06-3a77-08dc0c48b476
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 57jY8eKtXEbD7K8xwnwVpwpOK/ybHxFFKzy3/WBkWsvp3V/dTS07zHs6z8M9wEkMBKaiPgKI27WfiY5JufciE4Hbjjht4YCaJxziQkS1gNkIJrh7mFkDlggKcy8VF2h2MvSlaA6kN4lqL/+W/5nEwkAD44vbQn+RgcB9yJ5XVXAVIK4A0QhKxoH/VFKXmZU90ctQeOw/Qux0rm2liB/mPuydWjpelXN09IERpEIobX2JYZ5RaNg5As2D963EcQ8jAA00l0fpAYgywgJ/3E54rqt293SxAn2eq1IrOoARsLPgalECMlD+zH7iEJyNy64OPV+267t6Nt1end2YurHM6OMuIMKD7jaSBHR2oQ8CMGCsQeMxBeOHEM57BiFdkCzl7IwSj9d3Tsda/RZxCTEOG2yAIawwcHk51X524Qm8qgaQYyIMQw7OE+oeFMCv81jBPxuh6GQbGIG+R9GePA5WxJFACksTew/uG8ryeKkRggxdh4IH0Wm4pRUNsUJhMA1/qogqUXzloOfbu/F8KIJi43PW3NutPS+tapTvb+bctZkY5W1SNatzLfn7noBzEP4f9360KvkhcrneHadiNyODRdyf9pacc0vefYdVVId9rObU913a2r4lVxI1GX2YeK0G
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(39860400002)(366004)(376002)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(2906002)(30864003)(8676002)(8936002)(4326008)(33656002)(5660300002)(52536014)(54906003)(66446008)(66556008)(316002)(64756008)(66476007)(86362001)(966005)(55016003)(478600001)(6506007)(41300700001)(9686003)(7696005)(2940100002)(38070700009)(71200400001)(26005)(83380400001)(38100700002)(66946007)(76116006)(110136005)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?SXBzMTZpd3RLWERLaHFRVWV0c1QvTEs3VFFGdWd1dXBtQVV1NDZqczJW?=
 =?iso-2022-jp?B?M3p3K3d4YWgvUU55TThXTU1YUVRhcHdHaHlYYjFxbTVrNUV3OU5mU1Bw?=
 =?iso-2022-jp?B?L1F0MkFiZmFBT2x2eVpUWXhVZnNGN21nbDUwTTNrbVJUZTRYTDNLSEFu?=
 =?iso-2022-jp?B?eUhRdmVJOExIangxTGVxdjM3aW12UGNCVkt0ZmVvdDZOVGlBVFR1SlAz?=
 =?iso-2022-jp?B?Ty94RGc4REphRmFwSGZrRXdKNWdTMWhnb293N1hwQm1JOHVXejZlL0F6?=
 =?iso-2022-jp?B?ZU5VKzFYRUMzWGxmN25xNllGREVqV3RIVU1WUm9TY1RORTNUZDNoV3Zu?=
 =?iso-2022-jp?B?TndPZmJYMlFhT2tic1UrSm5FcUtjSmc0cmsyRjNlTnZWVEE3NVZBVE5J?=
 =?iso-2022-jp?B?K2RKSXlnV1lKTEk0aFJIQ1hIWEpnU2pmS0YzRnlyeVg4WEZLRFp1SW9V?=
 =?iso-2022-jp?B?SkduanRCdERjTzY5dDZSVWtEUkpQVTZVUWF6TXNJQWtOZmpNREs1M25Y?=
 =?iso-2022-jp?B?cFRLZ0VsMkh1bXVxbHVEaVJtaklEWllhZDRyOEwxZGk3RkF1M0Uvb25M?=
 =?iso-2022-jp?B?VS80VFRzZmZtdytMQUh0c0I3TU1MSlRPRTV4enZzU2FCV04zWlQweC9h?=
 =?iso-2022-jp?B?Z2lvRnBOS0lSLzBlcFN5SjZIVlF4V1dXR01sdm9HN0ZubldhSGcyU2Uz?=
 =?iso-2022-jp?B?NmpRUzAxYmkzOG9vVGZEcVpuTW40YXdyQkdxRlpTcVRvbENaMmNQbjUr?=
 =?iso-2022-jp?B?Tzd2K0FEZ0VxMVFKclAvbzNEZ3REWEc1djBxWldlNFBPVEpvajJ4c2xD?=
 =?iso-2022-jp?B?bGhvTDhMRjNjaHc4MGFlSnhTUHNaSDQ4ek5GNlc0eXpyZGFHTzFkaVUy?=
 =?iso-2022-jp?B?VndKdU8zSFpLNWI4VXBYTHRZckxzWThneUNFSTVqRzl6RkdlSWgySlpS?=
 =?iso-2022-jp?B?Szk4Nnp0Q1JzZkVWNEFBcnlYSXRyTFFJbG5jaHltTTR4WmpDeFFlN253?=
 =?iso-2022-jp?B?OWtRNHJMYzk2ZmtXTE9lR2cvSGdHbDlmb3lNdFViTkhWMjhjS2VaNGxS?=
 =?iso-2022-jp?B?Q1pMQWRrM3NjSzdBWEtSUjZuUDdqcGRsMlh1OWtUUFRuamJBcXZ0VTNS?=
 =?iso-2022-jp?B?K0ZOSjFTdkozQnBaWlpGUnlrcGNjd29iMm1Jc21HdEJhclJmV0I4WU1V?=
 =?iso-2022-jp?B?S0Q4a203MWZmUkFVSlhkZUxVRTY2VDB2WlRrWCs3ZFpTN0xEaEtjUTI4?=
 =?iso-2022-jp?B?cDk2K1RRNlR2QzRKWGUrWlBtYUM2Ym55dU96NXFIVmdFUERCNHdqQWN0?=
 =?iso-2022-jp?B?TGhoZVZJR2FMWTEyQzFTcjV3cEQyTnZUN1J6ME5CTGZOTEozUFVUdXZF?=
 =?iso-2022-jp?B?SW5WV3JEV1VrTFNOVng0N1RpbTVVUDIzbEpVUmdIUUJabVlmZzJBaFQ4?=
 =?iso-2022-jp?B?UWFMQmxneHF6UDhsdlZGTVhIdFVJVVQ5eVptcWE0NWFQeDlFT3pybzgy?=
 =?iso-2022-jp?B?Y1llNWg4bWF3ZHlZNmRiWHlpRTlkTndYNCtDOEVSN3RMTzczUUVVVXBi?=
 =?iso-2022-jp?B?RzlKU0tuU3NuK01sSEpUcGN0cFlJNWVndlV3QkFHWWkzbnR0bEY5VVE1?=
 =?iso-2022-jp?B?ZndYbGpYMVlMVUxMYU9xeVBnTjNnSVlvOEQ3Y09Yd09COGU1ZUdIS2RI?=
 =?iso-2022-jp?B?ckZBc0t1cjRoVmRnb295VEtwQ2t1KzdzbzNxcW5SQVFJdmM2SWtqVnpP?=
 =?iso-2022-jp?B?S1dIRXJzTEVBRDRsVXMrSXBMOEk1VjhPaWJTMDVkMVUxaU9pczBDV2V4?=
 =?iso-2022-jp?B?dVNhcWhBakFLWWxYcm1kV09QWk9oOHRSVHpESWxoNEw0R3d2WXVxL0RN?=
 =?iso-2022-jp?B?WnRoUlZMWTJQUE5kb08zdVBaMlBuNWRNRzVBUnYxUjR6NUxGZmV0RjJi?=
 =?iso-2022-jp?B?UmIwUCs5YmZpanBCYmtncEtvYVY1WjhyUnJEc3ArSmlWR2RML25Db2Q2?=
 =?iso-2022-jp?B?QzI1UWVvS2dYV09MNmI5WHd3QUV6WEx5ZDZmcFFpNTRqcUg5RlRTODgx?=
 =?iso-2022-jp?B?UjZVRE1PMTNaQ241YlZmZFNnNko5TUgrOGIyUGlTL0k2ZFlPQ2RMUS92?=
 =?iso-2022-jp?B?eXZvSUFaR0RFRzdnR2Q0OGJaU1BsbWJMeVFHUThtTnVTZ2YxcGtlbk9L?=
 =?iso-2022-jp?B?ckt4cmlTTTFsQVR2aDRSS29jc1ltQ1FETGRUc3JWdzhZM2lxQkpDbE01?=
 =?iso-2022-jp?B?KzFPU3hzUVk4ejBUV1BhaDFqNmF3ZlM4OD0=?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR12MB59974A57816AFAE0C788BB588260APH7PR12MB5997namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c9731ce-a99b-4f06-3a77-08dc0c48b476
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2024 10:42:38.4153 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rxHq8x1/7HQFxMxg2HdHbR0sjW1Z/Nl4kBi646mEZKKRkPNEVPUuhMkvgnT+ebQ9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7863
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
Cc: "Chai, Thomas" <YiPeng.Chai@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_PH7PR12MB59974A57816AFAE0C788BB588260APH7PR12MB5997namp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]


Additional:
This idx/count can help us to distinguish whether those logs are from the s=
ame query results.

If this information is removed, we cannot confirm from the log whether any =
log is missing.
e.g: [4/8], then we can know that there are 4 more that are not printed due=
 to some reason.

Best Regards,
Kevin

_____________________________________________
From: Wang, Yang(Kevin)
Sent: Wednesday, January 3, 2024 5:51 PM
To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 02/14] drm/amdgpu: add ACA kernel hardware error log su=
pport

_____________________________________________
From: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>
Sent: Wednesday, January 3, 2024 5:36 PM
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com<mailto:KevinYang.Wang@amd.com=
>>; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com<mailto:Tao.Zhou1@amd.com>>; Chai, Thomas =
<YiPeng.Chai@amd.com<mailto:YiPeng.Chai@amd.com>>
Subject: RE: [PATCH 02/14] drm/amdgpu: add ACA kernel hardware error log su=
pport


[AMD Official Use Only - General]



+       dev_info(adev->dev, "[Hardware error] Accelerator Check Architectur=
e events logged\n");
+       /* plus 1 for output format, e.g: ACA[08/08]: xxxx */
+       for (i =3D 0; i < ARRAY_SIZE(aca_regs); i++)
+               dev_info(adev->dev, "[Hardware error] ACA[%02d/%02d].%s=3D0=
x%016llx\n",
+                        idx + 1, total, aca_regs[i].name, bank->regs[aca_r=
egs[i].reg_idx]);

We should keep the ACA log format simple since there are tools like crash d=
umper that grab these logs.

How about formatting log as below
dev_info(adev->dev, "[Hardware error] Accelerator Check Architecture (ACA) =
events logged\n");
dev_info(adev=1B$B"*=1B(Bdev, "[Hardware error] ACA.%s=3D0x%016llx\n");

In general, if the idx doesn't convey useful information, then just replace=
 it with ACA.Reg.

[Kevin]:

Agree, will update it in next version.

Best Regards,
Kevin

Thoughts?

Regards,
Hawking

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com<mailto:KevinYang.Wang@amd.c=
om>>
Sent: Wednesday, January 3, 2024 16:02
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; Z=
hou1, Tao <Tao.Zhou1@amd.com<mailto:Tao.Zhou1@amd.com>>; Chai, Thomas <YiPe=
ng.Chai@amd.com<mailto:YiPeng.Chai@amd.com>>; Wang, Yang(Kevin) <KevinYang.=
Wang@amd.com<mailto:KevinYang.Wang@amd.com>>
Subject: [PATCH 02/14] drm/amdgpu: add ACA kernel hardware error log suppor=
t

add ACA kernel hardware error log support.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com<mailto:kevinyang.wang@amd.=
com>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 29 +++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_aca.c
index 6a6f167b5380..cadeda64eded 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -100,6 +100,33 @@ static int aca_smu_get_valid_aca_count(struct amdgpu_d=
evice *adev, enum aca_erro
        return smu_funcs->get_valid_aca_count(adev, type, count);  }

+static struct aca_regs_dump {
+       const char *name;
+       int reg_idx;
+} aca_regs[] =3D {
+       {"CONTROL",             ACA_REG_IDX_CTL},
+       {"STATUS",              ACA_REG_IDX_STATUS},
+       {"ADDR",                ACA_REG_IDX_ADDR},
+       {"MISC",                ACA_REG_IDX_MISC0},
+       {"CONFIG",              ACA_REG_IDX_CONFG},
+       {"IPID",                ACA_REG_IDX_IPID},
+       {"SYND",                ACA_REG_IDX_SYND},
+       {"DESTAT",              ACA_REG_IDX_DESTAT},
+       {"DEADDR",              ACA_REG_IDX_DEADDR},
+       {"CONTROL_MASK",        ACA_REG_IDX_CTL_MASK},
+};
+
+static void aca_smu_bank_dump(struct amdgpu_device *adev, int idx, int
+total, struct aca_bank *bank) {
+       int i;
+
+       dev_info(adev->dev, "[Hardware error] Accelerator Check Architectur=
e events logged\n");
+       /* plus 1 for output format, e.g: ACA[08/08]: xxxx */
+       for (i =3D 0; i < ARRAY_SIZE(aca_regs); i++)
+               dev_info(adev->dev, "[Hardware error] ACA[%02d/%02d].%s=3D0=
x%016llx\n",
+                        idx + 1, total, aca_regs[i].name, bank->regs[aca_r=
egs[i].reg_idx]);
+}
+
 static int aca_smu_get_valid_aca_banks(struct amdgpu_device *adev, enum ac=
a_error_type type,
                                       int start, int count,
                                       struct aca_banks *banks)
@@ -137,6 +164,8 @@ static int aca_smu_get_valid_aca_banks(struct amdgpu_de=
vice *adev, enum aca_erro
                if (ret)
                        return ret;

+               aca_smu_bank_dump(adev, i, count, &bank);
+
                ret =3D aca_banks_add_bank(banks, &bank);
                if (ret)
                        return ret;
--
2.34.1


--_000_PH7PR12MB59974A57816AFAE0C788BB588260APH7PR12MB5997namp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Arial" size=3D"2"><span style=3D"font-size:10pt;">
<div style=3D"padding-right:5pt;padding-left:5pt;"><font color=3D"blue">[AM=
D Official Use Only - General]<br>

</font></div>
<div style=3D"margin-top:5pt;"><font face=3D"Times New Roman" size=3D"3"><s=
pan style=3D"font-size:12pt;"><br>

</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Addi=
tional:</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">This=
 idx/count can help us to distinguish whether those logs are from the same =
query results.<br>

<br>

If this information is removed, we cannot confirm from the log whether any =
log is missing<font face=3D"DengXian">.</font></span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">e.g:=
 [4/8], then we can know that there are 4 more that are not printed due to =
some reason.</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Best=
 Regards,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Kevi=
n</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">____=
_________________________________________<br>

<b>From:</b> Wang, Yang(Kevin) <br>

<b>Sent:</b> Wednesday, January 3, 2024 5:51 PM<br>

<b>To:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; amd-gfx@lists.free=
desktop.org<br>

<b>Cc:</b> Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; Chai, Thomas &lt;YiPeng.Ch=
ai@amd.com&gt;<br>

<b>Subject:</b> RE: [PATCH 02/14] drm/amdgpu: add ACA kernel hardware error=
 log support</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">____=
_________________________________________<br>

<b>From:</b> Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com"><f=
ont color=3D"#0563C1"><u>Hawking.Zhang@amd.com</u></font></a>&gt;
<br>

<b>Sent:</b> Wednesday, January 3, 2024 5:36 PM<br>

<b>To:</b> Wang, Yang(Kevin) &lt;<a href=3D"mailto:KevinYang.Wang@amd.com">=
<font color=3D"#0563C1"><u>KevinYang.Wang@amd.com</u></font></a>&gt;; <a hr=
ef=3D"mailto:amd-gfx@lists.freedesktop.org"><font color=3D"#0563C1"><u>amd-=
gfx@lists.freedesktop.org</u></font></a><br>

<b>Cc:</b> Zhou1, Tao &lt;<a href=3D"mailto:Tao.Zhou1@amd.com"><font color=
=3D"#0563C1"><u>Tao.Zhou1@amd.com</u></font></a>&gt;; Chai, Thomas &lt;<a h=
ref=3D"mailto:YiPeng.Chai@amd.com"><font color=3D"#0563C1"><u>YiPeng.Chai@a=
md.com</u></font></a>&gt;<br>

<b>Subject:</b> RE: [PATCH 02/14] drm/amdgpu: add ACA kernel hardware error=
 log support</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div style=3D"padding-right:5pt;padding-left:5pt;"><font face=3D"Arial" col=
or=3D"blue">[AMD Official Use Only - General]<br>

</font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;"><br>

</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;[Hardware er=
ror] Accelerator Check Architecture events logged\n&quot;);</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* plus 1 for output format, e.g: ACA[08/=
08]: xxxx */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; ARRAY_SIZE(aca_regs)=
; i++)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; dev_info(adev-&gt;dev, &quot;[Hardware error] ACA[%02d/%02d].%s=3D0x=
%016llx\n&quot;,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; idx + 1, total=
, aca_regs[i].name, bank-&gt;regs[aca_regs[i].reg_idx]);</span></font></div=
>
<div><font face=3D"Times New Roman" size=3D"2" color=3D"#2F5496"><span styl=
e=3D"font-size:11pt;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">We should keep the ACA log format simple since there are tool=
s like crash dumper that grab these logs.</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">How about formatting log as below</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">dev_info(adev-&gt;dev, &quot;[Hardware error] Accelerator Che=
ck Architecture (ACA) events logged\n&quot;);</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">dev_info(adev=1B$B"*=1B(Bdev, &quot;[Hardware error] ACA.%s=
=3D0x%016llx\n&quot;);</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">In general, if the idx doesn't convey useful information, the=
n just replace it with ACA.Reg.</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">[Kev=
in]:</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Agre=
e, will update it in next version.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Best=
 Regards,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Kevi=
n</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2" color=3D"#2F5496"><span styl=
e=3D"font-size:11pt;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">Thoughts?</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">Regards,</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">Hawking</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">----=
-Original Message-----</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">From=
: Wang, Yang(Kevin) &lt;<a href=3D"mailto:KevinYang.Wang@amd.com"><font col=
or=3D"#0563C1"><u>KevinYang.Wang@amd.com</u></font></a>&gt; </span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Sent=
: Wednesday, January 3, 2024 16:02</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">To: =
<a href=3D"mailto:amd-gfx@lists.freedesktop.org"><font color=3D"#0563C1"><u=
>amd-gfx@lists.freedesktop.org</u></font></a></span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Cc: =
Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com"><font color=3D"=
#0563C1"><u>Hawking.Zhang@amd.com</u></font></a>&gt;; Zhou1, Tao &lt;<a hre=
f=3D"mailto:Tao.Zhou1@amd.com"><font color=3D"#0563C1"><u>Tao.Zhou1@amd.com=
</u></font></a>&gt;;
Chai, Thomas &lt;<a href=3D"mailto:YiPeng.Chai@amd.com"><font color=3D"#056=
3C1"><u>YiPeng.Chai@amd.com</u></font></a>&gt;; Wang, Yang(Kevin) &lt;<a hr=
ef=3D"mailto:KevinYang.Wang@amd.com"><font color=3D"#0563C1"><u>KevinYang.W=
ang@amd.com</u></font></a>&gt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Subj=
ect: [PATCH 02/14] drm/amdgpu: add ACA kernel hardware error log support</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">add =
ACA kernel hardware error log support.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Sign=
ed-off-by: Yang Wang &lt;<a href=3D"mailto:kevinyang.wang@amd.com"><font co=
lor=3D"#0563C1"><u>kevinyang.wang@amd.com</u></font></a>&gt;</span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">---<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 29 +++++++++++++++++++++++++</span><=
/font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> 1 f=
ile changed, 29 insertions(+)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdg=
pu/amdgpu_aca.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 6a6f167b5380..cadeda64eded 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
100,6 +100,33 @@ static int aca_smu_get_valid_aca_count(struct amdgpu_devic=
e *adev, enum aca_erro</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu_funcs-&gt;get_valid=
_aca_count(adev, type, count);&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic struct aca_regs_dump {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *name;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int reg_idx;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+} a=
ca_regs[] =3D {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&quot;CONTROL&quot;,&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_IDX_CTL},</spa=
n></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&quot;STATUS&quot;,&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_IDX_STATU=
S},</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&quot;ADDR&quot;,&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG=
_IDX_ADDR},</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&quot;MISC&quot;,&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG=
_IDX_MISC0},</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&quot;CONFIG&quot;,&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_IDX_CONFG=
},</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&quot;IPID&quot;,&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG=
_IDX_IPID},</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&quot;SYND&quot;,&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG=
_IDX_SYND},</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&quot;DESTAT&quot;,&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_IDX_DESTA=
T},</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&quot;DEADDR&quot;,&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_IDX_DEADD=
R},</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&quot;CONTROL_MASK&quot;,&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_IDX_CTL_MASK},</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+};<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic void aca_smu_bank_dump(struct amdgpu_device *adev, int idx, int </span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+tot=
al, struct aca_bank *bank) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;[Hardware er=
ror] Accelerator Check Architecture events logged\n&quot;);</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* plus 1 for output format, e.g: ACA[08/=
08]: xxxx */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; ARRAY_SIZE(aca_regs)=
; i++)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; dev_info(adev-&gt;dev, &quot;[Hardware error] ACA[%02d/%02d].%s=3D0x=
%016llx\n&quot;,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; idx + 1, total=
, aca_regs[i].name, bank-&gt;regs[aca_regs[i].reg_idx]); </span></font></di=
v>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> sta=
tic int aca_smu_get_valid_aca_banks(struct amdgpu_device *adev, enum aca_er=
ror_type type,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; int start, int count,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; struct aca_banks *banks)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
137,6 +164,8 @@ static int aca_smu_get_valid_aca_banks(struct amdgpu_device=
 *adev, enum aca_erro</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (ret)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return re=
t;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; aca_smu_bank_dump(adev, i, count, &amp;bank);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; ret =3D aca_banks_add_bank(banks, &amp;bank);</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (ret)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return re=
t;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">2.34=
.1</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
</span></font>
</body>
</html>

--_000_PH7PR12MB59974A57816AFAE0C788BB588260APH7PR12MB5997namp_--
