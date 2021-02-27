Return-Path: <SRS0=9a13=H5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3950DC433DB
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Feb 2021 01:35:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D702064EDC
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Feb 2021 01:34:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D702064EDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6740C6E41A;
	Sat, 27 Feb 2021 01:34:59 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2067.outbound.protection.outlook.com [40.107.100.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40A846E41A
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Feb 2021 01:34:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhyIguvCf+7IKS5iPb41g+jO4+YnHBBzfHPq7ygBL0Vjc8hxHAiF/vkcd2htRISsRatU52W7mm3M5jKrU8icn99p1p6B5La/XMI3gJsrWe8xhapaIOhgKrdwN1oLf5RLM2pRNTxHYh3QtOrN/1nbgtgTSZ59/uO6KleD5lj3KBJBda9JPpb860+3MteUfSmWIOBl9/HCMS7RUOt9fp1+OoM6o2mHGv5v7eX08yRGyPMsdT9PQHJCgbDUbKnnRLPG1X9tYOaWAFUTeDwZe0kqhs2DBNLEBNsxUSc6qwo1jgXn+LXYkAKx6O/eUBv1hr8BnFkF0dnRjTkTKjn/EQlefw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVHUGQdBIu69rdxOYRD/HODb8Fr7ArENVX7EU7VLxPE=;
 b=Zd9hDEwd8QeyxFLOS+SIi3THOK0E9Trid4QGb0CNkcupQGrYvpLgMu8ulGRo7SJgFknBHn4jXcSK5R3IFYKX2+1eMsvzb+MYYGS0U0O7xqiBcgaj4K8XakQVv7t37Ua2iXfdEocWdn9P4i0RlGqNW7582Zps2XDP8FgqVV6CzSlDsRzSpYu1r2uJVKjtDzKWHligrDeEGQinl9kP79R6Vmd0YeFiRIVD9MtwDm9fsU1a/OoRRq73Aiv1cY7qmzcbx26bieBuNdB5ogghMih2VFww/aH9NmbNSIK3LgISJIE5+90hrjye5U1IhNPU++StkOwqfQ2QHsx46JXi/9A2pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVHUGQdBIu69rdxOYRD/HODb8Fr7ArENVX7EU7VLxPE=;
 b=pPLyvokZya+8dxXP54Kx9Rfj749WmIqhKgoaLdXvZBHgpECUNc2VIuMnOjjbDdTuinJnuClkBs0qYXwgSz4PNEyHyNBlxr3UxvJth2vf82a2856nou4gseA1swGpl4fk89boS4GkyINQduudXhu5A0u2rFbC4jcRsE0f4Kk/ZaM=
Received: from DM5PR12MB4679.namprd12.prod.outlook.com (2603:10b6:4:a2::37) by
 DM6PR12MB4484.namprd12.prod.outlook.com (2603:10b6:5:28f::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19; Sat, 27 Feb 2021 01:34:56 +0000
Received: from DM5PR12MB4679.namprd12.prod.outlook.com
 ([fe80::4846:47d7:6a0:1044]) by DM5PR12MB4679.namprd12.prod.outlook.com
 ([fe80::4846:47d7:6a0:1044%7]) with mapi id 15.20.3868.032; Sat, 27 Feb 2021
 01:34:56 +0000
From: "Cornij, Nikola" <Nikola.Cornij@amd.com>
To: Simon Ser <contact@emersion.fr>
Subject: RE: Overlay issues
Thread-Topic: Overlay issues
Thread-Index: AdbSl9sxMkfhaFWoRjW4p/7OX2aWMgAIDMeAABHbJ1ABe+bI4AuFiu2AAI89wCAACgiVgADPiLmQ
Date: Sat, 27 Feb 2021 01:34:55 +0000
Message-ID: <DM5PR12MB4679498E09A74977446CF66FEE9C9@DM5PR12MB4679.namprd12.prod.outlook.com>
References: <DM5PR12MB4679C807DB8DB502AC4793DCEEC60@DM5PR12MB4679.namprd12.prod.outlook.com>
 <05FNtjCma79AawCUxH3mqJ8sWHmoIXFXhQWW0N_b-mpl7QvuW3JN3AbtPUiR0y1LOf3tLhWFWv8YjuIEvJ3dci9y1EHk_D9a9L1BAyWyxRs=@emersion.fr>
 <DM5PR12MB4679F2B26887B76BC025161AEEC60@DM5PR12MB4679.namprd12.prod.outlook.com>
 <DM5PR12MB46792E5F8DF0F128FF01D79EEEDE0@DM5PR12MB4679.namprd12.prod.outlook.com>
 <Zq5awE32--JJaePI-8O0Rd-2AYVUPYgIn1PspErRR_qpQeTlX_L0M_8iQMyN6rGZPJRuBmkf6OGmeQFLYkzB9cswAhdyWbAzEXqT-0ZjFC4=@emersion.fr>
 <DM5PR12MB4679C406F33E9B04BA343295EE819@DM5PR12MB4679.namprd12.prod.outlook.com>
 <Kdv-dXZJZAwHurjWGxke0BycsKRikMsY_omFpPVknQqoLWCweXWWMs9ET6_Ax0hIMvFKornwDJ2i5MXyspmEykuloW5IppjT-w6NT6vfIBU=@emersion.fr>
In-Reply-To: <Kdv-dXZJZAwHurjWGxke0BycsKRikMsY_omFpPVknQqoLWCweXWWMs9ET6_Ax0hIMvFKornwDJ2i5MXyspmEykuloW5IppjT-w6NT6vfIBU=@emersion.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_Enabled=true;
 MSIP_Label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_SetDate=2021-02-27T01:34:54Z; 
 MSIP_Label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_Method=Privileged;
 MSIP_Label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_Name=Internal Use Only -
 Restricted;
 MSIP_Label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_ActionId=95e6c4dc-87c4-445b-9261-6f98de122fc0;
 MSIP_Label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_ContentBits=1
authentication-results: emersion.fr; dkim=none (message not signed)
 header.d=none;emersion.fr; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f994ff17-d1c5-49c4-e6bc-08d8dabfe364
x-ms-traffictypediagnostic: DM6PR12MB4484:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4484DFE911787A8CCAC4BEB0EE9C9@DM6PR12MB4484.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4vTVdRHy1dxdbnYz0f5tQ8ILliQObzu4T0SvsTWYqMwp7Tt4rbGwIXhYloejNejqVMl8oQedDtzl7bEsGvrdw7Y5uk3gnDNNzloVapm6SZAaIHC93JYalBjnawmZv7fiqYYGrJkmdYR3hovgtmkohEINxsUPOA3tTwgeHfreZkTU6rWBwjViiG/5axd/MB6DiitJeS9+zqH8wQyWTusAHbbmBrt0jk6AbJJbWm0HYjWBgNRG18/rYfAfi8k1vcWxI8ppseKUk7+cI+HiYxfY07renqK5IKE89K1K0yOJwrSK46YzDzqWCJo2JMJPZ0vA7fHXvUMruA4ng02NdIYLJZQaCc6SLd5a0dYfq8pvFJcxr2I54Q+C/qOvz5zi9M/m9Jaf7QQaEEVgOK7Dy5E/p+7ZFuFCJsjXFMQAU+wPetXvInExrc3RbaoR2+4qHg1p3Yg8DyolvKGOzy7R0ixHa5n11ST6cuaXdaqBhnGqh7HPw+PdExMgJDlW6DE/6UsYRTWjTyETwkjQ5sn698kQbQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB4679.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(396003)(136003)(39860400002)(376002)(478600001)(7116003)(9686003)(6916009)(3480700007)(33656002)(4326008)(86362001)(26005)(186003)(71200400001)(55016002)(64756008)(66446008)(66556008)(66476007)(76116006)(5660300002)(66946007)(8936002)(52536014)(2906002)(7696005)(8676002)(83380400001)(53546011)(316002)(54906003)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?QlJ0T0hxTkU5Z1dMVmpieUViSldQdS9pUXBDMWdJd05UdVZRZktMWTFBUTR6?=
 =?utf-8?B?dVkrUUhOOGIya2RBc3hvbWkwSy9HZCs4bWJwMzFxdkR0YlM3bDNjRWsyK0ZC?=
 =?utf-8?B?enFPWkJaeDFiRUd6OURTQ3ZhVXIvdVV4WHFocWtaYXZkOG5GVmFXMGc5dWo4?=
 =?utf-8?B?UzZ1c0VPM1MxUUlmUnlZY0lmbytYL2xWWStTclJab3c5NERoNG5pQ2NxcjBI?=
 =?utf-8?B?MTI4dno1Vk96RHRHUTZKNVpCT2Q0OGk3RW9FRTVwVEVNYkNxQTFDOE0xZTll?=
 =?utf-8?B?SmRnUy9HQVVWUVd0VVZvaE10aWpzdkJyTTJnMUZMNmVPeWVJYXNBY3hZZGpm?=
 =?utf-8?B?c2FQY1VjWCszcEw5RHdjQTFBVzc4b2ZSdkVweDFKKzFlVUtib3V0WUtUYUxJ?=
 =?utf-8?B?cUovQ3VCQzJPOUNhY1k0YkJZeVpWRkRHMzNPeUpSYmorTGF2WFg0L0dZa2Ux?=
 =?utf-8?B?NzYrV3JDQmIrZlpxSHFYWUsweEEzWjQ1N3k0eUFQekw2bm1aQlpBUnY4ZlR5?=
 =?utf-8?B?NCtZNlhXbkh6dStheVR3RmtJeERjRWZteUpxWmFPdkhHcWU1d1gxQ1N3ZHBI?=
 =?utf-8?B?S0RsSWtMQjhBc1lqVUh1S204bDVlNVRxYXhSOTF5NDdENVl3dmkwV2pSY3Qv?=
 =?utf-8?B?blpiSHNTUkZ0aDQwQ21IN1VSS3VTQzRtcThVMGJQZHpqZk1qL1pmWEdLVXJs?=
 =?utf-8?B?SVhOYmxkamtrdlo2MGRhb3lRUGhFbHdLeWFRNzFMNU92S3pTYzJEaG55elhO?=
 =?utf-8?B?ZlB6U3h2MWVCczZlNUZmUXhiU0JBY2hNanNZWW5WeGhTLzRqdWRWUTFnZnVj?=
 =?utf-8?B?eTg1M0dtNisrNjJlZmtUNGsxU0NMMTBxd3ZNYlFPREhzdm9JSWlFT2N5YTF4?=
 =?utf-8?B?OE9pQTFGNjJCbW42SW9rRE9yODFlZTFadFA3VnIvMzJTT01RRUJDcjVVcTBv?=
 =?utf-8?B?am00RG9hR0xyVHJQWlp3MFFSNVlFMHRFU2lDVHd0VzdCcGtiZ2JDSWxlRDVJ?=
 =?utf-8?B?SGUzV3ZMM0lsNXg3eXpyNG0zbjlqNnRXN3VOVC9DdXRqZDMrQkR0ZUdKbWkw?=
 =?utf-8?B?SWZ3T3A1QTB0MGVxcWZ5eDdyelA1MDc5UGhhZW9XV1FVVTErRkVCYWVxZUd6?=
 =?utf-8?B?djJ5TTB0UCszSHRDVFZrK1E0VzMwdFVNTnBiR3QxRmZESkc5TEdMelU3c1Vr?=
 =?utf-8?B?a2wzV1ZEVnBLUTVzTDNuM0lHT0JndHZEL2JwQTUvRXAvU3kxM2VZclNXVEdF?=
 =?utf-8?B?SUxTRE1jN21XTTdqK05pd3NBNkJ4T2FoT1VzZkhad2NTRjBFcndoL0xvZEVL?=
 =?utf-8?B?ZU5BbDZ1b2xoZGRaN3dNa1hGVnBmdlBOTDJESE54VTRwR1JzeEJveUE0NDlG?=
 =?utf-8?B?T1M3eXRUOXJqenhZWHZQajdRN0dURkhOWGJqSXZDNi9mb3VPTkV6UURiTUpL?=
 =?utf-8?B?ZGRObEpxME1lYXdlWXNUQnlCcnFhV0NBc0t6TnFWUkQ0Q2NJZlJEQkdrTDd3?=
 =?utf-8?B?bmFKdjJYSmh1UEFhNE4vQ2xSSXl3TVhZNHoxVFhqSzNzWGdheW43cDNrSGdo?=
 =?utf-8?B?L29lSk9TU082TzhIQ3ZVRHh3OGVLTHRyemt4VEk3d3crYk03SURjdWNGUFNG?=
 =?utf-8?B?YjJXTWxmWGp4LzRFbG45dUVBOWpNa0UzdmxmMFRwTE1XdUVzT0RsZUNHNytN?=
 =?utf-8?B?a0lVM1A5OHArTkZpazRQMDFCcVJCSXoyK3VEd2VwSHpjZ1pJY0x4VlExY3lj?=
 =?utf-8?Q?W707BqxEXMVGkfL2citKylw2prPeMmvGwRtzWcb?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB4679.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f994ff17-d1c5-49c4-e6bc-08d8dabfe364
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2021 01:34:56.0445 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: beCcVYI6cDhPWxIDsVHyiqtbzC+D97Yzvsmc+95zt4yi3obsqOB0DB4edK8va4mXFSKaEQZ+l3ysZHpmzl7XWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4484
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
Cc: Alex Deucher <alexdeucher@gmail.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Approved for External Use]

Thanks for the suggestion, Simon.

Improved the patch, now in the process of getting it reviewed internally. It'll be posted for upstream thereafter.


-----Original Message-----
From: Simon Ser <contact@emersion.fr> 
Sent: Monday, February 22, 2021 5:31 PM
To: Cornij, Nikola <Nikola.Cornij@amd.com>
Cc: Alex Deucher <alexdeucher@gmail.com>; Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: RE: Overlay issues

On Monday, February 22nd, 2021 at 9:59 PM, Cornij, Nikola <Nikola.Cornij@amd.com> wrote:

> [AMD Official Use Only - Approved for External Use]
>
> Hi Simon,
>
> Yes, I did have a chance to wrap this up, indeed :-)
>
> It turned out this and other similar setup was hitting a legit HW 
> limitation. I added a patch (please see attached) that'd fail this 
> config at validation time. The patch has been merged for upstreaming 
> at the beginning of February time-frame, not sure if it made it to the 
> public repo by now.

Excellent! I don't see the patch in agd5f/drm-next yet, but it'll probably show up soon.

Thanks for fixing this!

One small nit: if possible, add some drm_dbg_atomic() calls explaining the error right before returning -EINVAL. This is very valuable when debugging user-space applications and trying to figure out why the kernel rejects an atomic commit.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
