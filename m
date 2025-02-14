Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 362FAC021A6
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 16:24:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2A6310ED04;
	Fri, 14 Feb 2025 16:24:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wdj1Qdce";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF49410ED05
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 16:24:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Viv50kFm72uN1K1Q3+o2Dywtf/FEdD0nEmPwL4DIuKrmdMOzZ/RY7J4DW0DUk9q6G/JqHhjLpZUqkV1bYcPK2HHmZUcU3BRv8QVjTta/iz8amBkDa7PGmRI/RfjO+4pWjAnlLpcG4IR+7vJ3NS8MeCYm3T/34zrKSHzzStB6jTpl1mRj6stPuDb/8ePcHvow7kmcSmyxCaiJkOZtqCD8pVDE+68JP6Zo2AUJ6zpEJULUxtR4rrF3y3sBiMHrJ06WTHZhexetYzK8rR/EJdtGCVyV87IcwId6yBa9RRbECKOqLIfHb9xZkS/cX5ykOTjJr0WnYKtHO+V1mRTJQfKwjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9Glnn2QIyIwftCSKRHaWibYKlgT8ZagDw8K8vUBirE=;
 b=L61CEJz+skVm/jlyNwgXyVLCBNXLjVAb6PWVUUNC9QvMKOFHodFyJsxRFHTpnDzAJ1MAkXF+TwtgY/6skP0ElwYY6aRtoB6aH/2p5rQbqcUW/vhoJm9J/9aTAMwISh2gaKzetkd2l1vtp9nWt0lUaMgfrr9wpN49CZS2pcVj3pFBb7+6+LOG9u0By075zMbffKu3vyo0kfwO6bAH+v1cva202j78NcNHJiSLGH6uRgsG12WleGmVUNpBESmFe/McVnSOJ5038/rVC8IK+eAIPqNLMCmt6KDDbnlIBI1txwAq0wq9OswMMrXBbkDlbmugHMFaiu3ahnY9qLiQVGpzrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9Glnn2QIyIwftCSKRHaWibYKlgT8ZagDw8K8vUBirE=;
 b=wdj1Qdce2+QdPGR+P+Q7I2jvLX4XMbv6WqDaLuO97LMfgfICK2MCoJioAOqaFlhJWi20B6Yep58QPwSiNQx0MTLwKUlObS/4Pd1Pql16QR1i95t/GOqIGCvjJrQT5ZhSx5El1Q0xjFiWbfNLhaOpIDW3DLqb3igd5Qu4ev5zKf4=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by BY5PR12MB4226.namprd12.prod.outlook.com (2603:10b6:a03:203::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Fri, 14 Feb
 2025 16:24:10 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%6]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 16:24:10 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: simplify xgmi peer info calls
Thread-Topic: [PATCH] drm/amdgpu: simplify xgmi peer info calls
Thread-Index: AQHbfWbbvWYvcF/9t0azUDCJxJBaHrNEx+4AgACQE4CAAPgSAIAAjD9QgAAV7wCAAAXBMA==
Date: Fri, 14 Feb 2025 16:24:09 +0000
Message-ID: <CY8PR12MB743532330A07911F2FA60DEA85FE2@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20250212155734.2213096-1-jonathan.kim@amd.com>
 <63230f85-c3de-43aa-b23a-d7cec00d23ab@amd.com>
 <CY8PR12MB743521D96B986FABB06327D285FF2@CY8PR12MB7435.namprd12.prod.outlook.com>
 <3536548b-9e4f-4223-92a3-d616c4843f90@amd.com>
 <CY8PR12MB74355B8D95866E74CE18ADE685FE2@CY8PR12MB7435.namprd12.prod.outlook.com>
 <DS0PR12MB780445C81DE6CB10E083174397FE2@DS0PR12MB7804.namprd12.prod.outlook.com>
In-Reply-To: <DS0PR12MB780445C81DE6CB10E083174397FE2@DS0PR12MB7804.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-02-14T14:57:08.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|BY5PR12MB4226:EE_
x-ms-office365-filtering-correlation-id: 091d8386-4a49-47f6-5818-08dd4d1402e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|7053199007|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?buGx1/29VLCnzkhehf+VG519g1N28gkVYtX5QxWgxMoIiD7wwZ1d5og7G6TK?=
 =?us-ascii?Q?eErEHRCkrDH8D6tazsABzjMb6yyD7Omu3PoB9HFccOB0zJqGYvd/RN1WxiNO?=
 =?us-ascii?Q?/JbFLkfdg/iuns3lJhTNoRzjUWnOyk14wPLLeqHchs4VpbWw/+bNfqQE8B19?=
 =?us-ascii?Q?NeF2msJMbRoDTlxyeLy0gYrZoA/Rf0n5URABbHnP8Y3jOXn6guoKgKNwRIX3?=
 =?us-ascii?Q?5YKk3GIQsSBQDvXadHllhyBPEPyIULQt8ttmQlXaotKpgCOb7Ctu8KAlf5IV?=
 =?us-ascii?Q?pef+WUjwHPELIP0efdPmG5WrmSpk6ZpMAK/qJJKCdxHVU20auBLhS3nL9iq9?=
 =?us-ascii?Q?Xa2Rfc3WYuJLb+E+jZu8qpHJJDUWFfwVrqkdRo+lCljJUHvLkTminEmLYLtf?=
 =?us-ascii?Q?pjsnDznAJIOxYXiAo6KnMC29RS1lKs26ra0j6fWCOu9UW88zLTejXhB25FC9?=
 =?us-ascii?Q?z1rjNtMtBmYfz2QFq4GICew5K9Ui7/gGIUpBIcqyUYwDHuCkuV4YV40aNfTB?=
 =?us-ascii?Q?/Aj2sCAJ7NK/KiASGBszvDfc+exnx6g8V8N90mFMa3D3vOY7BYhYBwH1gHRw?=
 =?us-ascii?Q?gxrxpoqQtyZ8AMeS9Esmv4V+MZ1wEbBMJcnThpWULK2MIrLVtMy75QhWx05g?=
 =?us-ascii?Q?wpCe8QWGI6fGi4wpBX/kozLI3040ZnflVMZtcwxZyiMZU3Pw4F4wllkaq4iP?=
 =?us-ascii?Q?T5I6v3KkNsYSUAMQWjxBBMD9nVrytHtucb1P05480Q+65/wmWAOyOqsGuULH?=
 =?us-ascii?Q?TnLBL/38rG1doehW58Qbj5dYyYtnDT7vYnZRmJhb+TG04hGUEMzhMFX4wvIX?=
 =?us-ascii?Q?n9OXgS2FdbdsgTFc0fMn3CspX0echQMfLUZJIhUpt6e4riq2DVJbRZC1pmqi?=
 =?us-ascii?Q?RkP2Yy6tUtscOpWpTUYlxeSr3jBLBAlOkj/Q7sWCi2iTj9uK4FV5blWUlat6?=
 =?us-ascii?Q?0GnIEN+c9aV/5OJcF/frNuf2r1GqIXwVk7VgOb4XyNtuB0pqyqWaSkzmuZDU?=
 =?us-ascii?Q?e6Q3juTbOx4SJE4oG7M/VQ2O7t/IMu9tuzesvgD4z2H5H8shw5Yp7cAXED8h?=
 =?us-ascii?Q?eOtA+Kh4MFl0bt1oeXzHTVFq+U8LfzA3LAUpduFTJgXRF6Vk4Ho48qA/R8Q2?=
 =?us-ascii?Q?p73ewtPedVeu7wefKwjoiTT2zP5CCc0Wh3tsOiwNVPn9TRh1/XN46YjRbc5T?=
 =?us-ascii?Q?68yjWxspebHacQ2W0ay40q1wjmu8SKfS+JuJYb+/xKmunLP7yQkuNtZVbNH5?=
 =?us-ascii?Q?ScU1LLAbeRY1AAQjaMynoMKW3A6aMZcJPJr4F3gtpEbtNgoJfF7uUG5f99T0?=
 =?us-ascii?Q?k6h2aw71DfEYSWiw45DqW81L71YZsJKeDuzyjlWo8WC/04+q4W7Z6Bnsiti3?=
 =?us-ascii?Q?v4ak/RtPij7WsVDQN9WQPndhOjDTnBGvGh/xnVc/6JVsKgBkHmjRDpkgG+zD?=
 =?us-ascii?Q?b8m7kXLLBrvy+/mT6Yk/j79KeWlhtygW?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?if7NIvnvYKBC7te30UNQpHHyYvAY6tQu3VbhH1Jq0CeUlRCrpvp5jCc2oagI?=
 =?us-ascii?Q?61AVV5n1z/hy56E3FjeJetjTPxRHB2IIanl9uqFGNFCW8MqJ0Dzxe1lNMxox?=
 =?us-ascii?Q?Vb/h3e8TvhO1pAP7pvlmNWaUdKPvMyvTp+36WstULHb0t+WZ/SCydFEkYkfS?=
 =?us-ascii?Q?byQqJ1oxvjLs3oaiYWcdJUHaAXVnNq7IabZ2xkAl2b8WOOftI/Qo1xS/nXX0?=
 =?us-ascii?Q?A9c3Mb6OxUkf1NwcOBVCi5U7/EGvOCeL1HWEWGvRqp0xc2kZa9JAC39Y4FYa?=
 =?us-ascii?Q?T3aY3fEZRL8zl1BHVZ9okgGt7xtH8QmjeBgAG1NUOpIU6yxuubBLtrYmXVqK?=
 =?us-ascii?Q?ok1WvlaBtyJMN8i628KSQr6F7F2WSdPfHXggRlkxe/ayAenMsg9MNO5hS9zQ?=
 =?us-ascii?Q?cpTocqEZ1nE8DOrIoJm6YFPS4pyAyeHIACSOVUysvs7N1o5EA/pHzYPSyjaA?=
 =?us-ascii?Q?RBEeo3eND6Siu1dW+v+NbFMmSNdR4/y2ckAHb39rHYT+9VLtKx4f7nLmtskq?=
 =?us-ascii?Q?qn5LO7SXR0Ao1okcRhX+vaQpzMActVT6BRr8qiA0PX9dKXr2UeDnKtTD0LxG?=
 =?us-ascii?Q?bTu2mL4BsXD9+U5sr8Hpb8XeGGiT8f4UyyXVj/16OBPA/alJJ/F7q2e999dP?=
 =?us-ascii?Q?LxQRWL9ORXlRCyWUw+GGEbPmOTvrxcGDqqjkkrjdCU13g2xdWbFx5PiIL9Mv?=
 =?us-ascii?Q?BFBugc9tTT6uvK5/1Iu3U630Ljp5iOuxvXcOQKqLRUFUc37jfHvDfa4z1B9o?=
 =?us-ascii?Q?fuLAWRGco5dkAJy7ctVxLqN9xNtYZjCfp/iJQWbaFrpN4qwLPfIekicwhpi4?=
 =?us-ascii?Q?BPuzSi4uIH9fKFiYsmpMrZvgU78/0eFK7z/ZePytmbIGsCdIoPNKXBx0bqEc?=
 =?us-ascii?Q?lZbrQqpRmf9VY/rCIb3vhQGtGO7ATPrk6XR7rHn1wBLUyw7mvR9KptdsSAfh?=
 =?us-ascii?Q?4YNmRHN0/UXfPvKgwojVndNRNrk0Frm6WG0NhxNrs4tYR/U+wUMC/Z3qIFvO?=
 =?us-ascii?Q?65YfZC99gGbBCkMB/Jw+N/EuaH1oX7w1IFdYgyZnpI7HojlRSSRclm8WGdDd?=
 =?us-ascii?Q?WVMql1lX+uHEcdDFOdbxyenfK71ZNkxrrEBGTyqwvJjQO80YI6qOQHuMSweF?=
 =?us-ascii?Q?W/0j7BXKjb9ONT48xCxe1KK02A4P+OoQoHDLzmQI+UrfKmRm12CS+Q3x4kGJ?=
 =?us-ascii?Q?dF+BnToPPurR4ybO5Yy5daeJTZTwNUpjefkfQt07nbRYX3VPobVqoLs010Nm?=
 =?us-ascii?Q?7bNCYwwOODkRVlFxbgMlsxe1mMYDwKLrzPPOK2NhJDpOO6+HUxgWrvC6aWOp?=
 =?us-ascii?Q?ER2Z2WOz8gVS7nCrHB78IYEgWWG7jCi/mK3F4j+hV/+HrJnECkXHSC+l3MBL?=
 =?us-ascii?Q?mawAFWRtrIaDOx1q8a0QKF2SuT6BghN7ZuuxGfllMX4sD/hT6Gfn+p25Cuh7?=
 =?us-ascii?Q?9Q8fTnMCJXVjgVd8FYL96bDjKR8FOZAY27xBAB/F2+/Rem7oHL27/467etWk?=
 =?us-ascii?Q?7dXnO8ERKJbm2Mef5pPHOlGvE9hf9aeXTkxEjqEGeJYJvnhesaDgVSzmFcGP?=
 =?us-ascii?Q?Zefqpfs0RaDpi3bwoM0=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CY8PR12MB743532330A07911F2FA60DEA85FE2CY8PR12MB7435namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 091d8386-4a49-47f6-5818-08dd4d1402e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 16:24:09.9739 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pOZE115GJBzv39Jr0ECoFNBKlwSQTlcjlhvup1o8AJMrnuFfmo9voL+RN/phkakP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4226
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

--_000_CY8PR12MB743532330A07911F2FA60DEA85FE2CY8PR12MB7435namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

We could be talking about 2 types of bandwidth here.

  1.  Bandwidth per link
  2.  Bandwidth per peer i.e. multiple xgmi links that are used for SDMA ga=
ng submissions for effective max bandwidth * num_link copy speed.  The is c=
urrently used by runtime i.e. max divide by min.  The number of links per p=
eer can be variable.

The peerless request is requesting for #1 because there should be no speed =
variability of links based on peer i.e. requesting max bandwidth per link f=
or 1 link.

The interface could look like amdgpu_xgmi_get_bandwidth(adev, peer, enum un=
it_type, int *min, int *max) then.
Unit_type could be defined for illustration:
#define AMDGPU_XGMI_BW_MBYTES_MIN_MAX_PER_LINK 0
#define AMDGPU_XGMI_BW_MBYTES_MIN_MAX_PER_PEER 1

Where if unit_type =3D=3D AMDGPU_XGMI_BW_*_MIN_MAX_PER_LINK, call would ign=
ore peer and populate *min/max with per link min/max (keeps it open for pow=
erplay range per link)
While unit_type  =3D=3D AMDGPU_XGMI_BW_*_MIN_MAX_PER_PEER, call would popul=
ate *min/max with per peer, where min/max is max_bw * num_link range.

Jon

From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, February 14, 2025 10:39 AM
To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu: simplify xgmi peer info calls


[Public]

For minimum bandwidth, we should keep the possibility of going to FW to get=
 the data when XGMI DPM is in place. So it is all wrapped inside the API wh=
en the devices passed are connected. The caller doesn't need to know.

BTW, what is the real requirement of bandwidth data without any peer device=
? In what way that is useful?

Thanks,
Lijo
________________________________
From: Kim, Jonathan <Jonathan.Kim@amd.com<mailto:Jonathan.Kim@amd.com>>
Sent: Friday, February 14, 2025 8:27:28 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>; amd-gfx@li=
sts.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.fr=
eedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Subject: RE: [PATCH] drm/amdgpu: simplify xgmi peer info calls

[Public]

> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
> Sent: Friday, February 14, 2025 12:58 AM
> To: Kim, Jonathan <Jonathan.Kim@amd.com<mailto:Jonathan.Kim@amd.com>>; am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
> Subject: Re: [PATCH] drm/amdgpu: simplify xgmi peer info calls
>
>
>
> On 2/13/2025 9:20 PM, Kim, Jonathan wrote:
> > [Public]
> >
> >> -----Original Message-----
> >> From: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
> >> Sent: Thursday, February 13, 2025 1:35 AM
> >> To: Kim, Jonathan <Jonathan.Kim@amd.com<mailto:Jonathan.Kim@amd.com>>;=
 amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
> >> Subject: Re: [PATCH] drm/amdgpu: simplify xgmi peer info calls
> >>
> >>
> >>
> >> On 2/12/2025 9:27 PM, Jonathan Kim wrote:
> >>> Deprecate KFD XGMI peer info calls in favour of calling directly from
> >>> simplified XGMI peer info functions.
> >>>
> >>> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com<mailto:jonathan.kim=
@amd.com>>
> >>> ---
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 42 ------------------
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  5 ---
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   | 51 +++++++++++++++++---=
--
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h   |  6 +--
> >>>  drivers/gpu/drm/amd/amdkfd/kfd_crat.c      | 11 +++--
> >>>  5 files changed, 48 insertions(+), 67 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> >>> index 0312231b703e..4cec3a873995 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> >>> @@ -555,48 +555,6 @@ int amdgpu_amdkfd_get_dmabuf_info(struct
> >> amdgpu_device *adev, int dma_buf_fd,
> >>>     return r;
> >>>  }
> >>>
> >>> -uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct amdgpu_device *dst,
> >>> -                                     struct amdgpu_device *src)
> >>> -{
> >>> -   struct amdgpu_device *peer_adev =3D src;
> >>> -   struct amdgpu_device *adev =3D dst;
> >>> -   int ret =3D amdgpu_xgmi_get_hops_count(adev, peer_adev);
> >>> -
> >>> -   if (ret < 0) {
> >>> -           DRM_ERROR("amdgpu: failed to get  xgmi hops count between
> >> node %d and %d. ret =3D %d\n",
> >>> -                   adev->gmc.xgmi.physical_node_id,
> >>> -                   peer_adev->gmc.xgmi.physical_node_id, ret);
> >>> -           ret =3D 0;
> >>> -   }
> >>> -   return  (uint8_t)ret;
> >>> -}
> >>> -
> >>> -int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct amdgpu_device *ds=
t,
> >>> -                                       struct amdgpu_device *src,
> >>> -                                       bool is_min)
> >>> -{
> >>> -   struct amdgpu_device *adev =3D dst, *peer_adev;
> >>> -   int num_links;
> >>> -
> >>> -   if (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(9, 4, 2))
> >>> -           return 0;
> >>> -
> >>> -   if (src)
> >>> -           peer_adev =3D src;
> >>> -
> >>> -   /* num links returns 0 for indirect peers since indirect route is=
 unknown. */
> >>> -   num_links =3D is_min ? 1 : amdgpu_xgmi_get_num_links(adev, peer_a=
dev);
> >>> -   if (num_links < 0) {
> >>> -           DRM_ERROR("amdgpu: failed to get xgmi num links between
> >> node %d and %d. ret =3D %d\n",
> >>> -                   adev->gmc.xgmi.physical_node_id,
> >>> -                   peer_adev->gmc.xgmi.physical_node_id, num_links);
> >>> -           num_links =3D 0;
> >>> -   }
> >>> -
> >>> -   /* Aldebaran xGMI DPM is defeatured so assume x16 x 25Gbps for
> >> bandwidth. */
> >>> -   return (num_links * 16 * 25000)/BITS_PER_BYTE;
> >>> -}
> >>> -
> >>>  int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct amdgpu_device *ad=
ev,
> >> bool is_min)
> >>>  {
> >>>     int num_lanes_shift =3D (is_min ? ffs(adev->pm.pcie_mlw_mask) :
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> >>> index 092dbd8bec97..28eb1cd0eb5a 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> >>> @@ -255,11 +255,6 @@ int amdgpu_amdkfd_get_dmabuf_info(struct
> >> amdgpu_device *adev, int dma_buf_fd,
> >>>                               uint64_t *bo_size, void *metadata_buffe=
r,
> >>>                               size_t buffer_size, uint32_t *metadata_=
size,
> >>>                               uint32_t *flags, int8_t *xcp_id);
> >>> -uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct amdgpu_device *dst,
> >>> -                                     struct amdgpu_device *src);
> >>> -int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct amdgpu_device *ds=
t,
> >>> -                                       struct amdgpu_device *src,
> >>> -                                       bool is_min);
> >>>  int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct amdgpu_device *ad=
ev,
> >> bool is_min);
> >>>  int amdgpu_amdkfd_send_close_event_drain_irq(struct amdgpu_device *a=
dev,
> >>>                                     uint32_t *payload);
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> >>> index 74b4349e345a..d18d2a26cc91 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> >>> @@ -818,28 +818,59 @@ int amdgpu_xgmi_update_topology(struct
> >> amdgpu_hive_info *hive, struct amdgpu_dev
> >>>   * num_hops[2:0] =3D number of hops
> >>>   */
> >>>  int amdgpu_xgmi_get_hops_count(struct amdgpu_device *adev,
> >>> -           struct amdgpu_device *peer_adev)
> >>> +                          struct amdgpu_device *peer_adev)
> >>>  {
> >>>     struct psp_xgmi_topology_info *top =3D &adev->psp.xgmi_context.to=
p_info;
> >>>     uint8_t num_hops_mask =3D 0x7;
> >>>     int i;
> >>>
> >>> +   if (!adev->gmc.xgmi.supported)
> >>> +           return 0;
> >>> +
> >>>     for (i =3D 0 ; i < top->num_nodes; ++i)
> >>>             if (top->nodes[i].node_id =3D=3D peer_adev->gmc.xgmi.node=
_id)
> >>>                     return top->nodes[i].num_hops & num_hops_mask;
> >>> -   return  -EINVAL;
> >>> +
> >>> +   DRM_ERROR("amdgpu: failed to get  xgmi hops count between node %d
> >> and %d.\n",
> >>
> >> Suggest to use dev_ function to identify the device pci number. Since
> >> the function still passes, maybe info level is good enough.
> >
> > Ack'd.  Will change.
> >
> >>
> >>> +             adev->gmc.xgmi.physical_node_id,
> >>> +             peer_adev->gmc.xgmi.physical_node_id);
> >>> +
> >>> +   return 0;
> >>>  }
> >>>
> >>> -int amdgpu_xgmi_get_num_links(struct amdgpu_device *adev,
> >>> -           struct amdgpu_device *peer_adev)
> >>> +int amdgpu_xgmi_get_bandwidth_mbytes(struct amdgpu_device *adev,
> >>> +                                struct amdgpu_device *peer_adev)
> >>>  {
> >>> -   struct psp_xgmi_topology_info *top =3D &adev->psp.xgmi_context.to=
p_info;
> >>> -   int i;
> >>> +   int num_links =3D !peer_adev ? 1 : 0;
> >>>
> >>> -   for (i =3D 0 ; i < top->num_nodes; ++i)
> >>> -           if (top->nodes[i].node_id =3D=3D peer_adev->gmc.xgmi.node=
_id)
> >>> -                   return top->nodes[i].num_links;
> >>> -   return  -EINVAL;
> >>> +   if (!adev->gmc.xgmi.supported)
> >>> +           return 0;
> >>> +
> >>> +   if (peer_adev) {
> >>> +           struct psp_xgmi_topology_info *top =3D &adev-
> >>> psp.xgmi_context.top_info;
> >>> +           int i;
> >>> +
> >>> +           for (i =3D 0 ; i < top->num_nodes; ++i) {
> >>> +                   if (top->nodes[i].node_id !=3D peer_adev->gmc.xgm=
i.node_id)
> >>> +                           continue;
> >>> +
> >>> +                   num_links =3D  top->nodes[i].num_links;
> >>> +                   break;
> >>> +           }
> >>> +   }
> >>> +
> >>> +   /* num links returns 0 for indirect peers since indirect route is=
 unknown. */
> >>> +   if (!num_links) {
> >>
> >> This looks problematic. I guess, it is better to keep the old way of
> >> passing min/max. Otherwise, there is a chance that min reports some
> >> value and max could report this error.
> >
> > I don't think this is a problem.  The old way of passing is_min =3D=3D =
 true is tied to
> peer_dev =3D=3D NULL, which made it a redundant argument.
> > is_min =3D=3D  false doesn't prevent the issue you've mentioned from ha=
ppening
> because the old code effective sets num_link =3D 0 if the peer_dev search=
 fails
> anyways.
>
> The problem I was thinking about was with respect to usage in KFD
> properties. With this way, min_bandwidth will report some value even if
> no link is present between the devices. Max bandwidth will report 0.
> Ideally, we should report both min/max =3D 0 when there is no link presen=
t
> between the devices. I haven't checked if KFD does some other check to
> ensure that there are links between devices before calling the API.

The KFD only queries for links within a hive.
Checking for max first implies link on non-zero return.
We could change the KFD to set zero on if max is zero then.

>
>
> > With the line at the top of the proposed function:
> >>> +   int num_links =3D !peer_adev ? 1 : 0;
> > The sematics are as follows:
> > - NULL peer_dev indicates that caller doesn't want peer-to-peer data to=
 factor
> num_links into bandwidth reporting so assume a single XGMI link in bandwi=
dth
> calculation.
>
> I think this semantics doesn't provide enough clarity. XGMI is
> interconnect between devices and ideally we expect two devices to be
> passed to the API. If any one is NULL, then it's better to reject.
>
> > - If a failed peer_dev search ends up with num_links =3D=3D 0, that mea=
ns the caller
> passed in an invalid node (i.e. it's not one of the nodes that's been reg=
istered to the
> hive).
> > Currently, get_hops_count (old and proposed) operates in the same fashi=
on too.
> > So the functionality between the proposed changes and old changes shoul=
d have
> remained the same.
> >
>
> The API is usage is clear and general expectation is two devices are not
> NULL. That is clear in the case of get_hops_count.

I don't see where that expectation is set in the proposal.
peer_dev =3D=3D NULL is asking for a peerless check of potential bandwidth.
If you're saying we need a redundant is_min bool to ignore peer_dev num_lin=
ks checks, I'd say then both are a waste of time for clarity's sake.

In that case, if we want to be strict with both peers being non-NULL, chang=
e the following:
- expose amdgpu_xgmi_get_num_links to KFD to mirror get_num_hops
- KFD calls amdgpu_xgmi_get_num_links to do some handling and later pass re=
turn into a new bandwidth call if return is non-zero
- change amdgpu_xgmi_get_bandwidth_mbytes(peer1, peer2) to amdgpu_xgmi_get_=
bandwidth(adev, const int num_links, enum unit_type)
        - adev -> used for future IP checks as a dynamic internal speed con=
stant setter
        - const int num_links -> caller passes in constant link multiplier.=
  So in this case KFD can pass back the num_links it finds from previous am=
dgpu_xgmi_get_num_links
        - enum unit_type -> some enum we can define in amdgpu_xgmi.h to giv=
e the back the caller whatever units it's looking for (GTs, Mbytes/sec, Mbp=
s etc ...)

Then this way:
- KFD enforces min/max bandwidth to be consistent i.e. both are 0 or both a=
re non-zero
- bandwidth call is now more general purpose and flexible and provides vari=
ous bandwidth return types by caller needs.

Jon

>
> > I'm open to adjusting get_num_hops & get_bandwidth_mbytes to return eit=
her -
> ENODEV (device not found in hive) or -EINVAL (bad peer_dev request) on a =
failed
> search.
>
> On a failed search, does returning 0 work - zero hop/bandwidth
> considered as no link found between the provided devices?
>
> Thanks,
> Lijo
>
> > That would require a change to KFD CRAT logic to error return itself on=
 an error.
> > However, this would change the behaviour of a bandwidth reporting error=
 where
> ROCm could still function, to the KFD not loading at all.
> > Currently, the consequence of passing an incorrect peer_dev to the band=
width call
> would result in the ROCm Runtime not issuing an SDMA ganged copy i.e. pot=
ential
> peer-to-peer performance drop.
> >
> > Jon
> >
> >>
> >> Thanks,
> >> Lijo
> >>
> >>> +           DRM_ERROR("amdgpu: failed to get xgmi num links between
> >> node %d and %d.\n",
> >>> +                     adev->gmc.xgmi.physical_node_id,
> >>> +                     peer_adev->gmc.xgmi.physical_node_id);
> >>> +   }
> >>> +
> >>> +   /*
> >>> +    * TBD - will update IP based bandwidth later.
> >>> +    * Bandwidth currently assumed to be x16 lanes x 25Gbps.
> >>> +    */
> >>> +   return (num_links * 16 * 25000)/BITS_PER_BYTE;
> >>>  }
> >>>
> >>>  bool amdgpu_xgmi_get_is_sharing_enabled(struct amdgpu_device *adev,
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> >>> index d1282b4c6348..325e7972469d 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> >>> @@ -62,10 +62,8 @@ int amdgpu_xgmi_update_topology(struct
> >> amdgpu_hive_info *hive, struct amdgpu_dev
> >>>  int amdgpu_xgmi_add_device(struct amdgpu_device *adev);
> >>>  int amdgpu_xgmi_remove_device(struct amdgpu_device *adev);
> >>>  int amdgpu_xgmi_set_pstate(struct amdgpu_device *adev, int pstate);
> >>> -int amdgpu_xgmi_get_hops_count(struct amdgpu_device *adev,
> >>> -           struct amdgpu_device *peer_adev);
> >>> -int amdgpu_xgmi_get_num_links(struct amdgpu_device *adev,
> >>> -           struct amdgpu_device *peer_adev);
> >>> +int amdgpu_xgmi_get_hops_count(struct amdgpu_device *adev, struct
> >> amdgpu_device *peer_adev);
> >>> +int amdgpu_xgmi_get_bandwidth_mbytes(struct amdgpu_device *adev, str=
uct
> >> amdgpu_device *peer_adev);
> >>>  bool amdgpu_xgmi_get_is_sharing_enabled(struct amdgpu_device *adev,
> >>>                                     struct amdgpu_device *peer_adev);
> >>>  uint64_t amdgpu_xgmi_get_relative_phy_addr(struct amdgpu_device *ade=
v,
> >>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> >> b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> >>> index 70b3ae0b74fe..a787d192390c 100644
> >>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> >>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> >>> @@ -2133,8 +2133,8 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(i=
nt
> >> *avail_size,
> >>>             bool ext_cpu =3D KFD_GC_VERSION(kdev) !=3D IP_VERSION(9, =
4, 3);
> >>>             int mem_bw =3D 819200, weight =3D ext_cpu ?
> >> KFD_CRAT_XGMI_WEIGHT :
> >>>
> >>       KFD_CRAT_INTRA_SOCKET_WEIGHT;
> >>> -           uint32_t bandwidth =3D ext_cpu ?
> >> amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(
> >>> -                                                   kdev->adev, NULL,=
 true) :
> >> mem_bw;
> >>> +           uint32_t bandwidth =3D ext_cpu ?
> >> amdgpu_xgmi_get_bandwidth_mbytes(kdev->adev, NULL) :
> >>> +                                          mem_bw;
> >>>
> >>>             /*
> >>>              * with host gpu xgmi link, host can access gpu memory wh=
ether
> >>> @@ -2198,12 +2198,11 @@ static int kfd_fill_gpu_xgmi_link_to_gpu(int
> >> *avail_size,
> >>>
> >>>     if (use_ta_info) {
> >>>             sub_type_hdr->weight_xgmi =3D KFD_CRAT_XGMI_WEIGHT *
> >>> -                   amdgpu_amdkfd_get_xgmi_hops_count(kdev->adev,
> >> peer_kdev->adev);
> >>> +                   amdgpu_xgmi_get_hops_count(kdev->adev, peer_kdev-
> >>> adev);
> >>>             sub_type_hdr->maximum_bandwidth_mbs =3D
> >>> -                   amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(kdev->ade=
v,
> >>> -                                                   peer_kdev->adev, =
false);
> >>> +                   amdgpu_xgmi_get_bandwidth_mbytes(kdev->adev,
> >> peer_kdev->adev);
> >>>             sub_type_hdr->minimum_bandwidth_mbs =3D sub_type_hdr-
> >>> maximum_bandwidth_mbs ?
> >>> -                   amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(kdev->ade=
v,
> >> NULL, true) : 0;
> >>> +                   amdgpu_xgmi_get_bandwidth_mbytes(kdev->adev, NULL=
) :
> >> 0;
> >>>     } else {
> >>>             bool is_single_hop =3D kdev->kfd =3D=3D peer_kdev->kfd;
> >>>             int weight =3D is_single_hop ?
> >> KFD_CRAT_INTRA_SOCKET_WEIGHT :
> >

--_000_CY8PR12MB743532330A07911F2FA60DEA85FE2CY8PR12MB7435namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"Malgun Gothic";
	panose-1:2 11 5 3 2 0 0 2 0 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"\@Malgun Gothic";}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Arial",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:479419671;
	mso-list-type:hybrid;
	mso-list-template-ids:427562342 -207470956 67698713 67698715 67698703 6769=
8713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-start-at:2;
	mso-level-text:%1;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1
	{mso-list-id:1029405602;
	mso-list-type:hybrid;
	mso-list-template-ids:1139709536 67698705 67698713 67698715 67698703 67698=
713 67698715 67698703 67698713 67698715;}
@list l1:level1
	{mso-level-text:"%1\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l2
	{mso-list-id:1173764432;
	mso-list-type:hybrid;
	mso-list-template-ids:1575398882 67698705 67698713 67698715 67698703 67698=
713 67698715 67698703 67698713 67698715;}
@list l2:level1
	{mso-level-text:"%1\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l2:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l2:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l3
	{mso-list-id:1483810930;
	mso-list-type:hybrid;
	mso-list-template-ids:-318627572 67698705 67698713 67698715 67698703 67698=
713 67698715 67698703 67698713 67698715;}
@list l3:level1
	{mso-level-text:"%1\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l3:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l3:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l3:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l3:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l3:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l3:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l3:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l3:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">We could be talking about 2 types of bandwidth here.<=
o:p></o:p></span></p>
<ol style=3D"margin-top:0in" start=3D"1" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l2 level1 =
lfo4"><span style=3D"font-size:11.0pt;font-family:&quot;Arial&quot;,sans-se=
rif">Bandwidth per link<o:p></o:p></span></li><li class=3D"MsoListParagraph=
" style=3D"margin-left:0in;mso-list:l2 level1 lfo4"><span style=3D"font-siz=
e:11.0pt;font-family:&quot;Arial&quot;,sans-serif">Bandwidth per peer i.e. =
multiple xgmi links that are used for SDMA gang submissions for effective m=
ax bandwidth * num_link
 copy speed.&nbsp; The is currently used by runtime i.e. max divide by min.=
&nbsp; The number of links per peer can be variable.<o:p></o:p></span></li>=
</ol>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">The peerless request is requesting for #1 because the=
re should be no speed variability of links based on peer i.e. requesting ma=
x bandwidth per link for 1 link.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">The interface could look like amdgpu_xgmi_get_bandwid=
th(adev, peer, enum unit_type, int *min, int *max) then.<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">Unit_type could be defined for illustration:<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">#define AMDGPU_XGMI_BW_MBYTES_MIN_MAX_PER_LINK 0<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">#define AMDGPU_XGMI_BW_MBYTES_MIN_MAX_PER_PEER 1<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">Where if unit_type =3D=3D AMDGPU_XGMI_BW_*_MIN_MAX_PE=
R_LINK, call would ignore peer and populate *min/max with per link min/max =
(keeps it open for powerplay range per link)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">While unit_type &nbsp;=3D=3D AMDGPU_XGMI_BW_*_MIN_MAX=
_PER_PEER, call would populate *min/max with per peer, where min/max is max=
_bw * num_link range.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">Jon<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> Lazar, Lijo &lt;Lijo.Lazar@amd=
.com&gt;
<br>
<b>Sent:</b> Friday, February 14, 2025 10:39 AM<br>
<b>To:</b> Kim, Jonathan &lt;Jonathan.Kim@amd.com&gt;; amd-gfx@lists.freede=
sktop.org<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: simplify xgmi peer info calls<o:p><=
/o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:green">[Public]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal">For minimum bandwidth, we should keep the possibilit=
y of going&nbsp;to FW to get the data when XGMI DPM is in place. So it is a=
ll wrapped inside the API when the devices passed are connected. The caller=
 doesn't need to know.<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">BTW, what is the real requirement of bandwidth data =
without any peer device? In what way that is useful?<o:p></o:p></p>
</div>
<div id=3D"ms-outlook-mobile-signature">
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Lijo<o:p></o:p></p>
</div>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> Kim, J=
onathan &lt;<a href=3D"mailto:Jonathan.Kim@amd.com">Jonathan.Kim@amd.com</a=
>&gt;<br>
<b>Sent:</b> Friday, February 14, 2025 8:27:28 PM<br>
<b>To:</b> Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.com">Lijo.Lazar=
@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: simplify xgmi peer info calls</span=
> <o:p>
</o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><a name=3D"BM_BEGIN">=
</a><span style=3D"font-size:11.0pt;font-family:&quot;Times New Roman&quot;=
,serif">[Public]<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.com">Lijo.Lazar=
@amd.com</a>&gt;<br>
&gt; Sent: Friday, February 14, 2025 12:58 AM<br>
&gt; To: Kim, Jonathan &lt;<a href=3D"mailto:Jonathan.Kim@amd.com">Jonathan=
.Kim@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
&gt; Subject: Re: [PATCH] drm/amdgpu: simplify xgmi peer info calls<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On 2/13/2025 9:20 PM, Kim, Jonathan wrote:<br>
&gt; &gt; [Public]<br>
&gt; &gt;<br>
&gt; &gt;&gt; -----Original Message-----<br>
&gt; &gt;&gt; From: Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.com">L=
ijo.Lazar@amd.com</a>&gt;<br>
&gt; &gt;&gt; Sent: Thursday, February 13, 2025 1:35 AM<br>
&gt; &gt;&gt; To: Kim, Jonathan &lt;<a href=3D"mailto:Jonathan.Kim@amd.com"=
>Jonathan.Kim@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
&gt; &gt;&gt; Subject: Re: [PATCH] drm/amdgpu: simplify xgmi peer info call=
s<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; On 2/12/2025 9:27 PM, Jonathan Kim wrote:<br>
&gt; &gt;&gt;&gt; Deprecate KFD XGMI peer info calls in favour of calling d=
irectly from<br>
&gt; &gt;&gt;&gt; simplified XGMI peer info functions.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Signed-off-by: Jonathan Kim &lt;<a href=3D"mailto:jonatha=
n.kim@amd.com">jonathan.kim@amd.com</a>&gt;<br>
&gt; &gt;&gt;&gt; ---<br>
&gt; &gt;&gt;&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 42 ---=
---------------<br>
&gt; &gt;&gt;&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |&nbsp; =
5 ---<br>
&gt; &gt;&gt;&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c&nbsp;&nbsp=
; | 51 +++++++++++++++++-----<br>
&gt; &gt;&gt;&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h&nbsp;&nbsp=
; |&nbsp; 6 +--<br>
&gt; &gt;&gt;&gt;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_crat.c&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; | 11 +++--<br>
&gt; &gt;&gt;&gt;&nbsp; 5 files changed, 48 insertions(+), 67 deletions(-)<=
br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<b=
r>
&gt; &gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br>
&gt; &gt;&gt;&gt; index 0312231b703e..4cec3a873995 100644<br>
&gt; &gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br>
&gt; &gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br>
&gt; &gt;&gt;&gt; @@ -555,48 +555,6 @@ int amdgpu_amdkfd_get_dmabuf_info(st=
ruct<br>
&gt; &gt;&gt; amdgpu_device *adev, int dma_buf_fd,<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; &gt;&gt;&gt;&nbsp; }<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; -uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct amdgpu_=
device *dst,<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct amdgpu_device *src)<br>
&gt; &gt;&gt;&gt; -{<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp; struct amdgpu_device *peer_adev =3D src;<br=
>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp; struct amdgpu_device *adev =3D dst;<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp; int ret =3D amdgpu_xgmi_get_hops_count(adev=
, peer_adev);<br>
&gt; &gt;&gt;&gt; -<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp; if (ret &lt; 0) {<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; DRM_ERROR(&quot;amdgpu: failed to get&nbsp; xgmi hops count between<br=
>
&gt; &gt;&gt; node %d and %d. ret =3D %d\n&quot;,<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.xgmi.phys=
ical_node_id,<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; peer_adev-&gt;gmc.xgmi=
.physical_node_id, ret);<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; ret =3D 0;<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp; }<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp; return&nbsp; (uint8_t)ret;<br>
&gt; &gt;&gt;&gt; -}<br>
&gt; &gt;&gt;&gt; -<br>
&gt; &gt;&gt;&gt; -int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct amdgp=
u_device *dst,<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *src,<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; bool is_min)<br>
&gt; &gt;&gt;&gt; -{<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp; struct amdgpu_device *adev =3D dst, *peer_a=
dev;<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp; int num_links;<br>
&gt; &gt;&gt;&gt; -<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, 0) &lt=
; IP_VERSION(9, 4, 2))<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; return 0;<br>
&gt; &gt;&gt;&gt; -<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp; if (src)<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; peer_adev =3D src;<br>
&gt; &gt;&gt;&gt; -<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp; /* num links returns 0 for indirect peers s=
ince indirect route is unknown. */<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp; num_links =3D is_min ? 1 : amdgpu_xgmi_get_=
num_links(adev, peer_adev);<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp; if (num_links &lt; 0) {<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; DRM_ERROR(&quot;amdgpu: failed to get xgmi num links between<br>
&gt; &gt;&gt; node %d and %d. ret =3D %d\n&quot;,<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.xgmi.phys=
ical_node_id,<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; peer_adev-&gt;gmc.xgmi=
.physical_node_id, num_links);<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; num_links =3D 0;<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp; }<br>
&gt; &gt;&gt;&gt; -<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp; /* Aldebaran xGMI DPM is defeatured so assu=
me x16 x 25Gbps for<br>
&gt; &gt;&gt; bandwidth. */<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp; return (num_links * 16 * 25000)/BITS_PER_BY=
TE;<br>
&gt; &gt;&gt;&gt; -}<br>
&gt; &gt;&gt;&gt; -<br>
&gt; &gt;&gt;&gt;&nbsp; int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct =
amdgpu_device *adev,<br>
&gt; &gt;&gt; bool is_min)<br>
&gt; &gt;&gt;&gt;&nbsp; {<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; int num_lanes_shift =3D (is_min ?=
 ffs(adev-&gt;pm.pcie_mlw_mask) :<br>
&gt; &gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h<b=
r>
&gt; &gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h<br>
&gt; &gt;&gt;&gt; index 092dbd8bec97..28eb1cd0eb5a 100644<br>
&gt; &gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h<br>
&gt; &gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h<br>
&gt; &gt;&gt;&gt; @@ -255,11 +255,6 @@ int amdgpu_amdkfd_get_dmabuf_info(st=
ruct<br>
&gt; &gt;&gt; amdgpu_device *adev, int dma_buf_fd,<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t *bo_size, void *me=
tadata_buffer,<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t buffer_size, uint32_=
t *metadata_size,<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *flags, int8_t *xc=
p_id);<br>
&gt; &gt;&gt;&gt; -uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct amdgpu_=
device *dst,<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct amdgpu_device *src);<br>
&gt; &gt;&gt;&gt; -int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct amdgp=
u_device *dst,<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *src,<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; bool is_min);<br>
&gt; &gt;&gt;&gt;&nbsp; int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct =
amdgpu_device *adev,<br>
&gt; &gt;&gt; bool is_min);<br>
&gt; &gt;&gt;&gt;&nbsp; int amdgpu_amdkfd_send_close_event_drain_irq(struct=
 amdgpu_device *adev,<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; uint32_t *payload);<br>
&gt; &gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c<br>
&gt; &gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c<br>
&gt; &gt;&gt;&gt; index 74b4349e345a..d18d2a26cc91 100644<br>
&gt; &gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c<br>
&gt; &gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c<br>
&gt; &gt;&gt;&gt; @@ -818,28 +818,59 @@ int amdgpu_xgmi_update_topology(str=
uct<br>
&gt; &gt;&gt; amdgpu_hive_info *hive, struct amdgpu_dev<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp; * num_hops[2:0] =3D number of hops<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp; */<br>
&gt; &gt;&gt;&gt;&nbsp; int amdgpu_xgmi_get_hops_count(struct amdgpu_device=
 *adev,<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; struct amdgpu_device *peer_adev)<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct amdgpu_device *peer_adev)<br>
&gt; &gt;&gt;&gt;&nbsp; {<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_xgmi_topology_info *to=
p =3D &amp;adev-&gt;psp.xgmi_context.top_info;<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t num_hops_mask =3D 0x7;<br=
>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; if (!adev-&gt;gmc.xgmi.supported)<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; return 0;<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0 ; i &lt; top-&gt;num=
_nodes; ++i)<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (top-&gt;nodes[i].node_id =3D=3D peer_adev-&gt;gmc.xgmi.n=
ode_id)<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return top-&=
gt;nodes[i].num_hops &amp; num_hops_mask;<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp; return&nbsp; -EINVAL;<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; DRM_ERROR(&quot;amdgpu: failed to get&nbsp;=
 xgmi hops count between node %d<br>
&gt; &gt;&gt; and %d.\n&quot;,<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Suggest to use dev_ function to identify the device pci numbe=
r. Since<br>
&gt; &gt;&gt; the function still passes, maybe info level is good enough.<b=
r>
&gt; &gt;<br>
&gt; &gt; Ack'd.&nbsp; Will change.<br>
&gt; &gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; adev-&gt;gmc.xgmi.physical_node_id,<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; peer_adev-&gt;gmc.xgmi.physical_node_id);<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; return 0;<br>
&gt; &gt;&gt;&gt;&nbsp; }<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; -int amdgpu_xgmi_get_num_links(struct amdgpu_device *adev=
,<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; struct amdgpu_device *peer_adev)<br>
&gt; &gt;&gt;&gt; +int amdgpu_xgmi_get_bandwidth_mbytes(struct amdgpu_devic=
e *adev,<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_devic=
e *peer_adev)<br>
&gt; &gt;&gt;&gt;&nbsp; {<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp; struct psp_xgmi_topology_info *top =3D &amp=
;adev-&gt;psp.xgmi_context.top_info;<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp; int i;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; int num_links =3D !peer_adev ? 1 : 0;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp; for (i =3D 0 ; i &lt; top-&gt;num_nodes; ++=
i)<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; if (top-&gt;nodes[i].node_id =3D=3D peer_adev-&gt;gmc.xgmi.node_id)<br=
>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return top-&gt;nodes[i=
].num_links;<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp; return&nbsp; -EINVAL;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; if (!adev-&gt;gmc.xgmi.supported)<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; return 0;<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; if (peer_adev) {<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; struct psp_xgmi_topology_info *top =3D &amp;adev-<br>
&gt; &gt;&gt;&gt; psp.xgmi_context.top_info;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; int i;<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; for (i =3D 0 ; i &lt; top-&gt;num_nodes; ++i) {<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (top-&gt;nodes[i].n=
ode_id !=3D peer_adev-&gt;gmc.xgmi.node_id)<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_links =3D&nbsp; to=
p-&gt;nodes[i].num_links;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; }<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; }<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; /* num links returns 0 for indirect peers s=
ince indirect route is unknown. */<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; if (!num_links) {<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; This looks problematic. I guess, it is better to keep the old=
 way of<br>
&gt; &gt;&gt; passing min/max. Otherwise, there is a chance that min report=
s some<br>
&gt; &gt;&gt; value and max could report this error.<br>
&gt; &gt;<br>
&gt; &gt; I don't think this is a problem.&nbsp; The old way of passing is_=
min =3D=3D&nbsp; true is tied to<br>
&gt; peer_dev =3D=3D NULL, which made it a redundant argument.<br>
&gt; &gt; is_min =3D=3D&nbsp; false doesn't prevent the issue you've mentio=
ned from happening<br>
&gt; because the old code effective sets num_link =3D 0 if the peer_dev sea=
rch fails<br>
&gt; anyways.<br>
&gt;<br>
&gt; The problem I was thinking about was with respect to usage in KFD<br>
&gt; properties. With this way, min_bandwidth will report some value even i=
f<br>
&gt; no link is present between the devices. Max bandwidth will report 0.<b=
r>
&gt; Ideally, we should report both min/max =3D 0 when there is no link pre=
sent<br>
&gt; between the devices. I haven't checked if KFD does some other check to=
<br>
&gt; ensure that there are links between devices before calling the API.<br=
>
<br>
The KFD only queries for links within a hive.<br>
Checking for max first implies link on non-zero return.<br>
We could change the KFD to set zero on if max is zero then.<br>
<br>
&gt;<br>
&gt;<br>
&gt; &gt; With the line at the top of the proposed function:<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; int num_links =3D !peer_adev ? 1 : 0;<br>
&gt; &gt; The sematics are as follows:<br>
&gt; &gt; - NULL peer_dev indicates that caller doesn't want peer-to-peer d=
ata to factor<br>
&gt; num_links into bandwidth reporting so assume a single XGMI link in ban=
dwidth<br>
&gt; calculation.<br>
&gt;<br>
&gt; I think this semantics doesn't provide enough clarity. XGMI is<br>
&gt; interconnect between devices and ideally we expect two devices to be<b=
r>
&gt; passed to the API. If any one is NULL, then it's better to reject.<br>
&gt;<br>
&gt; &gt; - If a failed peer_dev search ends up with num_links =3D=3D 0, th=
at means the caller<br>
&gt; passed in an invalid node (i.e. it's not one of the nodes that's been =
registered to the<br>
&gt; hive).<br>
&gt; &gt; Currently, get_hops_count (old and proposed) operates in the same=
 fashion too.<br>
&gt; &gt; So the functionality between the proposed changes and old changes=
 should have<br>
&gt; remained the same.<br>
&gt; &gt;<br>
&gt;<br>
&gt; The API is usage is clear and general expectation is two devices are n=
ot<br>
&gt; NULL. That is clear in the case of get_hops_count.<br>
<br>
I don't see where that expectation is set in the proposal.<br>
peer_dev =3D=3D NULL is asking for a peerless check of potential bandwidth.=
<br>
If you're saying we need a redundant is_min bool to ignore peer_dev num_lin=
ks checks, I'd say then both are a waste of time for clarity's sake.<br>
<br>
In that case, if we want to be strict with both peers being non-NULL, chang=
e the following:<br>
- expose amdgpu_xgmi_get_num_links to KFD to mirror get_num_hops<br>
- KFD calls amdgpu_xgmi_get_num_links to do some handling and later pass re=
turn into a new bandwidth call if return is non-zero<br>
- change amdgpu_xgmi_get_bandwidth_mbytes(peer1, peer2) to amdgpu_xgmi_get_=
bandwidth(adev, const int num_links, enum unit_type)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - adev -&gt; used for future IP =
checks as a dynamic internal speed constant setter<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - const int num_links -&gt; call=
er passes in constant link multiplier.&nbsp; So in this case KFD can pass b=
ack the num_links it finds from previous amdgpu_xgmi_get_num_links<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - enum unit_type -&gt; some enum=
 we can define in amdgpu_xgmi.h to give the back the caller whatever units =
it's looking for (GTs, Mbytes/sec, Mbps etc ...)<br>
<br>
Then this way:<br>
- KFD enforces min/max bandwidth to be consistent i.e. both are 0 or both a=
re non-zero<br>
- bandwidth call is now more general purpose and flexible and provides vari=
ous bandwidth return types by caller needs.<br>
<br>
Jon<br>
<br>
&gt;<br>
&gt; &gt; I'm open to adjusting get_num_hops &amp; get_bandwidth_mbytes to =
return either -<br>
&gt; ENODEV (device not found in hive) or -EINVAL (bad peer_dev request) on=
 a failed<br>
&gt; search.<br>
&gt;<br>
&gt; On a failed search, does returning 0 work - zero hop/bandwidth<br>
&gt; considered as no link found between the provided devices?<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Lijo<br>
&gt;<br>
&gt; &gt; That would require a change to KFD CRAT logic to error return its=
elf on an error.<br>
&gt; &gt; However, this would change the behaviour of a bandwidth reporting=
 error where<br>
&gt; ROCm could still function, to the KFD not loading at all.<br>
&gt; &gt; Currently, the consequence of passing an incorrect peer_dev to th=
e bandwidth call<br>
&gt; would result in the ROCm Runtime not issuing an SDMA ganged copy i.e. =
potential<br>
&gt; peer-to-peer performance drop.<br>
&gt; &gt;<br>
&gt; &gt; Jon<br>
&gt; &gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Thanks,<br>
&gt; &gt;&gt; Lijo<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; DRM_ERROR(&quot;amdgpu: failed to get xgmi num links between<br>
&gt; &gt;&gt; node %d and %d.\n&quot;,<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;g=
mc.xgmi.physical_node_id,<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; peer_adev-=
&gt;gmc.xgmi.physical_node_id);<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; }<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; /*<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; * TBD - will update IP based bandwidt=
h later.<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; * Bandwidth currently assumed to be x=
16 lanes x 25Gbps.<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; */<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; return (num_links * 16 * 25000)/BITS_PER_BY=
TE;<br>
&gt; &gt;&gt;&gt;&nbsp; }<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&nbsp; bool amdgpu_xgmi_get_is_sharing_enabled(struct amdg=
pu_device *adev,<br>
&gt; &gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h<br>
&gt; &gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h<br>
&gt; &gt;&gt;&gt; index d1282b4c6348..325e7972469d 100644<br>
&gt; &gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h<br>
&gt; &gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h<br>
&gt; &gt;&gt;&gt; @@ -62,10 +62,8 @@ int amdgpu_xgmi_update_topology(struct=
<br>
&gt; &gt;&gt; amdgpu_hive_info *hive, struct amdgpu_dev<br>
&gt; &gt;&gt;&gt;&nbsp; int amdgpu_xgmi_add_device(struct amdgpu_device *ad=
ev);<br>
&gt; &gt;&gt;&gt;&nbsp; int amdgpu_xgmi_remove_device(struct amdgpu_device =
*adev);<br>
&gt; &gt;&gt;&gt;&nbsp; int amdgpu_xgmi_set_pstate(struct amdgpu_device *ad=
ev, int pstate);<br>
&gt; &gt;&gt;&gt; -int amdgpu_xgmi_get_hops_count(struct amdgpu_device *ade=
v,<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; struct amdgpu_device *peer_adev);<br>
&gt; &gt;&gt;&gt; -int amdgpu_xgmi_get_num_links(struct amdgpu_device *adev=
,<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; struct amdgpu_device *peer_adev);<br>
&gt; &gt;&gt;&gt; +int amdgpu_xgmi_get_hops_count(struct amdgpu_device *ade=
v, struct<br>
&gt; &gt;&gt; amdgpu_device *peer_adev);<br>
&gt; &gt;&gt;&gt; +int amdgpu_xgmi_get_bandwidth_mbytes(struct amdgpu_devic=
e *adev, struct<br>
&gt; &gt;&gt; amdgpu_device *peer_adev);<br>
&gt; &gt;&gt;&gt;&nbsp; bool amdgpu_xgmi_get_is_sharing_enabled(struct amdg=
pu_device *adev,<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; struct amdgpu_device *peer_adev);<br>
&gt; &gt;&gt;&gt;&nbsp; uint64_t amdgpu_xgmi_get_relative_phy_addr(struct a=
mdgpu_device *adev,<br>
&gt; &gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c<br>
&gt; &gt;&gt; b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c<br>
&gt; &gt;&gt;&gt; index 70b3ae0b74fe..a787d192390c 100644<br>
&gt; &gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c<br>
&gt; &gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c<br>
&gt; &gt;&gt;&gt; @@ -2133,8 +2133,8 @@ static int kfd_fill_gpu_direct_io_l=
ink_to_cpu(int<br>
&gt; &gt;&gt; *avail_size,<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; bool ext_cpu =3D KFD_GC_VERSION(kdev) !=3D IP_VERSION(9, 4, =
3);<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; int mem_bw =3D 819200, weight =3D ext_cpu ?<br>
&gt; &gt;&gt; KFD_CRAT_XGMI_WEIGHT :<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_CRAT_INTRA_SOCKET_WEI=
GHT;<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; uint32_t bandwidth =3D ext_cpu ?<br>
&gt; &gt;&gt; amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; kdev-&gt;adev, NULL, true) :<br>
&gt; &gt;&gt; mem_bw;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; uint32_t bandwidth =3D ext_cpu ?<br>
&gt; &gt;&gt; amdgpu_xgmi_get_bandwidth_mbytes(kdev-&gt;adev, NULL) :<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mem_bw;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /*<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * with host gpu xgmi link, host can access gpu memory =
whether<br>
&gt; &gt;&gt;&gt; @@ -2198,12 +2198,11 @@ static int kfd_fill_gpu_xgmi_link=
_to_gpu(int<br>
&gt; &gt;&gt; *avail_size,<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; if (use_ta_info) {<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; sub_type_hdr-&gt;weight_xgmi =3D KFD_CRAT_XGMI_WEIGHT *<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_get_xgmi=
_hops_count(kdev-&gt;adev,<br>
&gt; &gt;&gt; peer_kdev-&gt;adev);<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_xgmi_get_hops_c=
ount(kdev-&gt;adev, peer_kdev-<br>
&gt; &gt;&gt;&gt; adev);<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; sub_type_hdr-&gt;maximum_bandwidth_mbs =3D<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_get_xgmi=
_bandwidth_mbytes(kdev-&gt;adev,<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; peer_kdev-&gt;adev, false);<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_xgmi_get_bandwi=
dth_mbytes(kdev-&gt;adev,<br>
&gt; &gt;&gt; peer_kdev-&gt;adev);<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; sub_type_hdr-&gt;minimum_bandwidth_mbs =3D sub_type_hdr-<br>
&gt; &gt;&gt;&gt; maximum_bandwidth_mbs ?<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_get_xgmi=
_bandwidth_mbytes(kdev-&gt;adev,<br>
&gt; &gt;&gt; NULL, true) : 0;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_xgmi_get_bandwi=
dth_mbytes(kdev-&gt;adev, NULL) :<br>
&gt; &gt;&gt; 0;<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; bool is_single_hop =3D kdev-&gt;kfd =3D=3D peer_kdev-&gt;kfd=
;<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; int weight =3D is_single_hop ?<br>
&gt; &gt;&gt; KFD_CRAT_INTRA_SOCKET_WEIGHT :<br>
&gt; &gt;</span><span style=3D"font-family:&quot;Times New Roman&quot;,seri=
f"><o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_CY8PR12MB743532330A07911F2FA60DEA85FE2CY8PR12MB7435namp_--
