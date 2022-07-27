Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C46C04A68
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jul 2022 21:22:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F4DF93E40;
	Wed, 27 Jul 2022 21:22:00 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2054.outbound.protection.outlook.com [40.107.95.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 386D5944DB
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jul 2022 21:21:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SeuWN+NysVwek04JCYSXzegopGVp4KHhrI7zN97d1JkRPOxKkI4wqug5bZ/5OFI7zp5yVERwJnqOPVxUr4gczJynLye7mkZenw0gwG+rEmNOsRxkqrWuamKahgICjOT9Vm2PJj5BcsZ/gh6RaVK/i0jBXBYebQ+9uE8IhlJhvi+WyOEgksAsw3PEFyq1NVVM4yNpwXPpEGUIBppwyO450KyT07TjKDaZTctAD15NLP200NjeIlXxi643ipjBNWcIcMX+m5PdrervRXx34IG1OABocXdTj52M+D1DoKOaVD9OhtJ6819rRfXpJjMEdqLG4zlctPyiL2g3Bgh+Se+U4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h36TVVbLb3bV9KwA9V2w9qXFJLM5zmcS7tS3NGsWtsk=;
 b=k0rcHXICu9V2TMNGWB7G+vQytjoOrAAMLgaVGfvcgyJ/CBOcrBSHzrfVHF8W5o3wSluXo6OYZnozu/yc0/8rvKGQjfwzNd0/jk48rB/DL777Pi20wkI5oQhjqQ3nGr53yXNW/Abmi0plaq+A7fGsZPam4wcc25uW/QNkkw/rJWVtqAgAgRiikybk0KAVfCyZcbTaRY5iJUpWdHwDjUAUN229bE3QT4kU0z4B+xkGZInh87zCH1Xkmz8IzYZl+VRBGoT3Gf4PboFurladBSgfjUqE3ePEdFNDCxNGNwFnejMvI2TnaXouvxLCqZ0FL77m5sqdH58epSE3hxSXMWbKQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h36TVVbLb3bV9KwA9V2w9qXFJLM5zmcS7tS3NGsWtsk=;
 b=xP2lwfqXGiu7BJ0FbdsHNJ92IwuPE0O6/3T//oWi2uQklzgKg5/S4oyDxjWhadMo6V7Btdx7ov+rXoLF5vpGssEPzB1iXla7cajR4BfjmOlRw/AdJh7MEHAyx1U0ZgBRkcXKrzO7ZVY1QOmXUxGceLXsIbmzpsVEPtFsKRnuLmY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Wed, 27 Jul
 2022 21:21:50 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::d122:1dae:8445:2e43]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::d122:1dae:8445:2e43%7]) with mapi id 15.20.5458.024; Wed, 27 Jul 2022
 21:21:50 +0000
Message-ID: <b872acc1-f844-cff4-b375-494a93654e04@amd.com>
Date: Wed, 27 Jul 2022 17:21:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/4] Documentation/amdgpu/display: add DC color caps info
Content-Language: en-US
To: 20220716222529.421115-3-mwen@igalia.com, Melissa Wen <mwen@igalia.com>
References: <20220716222529.421115-1-mwen@igalia.com>
 <20220716222529.421115-3-mwen@igalia.com>
 <facabe6b-182e-4902-e8a0-9ca66ffe1994@gmail.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <facabe6b-182e-4902-e8a0-9ca66ffe1994@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0254.namprd03.prod.outlook.com
 (2603:10b6:610:e5::19) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31a1d9ca-f0b3-41d7-58f8-08da701604d0
X-MS-TrafficTypeDiagnostic: BN8PR12MB2900:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NXUhMwOczfu+AovC1S+KuWIv8Ru3Zv9CYWx0ZnYZjjuoMboAgEItqoAmxPbvb3GDPextGE2BWNC/gm+ncdojZc09gpxQZbVBiTZ0ME+AyklUfSDkBxY6DIWjSHX5l6Ln156/d9IRSuxG5xLBJJHKiAjQsrLLytP7Q3NM3zFORgJBmydHGRZVaIA8/vqxM5U+3Mbx6NI18MNUggrwypop1AK39+mhMqnb1S5OTPBDmEXnnPjNREpCiDcGoD3DLhptEc3nDqvNy7EqvPomZyfX8fkhSaqxZd45VeqElPONkYkUaVFy5ziInj38reV6fbig6K0ZP2RQPrOYP0Epa0ZGcws1bIS6Vueuo5LuTPOmGDcJzuV3vg65BWEJyDFqMk+TnEXsQs4qCt0uPYXSMxPfnfOh+qUeLrGO7j0EFmv7lGMUxuLkzMZ4xQSxfDSJdsujIcpjRpEMTgurGyMnnekwb0UFENOhNzHEjvwUh8eCD+stSsxJ1EwQ/rXXZm9mAKmfStXDgfxzAfNR6F6leFFHrPt9F4TK7rGlhGEQCwkcl13FEMn0PJLIFrEOtqAigCbP8mRe0/CtxgQJ5wEOk1ulO/Zv6C6/D3wmObZqM6Ccm8/9tU0CxS+fGazuw3Gq0cwWgTLYu4S7+FYH4pEc2W9iqQjUyZjkevnllpyOF5qrm60Lz1347Eq2c6Zk3m/h8co7ifYB7hUv70lGaVFVsDY0lHt/rJvH5B5MDckLHlw1dNYxqXQLXHDIYoZ2InOdmQHT1OhL3jGWtk3ePjC38Rx/+wauGUWssULZA6qiCnb6+FIg4A4UAr10PUBh1zOOPN5FXaL+27mOxCtg37GS5HeY8tkkSu/sy8HlLDFRG04x951UPtCccBB4449k3fi4gIWiTegXL0imfrmEjS68JCgsyJ8LV195mAFd5xmyQnSSKzY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(966005)(6486002)(316002)(86362001)(31696002)(40140700001)(19273905006)(36756003)(478600001)(41300700001)(31686004)(53546011)(38100700002)(6506007)(6916009)(6512007)(26005)(2616005)(4326008)(30864003)(8676002)(2906002)(186003)(8936002)(5660300002)(66556008)(66476007)(66946007)(83380400001)(45980500001)(43740500002)(579004)(559001)(563064011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGRjNDdzc1RYRGZTS0tOTmMvVDhxZzZTVm1FWkVJeUJjTUtSZnp5MXhHNWdX?=
 =?utf-8?B?K2VHOURnbWdpSE0zQXdVWHMzK2lxQmJmbi9UQ3gwb2g0TnZtSWI0QnMvZGZR?=
 =?utf-8?B?b0oxWXlBcU5RbWZ4bGJuS0cvZDVWcXM1WjdINUZmNklsaStCYzBOdnc5RlFL?=
 =?utf-8?B?YjNZVGNDaFltc1duRWpCLzFaNHduNkt1dUtZeThxT09oZjgyRmUxZHVYYWxo?=
 =?utf-8?B?bTA1L2Q3S1lvZkhKODFta2hzajBFWTJTSllvNGhXOVZnM2c5dlZzWElJbVBB?=
 =?utf-8?B?QTdBSzR1U1VJMFh5dUZKcWdOSzBmK0R4SUlzM2U0Qy81c241ZXZrdmFWTEdB?=
 =?utf-8?B?d2xPUUhYODVDZ1pZT1J3SnU4RWFyYWZKb0U1TDI4SlRDem9uRXdaUkxYT25E?=
 =?utf-8?B?UTZpWHlFak1qY3E2eC9oVDNTYkwyZHh1Wm1yOE1hdHdKVGdtUVZGcFNFS3Qv?=
 =?utf-8?B?aEp2eVZDN0ZuQVRTZktGc1BSSTJzMlFscXNqdHE3My8xaGNsblVwQ1l5aXRn?=
 =?utf-8?B?M0l5TEkxVWlwSktpL1NTZktRRklqZ3NZM01xT0ExNkxXMmJPVVVuUHNSRlNp?=
 =?utf-8?B?a3hqTW1ObGdRc3J2QWI0SFUxTWk4S2dBT3ZiQUU2ZGZoVXQxc0Q3YUQxUnZn?=
 =?utf-8?B?ODdsQWM4MnpFNXk1WDB0RGxQYTVMMFljbmIxdTRJOXVzTFJsSTdYVjIvREYy?=
 =?utf-8?B?Y2ZmQ0hEWHdmSm9yVWhEZFlRYlZJMUZqcExEQ3U2QSthM3ZGcjZoTGF3NUY3?=
 =?utf-8?B?ZnNJRTRZTnpvWllMN3pkU245YklwTS9zUlpKUXNMNXJlU28yQnNnb1RFT3hp?=
 =?utf-8?B?djl3aExoNHJLRENNK1A2YjdBZXJ3MGRXbnBIbWhGdG5IeGVzRWpkeTcrVmtl?=
 =?utf-8?B?dFZrQ09uSEo4c3Qxd0J2d2RKVWJnSG9ZKzVhZTB2ekhLSHBJN3pOcDRmdERo?=
 =?utf-8?B?RmtHUDJTMWdPVm1FY2dqOFZjV0NYRXVOMTZvVzF4emI4dFg3M3J6OTFKQkVx?=
 =?utf-8?B?ZVFGSXdSd0N3RjlVTWNHMjQ2OS9QS1VvejF3S3ZOMmNvL1hNdTFMMHVobDA4?=
 =?utf-8?B?aU1CZ0MrUE8rS3Nsc2dsc0JreGcvUlpiOExpSFhVZWE0K2NLZkVtR3ZUWXNo?=
 =?utf-8?B?TTIwa2trdU1FWnY0enBZMm1PUDJBTVFpZWc5WlBTYXpzNnkyeDZWeTYwbklx?=
 =?utf-8?B?aU9nY1FoWUdTOWMzeE4wZGI1b00zTURHekpCRkkxeWFuUk9IU0dURzk1MzQ5?=
 =?utf-8?B?dWpzQ3lEM0txMDQrZHRqZUxKcHBETUdnTXZyeDhIRm9TandFOFNKd0drWDJW?=
 =?utf-8?B?bWttWksza1VIR2Z6QmJTTUxaN3lFQmh6cHU1d3h2eFdJejhuNmkwMjgzUGxt?=
 =?utf-8?B?dEthbno1V2dhbWNST3BkOEhpMTl3Z0ZmbWhTSHBVazlpVzgyOVVQUGlsTXkx?=
 =?utf-8?B?ckFqd1RlNS9ZOVZYQndIUG02akVFd0ZNYXRZUGM1RTY4dE91KzE4eVc1L3NC?=
 =?utf-8?B?eUJBOEJTSWFYSS9VTElpdG9PbDdtaktlb2xjWU10eVVTVzdiUUhocWtpVEkr?=
 =?utf-8?B?K1NGL0JKUTIwdjA1YkhrU0dDMTZ4WmY3WlAwY0ZXYVA3UTd1SjVGNkFhOUUv?=
 =?utf-8?B?Z2t4by9FREErMXZCc1VYckUxODROS3VYTFg3cS92a1dpcTZYWW92b3NkNnZl?=
 =?utf-8?B?OHUwTm1uNllHVDl1SS82bE0wR0lOV2xMWHVLYk1zbEQzNXZ5OVovbkhWMkVP?=
 =?utf-8?B?SzhrbVE2TVRpVGhoNUZUZ0MzcGV2RWR4VFZwcEh1WDB3eU5hcmFjZ2tkbUN3?=
 =?utf-8?B?ak9WbFE0WDVNbEZ1WXdVbHBYcWd2d3U3NzdGc0dtVUtnZVgrL3E2aDdDVTV4?=
 =?utf-8?B?QTRjMWhMckZmbGxlUWlJT1cwSk9VUmo5ODgzbGw2djl1WlE4cVI2MkgyNFNY?=
 =?utf-8?B?V09zb0dwQkpJUWVnUEI3NmhtZ1g0MlZlQ3lDVHZJUEFVYmRZVkpvVXJnd2d6?=
 =?utf-8?B?T2dMemdzT3h4MWh2NWhQd09Vd3JYbWNwWjNnMnlkeThHajBKOFNNaVVMR09V?=
 =?utf-8?B?bkdoV1ZvK3liYSs2NEkvMVVzNTd0ekpEOGpoM2Z3cWZJNWRIc3RXc1EwSW90?=
 =?utf-8?Q?0+bYh2jf0JlL3aupQc3FzsVqN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31a1d9ca-f0b3-41d7-58f8-08da701604d0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2022 21:21:50.1044 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bpRgRacjIeWpYJw1I/9VOBf9ISSckw/y5VLL3KLyU30Z9pw5nVTSda1/JMvShajPrCso7/9Aehn0WKCSdyhEjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2900
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
Cc: sunpeng.li@amd.com, Xinhui.Pan@amd.com, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, alexander.deucher@amd.com, harry.wentland@amd.com,
 nicholas.kazlauskas@amd.com, sungjoon.kim@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-07-17 19:28, Tales Lelo da Aparecida wrote:
> On 16/07/2022 19:25, Melissa Wen wrote:
>> Add details about color correction capabilities and explain a bit about
>> differences between DC hw generations and also how they are mapped
>> between DRM and DC interface. Two schemas for DCN 2.0 and 3.0 (converted
>> to svg from the original png) is included to illustrate it. They were
>> obtained from a discussion[1] in the amd-gfx mailing list.
>>
>> [1] 
>> https://lore.kernel.org/amd-gfx/20220422142811.dm6vtk6v64jcwydk@mail.igalia.com/ 
>>
>>
>> v2:
>>
>> - remove redundant comments (Harry)
>> - fix typo (Harry)
>>
>> Signed-off-by: Melissa Wen <mwen@igalia.com>
>> ---
>>   .../amdgpu/display/dcn2_cm_drm_current.svg    | 1370 +++++++++++++++
>>   .../amdgpu/display/dcn3_cm_drm_current.svg    | 1529 +++++++++++++++++
>>   .../gpu/amdgpu/display/display-manager.rst    |   35 +
>>   drivers/gpu/drm/amd/display/dc/dc.h           |   74 +-
>>   4 files changed, 2995 insertions(+), 13 deletions(-)
>>   create mode 100644 
>> Documentation/gpu/amdgpu/display/dcn2_cm_drm_current.svg
>>   create mode 100644 
>> Documentation/gpu/amdgpu/display/dcn3_cm_drm_current.svg
>>
>> diff --git a/Documentation/gpu/amdgpu/display/dcn2_cm_drm_current.svg 
>> b/Documentation/gpu/amdgpu/display/dcn2_cm_drm_current.svg
>> new file mode 100644
>> index 000000000000..315ffc5a1a4b
>> --- /dev/null
>> +++ b/Documentation/gpu/amdgpu/display/dcn2_cm_drm_current.svg
>> @@ -0,0 +1,1370 @@
>> +<?xml version="1.0" encoding="UTF-8" standalone="no"?>
>> +<!-- Created with Inkscape 
>> (http://www.inkscape.org/ 
>> -->
>> +
>> +<svg
>> +   version="1.1"
>> +   id="svg2019"
>> +   width="1702"
>> +   height="1845"
>> +   viewBox="0 0 1702 1845"
>> +   sodipodi:docname="dcn2_cm_drm_current.svg"
>> +   inkscape:version="1.1.2 (0a00cf5339, 2022-02-04)"
>> +   
>> xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape 
>>
>> +   
>> xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd 
>>
>> +   
>> xmlns="http://www.w3.org/2000/svg 
>>
>> +   
>> xmlns:svg="http://www.w3.org/2000/svg 
>>
>> +  <defs
>> +     id="defs2023" />
>> +  <sodipodi:namedview
>> +     id="namedview2021"
>> +     pagecolor="#ffffff"
>> +     bordercolor="#666666"
>> +     borderopacity="1.0"
>> +     inkscape:pageshadow="2"
>> +     inkscape:pageopacity="0.0"
>> +     inkscape:pagecheckerboard="0"
>> +     showgrid="false"
>> +     inkscape:zoom="0.56413987"
>> +     inkscape:cx="1003.2973"
>> +     inkscape:cy="691.31792"
>> +     inkscape:window-width="1920"
>> +     inkscape:window-height="1011"
>> +     inkscape:window-x="0"
>> +     inkscape:window-y="0"
>> +     inkscape:window-maximized="1"
>> +     inkscape:current-layer="g2025" />
>> +  <g
>> +     inkscape:groupmode="layer"
>> +     inkscape:label="Image"
>> +     id="g2025">
>> +    <rect
>> +       
>> style="fill:#000000;fill-opacity:0;stroke:#000000;stroke-opacity:1"
>> +       id="rect34"
>> +       width="208.83351"
>> +       height="486.09872"
>> +       x="0.90158081"
>> +       y="132.77872" />
>> +    <rect
>> +       
>> style="fill:#fad7ac;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1019"
>> +       width="126.38867"
>> +       height="55.320732"
>> +       x="25.960823"
>> +       y="188.06937" />
>> +    <rect
>> +       
>> style="fill:#d0cee2;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1021"
>> +       width="126.38867"
>> +       height="55.320732"
>> +       x="25.960823"
>> +       y="346.06937" />
>> +    <rect
>> +       
>> style="fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1103"
>> +       width="126.38867"
>> +       height="55.320732"
>> +       x="25.960823"
>> +       y="266.06937" />
>> +    <rect
>> +       
>> style="fill:#f9f7ed;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1105"
>> +       width="126.38867"
>> +       height="55.320732"
>> +       x="25.960823"
>> +       y="426.06937" />
>> +    <rect
>> +       
>> style="fill:#e6e6e6;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1107"
>> +       width="126.38867"
>> +       height="55.320732"
>> +       x="25.960823"
>> +       y="506.06934" />
>> +    <path
>> +       d="m 402.61883,171.88069 c 0.025,10.97895 0.01,1001.03791 
>> 0.049,1012.01891 2.5462,-1.1592 5.0637,-2.3779 7.6202,-3.5187 
>> -2.7411,4.8298 -5.4987,9.6453 -8.2624,14.4607 -2.7925,-4.8257 
>> -5.5993,-9.6453 -8.3856,-14.4751 2.6221,1.1736 5.2217,2.3923 
>> 7.8398,3.5721 0,-10.8825 -0.035,-1000.84096 -0.031,-1011.72348 
>> 0.053,-0.30366 -0.2175,-0.50268 -0.3652,-0.72837 l 1.5347,0.39394 z"
>> +       id="path381056"
>> +       sodipodi:nodetypes="cccccccccc"
>> +       style="stroke-width:0.205176"
>> +       inkscape:transform-center-x="-325.50819"
>> +       inkscape:transform-center-y="-121.97185" />
>> +    <rect
>> +       
>> style="fill:#000000;fill-opacity:0;stroke:#000000;stroke-opacity:1"
>> +       id="rect1131"
>> +       width="239.47592"
>> +       height="1015.9909"
>> +       x="298.65631"
>> +       y="82.399658" />
>> +    <rect
>> +       
>> style="fill:#000000;fill-opacity:0;stroke:#000000;stroke-width:1.27861;stroke-opacity:1" 
>>
>> +       id="rect1133"
>> +       width="340.44653"
>> +       height="525.77448"
>> +       x="298.79562"
>> +       y="1142.5299" />
>> +    <rect
>> +       
>> style="fill:#000000;fill-opacity:0;stroke:#000000;stroke-opacity:1"
>> +       id="rect1237"
>> +       width="284.00113"
>> +       height="945.41412"
>> +       x="827.75012"
>> +       y="82.880798"
>> +       inkscape:connector-avoid="true" />
>> +    <rect
>> +       
>> style="fill:#000000;fill-opacity:0;stroke:#000000;stroke-opacity:1"
>> +       id="rect1239"
>> +       width="239.37569"
>> +       height="179.03308"
>> +       x="1356.9507"
>> +       y="98.758331" />
>> +    <rect
>> +       
>> style="fill:#000000;fill-opacity:0;stroke:#000000;stroke-width:1.00744;stroke-opacity:1" 
>>
>> +       id="rect1241"
>> +       width="239.4184"
>> +       height="713.64905"
>> +       x="1356.9543"
>> +       y="307.7951"
>> +       inkscape:connector-avoid="true" />
>> +    <rect
>> +       
>> style="fill:#000000;fill-opacity:0;stroke:#000000;stroke-opacity:1"
>> +       id="rect1345"
>> +       width="330.32059"
>> +       height="409.44757"
>> +       x="1363.8723"
>> +       y="1147.7572" />
>> +    <rect
>> +       
>> style="fill:#000000;fill-opacity:0;stroke:#000000;stroke-opacity:1"
>> +       id="rect1347"
>> +       width="369.8941"
>> +       height="682.32245"
>> +       x="825.72528"
>> +       y="1146.6448"
>> +       inkscape:connector-avoid="true" />
>> +    <rect
>> +       
>> style="fill:#f9f7ed;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1349"
>> +       width="163.95746"
>> +       height="40.144867"
>> +       x="1389.9988"
>> +       y="190.80583" />
>> +    <rect
>> +       
>> style="fill:#000000;fill-opacity:0;stroke:#000000;stroke-width:0.964132;stroke-opacity:1" 
>>
>> +       id="rect1619"
>> +       width="271.99091"
>> +       height="42.038273"
>> +       x="1393.981"
>> +       y="1197.161"
>> +       inkscape:connector-avoid="true" />
>> +    <path
>> +       d="m 1469.3028,1238.8328 c 0.025,10.9789 0.01,175.0378 
>> 0.049,186.0188 2.5462,-1.1592 5.0637,-2.3779 7.6202,-3.5187 
>> -2.7411,4.8298 -5.4987,9.6453 -8.2624,14.4607 -2.7925,-4.8257 
>> -5.5993,-9.6453 -8.3856,-14.4751 2.6221,1.1736 5.2217,2.3923 
>> 7.8398,3.5721 0,-10.8825 -0.035,-174.8409 -0.031,-185.7234 
>> 0.053,-0.3037 -0.2175,-0.5027 -0.3652,-0.7284 l 1.5347,0.394 z"
>> +       id="path106-1"
>> +       sodipodi:nodetypes="cccccccccc"
>> +       style="stroke-width:0.205176"
>> +       inkscape:transform-center-x="-325.50819"
>> +       inkscape:transform-center-y="-121.97185" />
>> +    <path
>> +       d="m 407.4759,1238.4728 c 0.025,10.9789 0.01,291.0378 
>> 0.049,302.0188 2.5462,-1.1592 5.0637,-2.3779 7.6202,-3.5187 
>> -2.7411,4.8298 -5.4987,9.6453 -8.2624,14.4607 -2.7925,-4.8257 
>> -5.5993,-9.6453 -8.3856,-14.4751 2.6221,1.1736 5.2217,2.3923 
>> 7.8398,3.5721 0,-10.8825 -0.035,-290.8409 -0.031,-301.7234 
>> 0.053,-0.3037 -0.2175,-0.5027 -0.3652,-0.7284 l 1.5347,0.394 z"
>> +       id="path106-1-7"
>> +       sodipodi:nodetypes="cccccccccc"
>> +       style="stroke-width:0.205176"
>> +       inkscape:transform-center-x="-325.50819"
>> +       inkscape:transform-center-y="-121.97185" />
>> +    <rect
>> +       
>> style="fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1623"
>> +       width="137.32646"
>> +       height="41.782684"
>> +       x="1396.3848"
>> +       y="1268.2837"
>> +       inkscape:connector-avoid="true" />
>> +    <rect
>> +       
>> style="fill:#fad7ac;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1705"
>> +       width="137.32646"
>> +       height="41.782684"
>> +       x="1396.3848"
>> +       y="1348.2837" />
>> +    <rect
>> +       
>> style="fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1707"
>> +       width="137.32646"
>> +       height="41.782684"
>> +       x="1396.3848"
>> +       y="1432.2837" />
>> +    <rect
>> +       
>> style="fill:#f9f7ed;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1731"
>> +       width="222.34483"
>> +       height="44.64616"
>> +       x="867.36292"
>> +       y="190.42665"
>> +       inkscape:connector-avoid="true" />
>> +    <rect
>> +       
>> style="fill:#f9f7ed;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1813"
>> +       width="222.34483"
>> +       height="44.64616"
>> +       x="867.36292"
>> +       y="254.42664"
>> +       inkscape:connector-avoid="true" />
>> +    <rect
>> +       
>> style="fill:#f9f7ed;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1815"
>> +       width="222.34483"
>> +       height="44.64616"
>> +       x="867.36292"
>> +       y="318.42664"
>> +       inkscape:connector-avoid="true" />
>> +    <rect
>> +       
>> style="fill:#fad7ac;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1817"
>> +       width="222.34483"
>> +       height="44.64616"
>> +       x="867.36292"
>> +       y="412.42664"
>> +       inkscape:connector-avoid="true" />
>> +    <rect
>> +       
>> style="fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1819"
>> +       width="222.34483"
>> +       height="44.64616"
>> +       x="867.36292"
>> +       y="560.42664" />
>> +    <rect
>> +       
>> style="fill:#e6e6e6;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1821"
>> +       width="222.34483"
>> +       height="44.64616"
>> +       x="867.36292"
>> +       y="674.42664"
>> +       inkscape:connector-avoid="true" />
>> +    <rect
>> +       
>> style="fill:#fad7ac;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1823"
>> +       width="222.34483"
>> +       height="44.64616"
>> +       x="867.36292"
>> +       y="744.42664"
>> +       inkscape:connector-avoid="true" />
>> +    <rect
>> +       
>> style="fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1825"
>> +       width="222.34483"
>> +       height="44.64616"
>> +       x="867.36292"
>> +       y="820.42664"
>> +       inkscape:connector-avoid="true" />
>> +    <rect
>> +       
>> style="fill:#d0cee2;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1827"
>> +       width="222.34483"
>> +       height="44.64616"
>> +       x="867.36292"
>> +       y="890.42664"
>> +       inkscape:connector-avoid="true" />
>> +    <rect
>> +       
>> style="fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1829"
>> +       width="222.34483"
>> +       height="44.64616"
>> +       x="867.36292"
>> +       y="956.42664"
>> +       inkscape:connector-avoid="true" />
>> +    <rect
>> +       
>> style="fill:#fad7ac;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1831"
>> +       width="222.34483"
>> +       height="44.64616"
>> +       x="867.36292"
>> +       y="1256.4268" />
>> +    <rect
>> +       
>> style="fill:#d0cee2;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1833"
>> +       width="222.34483"
>> +       height="44.64616"
>> +       x="867.36292"
>> +       y="1402.4268" />
>> +    <rect
>> +       
>> style="fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1915"
>> +       width="222.34483"
>> +       height="44.64616"
>> +       x="867.36292"
>> +       y="1330.4268"
>> +       inkscape:connector-avoid="true" />
>> +    <rect
>> +       
>> style="fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1917"
>> +       width="222.34483"
>> +       height="44.64616"
>> +       x="867.36292"
>> +       y="1478.4268" />
>> +    <rect
>> +       
>> style="fill:#fad7ac;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1919"
>> +       width="222.34483"
>> +       height="44.64616"
>> +       x="867.36292"
>> +       y="1548.4268" />
>> +    <rect
>> +       
>> style="fill:#eeeeee;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1921"
>> +       width="222.34483"
>> +       height="44.64616"
>> +       x="867.36292"
>> +       y="1614.4268" />
>> +    <rect
>> +       
>> style="fill:#eeeeee;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1923"
>> +       width="222.34483"
>> +       height="44.64616"
>> +       x="867.36292"
>> +       y="1686.4268" />
>> +    <rect
>> +       
>> style="fill:#eeeeee;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1925"
>> +       width="222.34483"
>> +       height="44.64616"
>> +       x="867.36292"
>> +       y="1754.4268" />
>> +    <rect
>> +       
>> style="fill:#f9f7ed;fill-opacity:1;stroke:#000000;stroke-width:0.872749;stroke-opacity:1" 
>>
>> +       id="rect1925-3"
>> +       width="169.23357"
>> +       height="44.678963"
>> +       x="325.21747"
>> +       y="134.37756" />
>> +    <rect
>> +       
>> style="fill:#fad7ac;fill-opacity:1;stroke:#000000;stroke-width:0.872749;stroke-opacity:1" 
>>
>> +       id="rect1954"
>> +       width="169.23357"
>> +       height="44.678963"
>> +       x="325.21747"
>> +       y="276.37756"
>> +       inkscape:connector-avoid="true" />
>> +    <rect
>> +       
>> style="fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-width:0.87333333;stroke-opacity:1;stroke-miterlimit:4;stroke-dasharray:none" 
>>
>> +       id="rect1956"
>> +       width="168.66573"
>> +       height="122.14091"
>> +       x="325.50134"
>> +       y="358.6615"
>> +       inkscape:connector-avoid="true" />
>> +    <rect
>> +       
>> style="fill:#e6e6e6;fill-opacity:1;stroke:#000000;stroke-width:0.872749;stroke-opacity:1" 
>>
>> +       id="rect1958"
>> +       width="169.23357"
>> +       height="44.678963"
>> +       x="325.21747"
>> +       y="672.37756" />
>> +    <rect
>> +       
>> style="fill:#fad7ac;fill-opacity:1;stroke:#000000;stroke-width:0.872749;stroke-opacity:1" 
>>
>> +       id="rect1960"
>> +       width="169.23357"
>> +       height="44.678963"
>> +       x="325.21747"
>> +       y="744.37756" />
>> +    <rect
>> +       
>> style="fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-width:0.965912;stroke-opacity:1" 
>>
>> +       id="rect1962"
>> +       width="169.14041"
>> +       height="54.756817"
>> +       x="325.26404"
>> +       y="814.42413"
>> +       inkscape:connector-avoid="true" />
>> +    <rect
>> +       
>> style="fill:#d0cee2;fill-opacity:1;stroke:#000000;stroke-width:0.965912;stroke-opacity:1" 
>>
>> +       id="rect1964"
>> +       width="169.14041"
>> +       height="54.756817"
>> +       x="325.26404"
>> +       y="886.42413"
>> +       inkscape:connector-avoid="true" />
>> +    <rect
>> +       
>> style="fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-width:0.965912;stroke-opacity:1" 
>>
>> +       id="rect1966"
>> +       width="169.14041"
>> +       height="54.756817"
>> +       x="325.26404"
>> +       y="952.42413"
>> +       inkscape:connector-avoid="true" />
>> +    <rect
>> +       
>> style="fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-width:1.02091;stroke-opacity:1" 
>>
>> +       id="rect2428"
>> +       width="169.0854"
>> +       height="61.19017"
>> +       x="325.29156"
>> +       y="1468.4518" />
>> +    <rect
>> +       
>> style="fill:#fad7ac;fill-opacity:1;stroke:#000000;stroke-width:0.839627;stroke-opacity:1" 
>>
>> +       id="rect2430"
>> +       width="169.26669"
>> +       height="41.344128"
>> +       x="325.20093"
>> +       y="1550.3611" />
>> +    <rect
>> +       
>> style="fill:#000000;fill-opacity:0;stroke:#000000;stroke-width:1.13491;stroke-opacity:1" 
>>
>> +       id="rect2432"
>> +       width="287.86237"
>> +       height="44.416805"
>> +       x="325.34854"
>> +       y="1194.5088" />
>> +    <rect
>> +       
>> style="fill:#000000;fill-opacity:0;stroke:#000000;stroke-width:1.13102;stroke-opacity:1" 
>>
>> +       id="rect2434"
>> +       width="285.86655"
>> +       height="44.4207"
>> +       x="867.34656"
>> +       y="1194.5068" />
>> +    <path
>> +       
>> style="fill:none;stroke:#000000;stroke-width:2.66666675;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4;stroke-dasharray:8.00000024, 
>> 8.00000024;stroke-dashoffset:0"
>> +       d="m 867.36292,235.07281 v 0"
>> +       id="path2509" />
>> +    <path
>> +       
>> style="fill:none;stroke:#000000;stroke-width:2.66666675;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4;stroke-dasharray:8.00000024, 
>> 8.00000024;stroke-dashoffset:0"
>> +       d="m 867.36292,235.07281 v 0"
>> +       id="path2511" />
>> +    <path
>> +       
>> style="fill:none;stroke:#000000;stroke-width:2.66666675;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4;stroke-dasharray:8.00000024, 
>> 8.00000024;stroke-dashoffset:0"
>> +       d="m 867.36292,235.07281 v 0"
>> +       id="path2513" />
>> +    <path
>> +       
>> style="fill:none;stroke:#000000;stroke-width:2.66666675;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4;stroke-dasharray:8.00000024, 
>> 8.00000024;stroke-dashoffset:0"
>> +       d="m 867.36292,235.07281 v 0"
>> +       id="path2515" />
>> +    <path
>> +       
>> style="fill:none;stroke:#000000;stroke-width:2.66666675;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4;stroke-dasharray:8.00000024, 
>> 8.00000024;stroke-dashoffset:0"
>> +       d="m 867.36292,235.07281 v 0"
>> +       id="path2517" />
>> +    <path
>> +       
>> style="fill:none;stroke:#000000;stroke-width:2.66666675;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4;stroke-dasharray:8.00000024, 
>> 8.00000024;stroke-dashoffset:0"
>> +       d="m 867.36292,235.07281 v 0"
>> +       id="path2519" />
>> +    <path
>> +       
>> style="fill:none;stroke:#000000;stroke-width:2.66666675;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4;stroke-dasharray:8.00000024, 
>> 8.00000024;stroke-dashoffset:0"
>> +       d="m 867.36292,235.07281 v 0"
>> +       id="path2521" />
>> +    <path
>> +       
>> style="fill:none;stroke:#000000;stroke-width:2.66666675;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4;stroke-dasharray:8.00000024, 
>> 8.00000024;stroke-dashoffset:0"
>> +       d="m 867.36292,235.07281 v 0"
>> +       id="path2523" />
>> +    <path
>> +       
>> style="fill:none;stroke:#000000;stroke-width:2.66666675;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4;stroke-dasharray:8.00000024, 
>> 8.00000024;stroke-dashoffset:0"
>> +       d="m 867.36292,235.07281 v 0"
>> +       id="path2525" />
>> +    <path
>> +       
>> style="fill:none;stroke:#000000;stroke-width:2.66666675;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4;stroke-dasharray:8.00000024, 
>> 8.00000024;stroke-dashoffset:0"
>> +       d="m 867.36292,235.07281 v 0"
>> +       id="path2527" />
>> +    <path
>> +       
>> style="fill:none;stroke:#000000;stroke-width:2.66666675;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4;stroke-dasharray:8.00000024, 
>> 8.00000024;stroke-dashoffset:0"
>> +       d="m 867.36292,235.07281 v 0"
>> +       id="path2529" />
>> +    <path
>> +       
>> style="fill:none;stroke:#000000;stroke-width:2.66666675;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4;stroke-dasharray:8.00000024, 
>> 8.00000024;stroke-dashoffset:0"
>> +       d="m 867.36292,235.07281 v 0"
>> +       id="path2531" />
>> +    <path
>> +       
>> style="fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:6, 
>> 6;stroke-dashoffset:0;stroke-opacity:1"
>> +       d="m 442.80064,179.02883 0.91401,36.01283 423.64827,-2.29193"
>> +       id="path6876"
>> +       inkscape:connector-type="orthogonal"
>> +       inkscape:connector-curvature="0"
>> +       inkscape:connection-start="#rect1925-3"
>> +       inkscape:connection-end="#rect1731"
>> +       sodipodi:nodetypes="ccc" />
>> +    <path
>> +       
>> style="display:inline;fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:6, 
>> 6;stroke-dashoffset:0;stroke-opacity:1"
>> +       d="m 494.45103,156.71704 205.18886,-0.43622 0.59548,162.1112 
>> 167.12755,0.0346"
>> +       id="path6878"
>> +       inkscape:connector-type="orthogonal"
>> +       inkscape:connector-curvature="0"
>> +       inkscape:connection-start="#rect1925-3"
>> +       sodipodi:nodetypes="cccc" />
>> +    <path
>> +       
>> style="fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:6, 
>> 6;stroke-dashoffset:0;stroke-opacity:1"
>> +       d="m 447.83425,321.05653 v 19.69319 h 419.52867"
>> +       id="path7294"
>> +       inkscape:connector-type="orthogonal"
>> +       inkscape:connector-curvature="0"
>> +       inkscape:connection-start="#rect1954"
>> +       inkscape:connection-end="#rect1815"
>> +       sodipodi:nodetypes="ccc" />
>> +    <path
>> +       
>> style="fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:6, 
>> 6;stroke-dashoffset:0;stroke-opacity:1"
>> +       d="M 494.45103,298.71704 H 659.10058 V 434.74972 H 867.36292"
>> +       id="path7296"
>> +       inkscape:connector-type="orthogonal"
>> +       inkscape:connector-curvature="0"
>> +       inkscape:connection-end="#rect1817"
>> +       inkscape:connection-start="#rect1954"
>> +       sodipodi:nodetypes="cccc" />
>> +    <path
>> +       
>> style="display:inline;fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:6, 
>> 6;stroke-dashoffset:0;stroke-opacity:1"
>> +       d="m 867.36292,560.42664 -422.77356,1.33638 0.45008,-79.26417"
>> +       id="path7720"
>> +       inkscape:connector-type="orthogonal"
>> +       inkscape:connector-curvature="0"
>> +       sodipodi:nodetypes="ccc" />
>> +    <path
>> +       
>> style="fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:6, 
>> 6;stroke-dashoffset:0;stroke-opacity:1"
>> +       d="M 494.45103,696.74972 H 867.36292"
>> +       id="path7726"
>> +       inkscape:connector-type="orthogonal"
>> +       inkscape:connector-curvature="0"
>> +       inkscape:connection-start="#rect1958"
>> +       inkscape:connection-end="#rect1821" />
>> +    <path
>> +       
>> style="fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:6, 
>> 6;stroke-dashoffset:0;stroke-opacity:1"
>> +       d="M 867.36292,766.74972 H 494.45103"
>> +       id="path7728"
>> +       inkscape:connector-type="orthogonal"
>> +       inkscape:connector-curvature="0"
>> +       inkscape:connection-start="#rect1823"
>> +       inkscape:connection-end="#rect1960" />
>> +    <path
>> +       
>> style="display:inline;fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:6, 
>> 6;stroke-dashoffset:0;stroke-opacity:1"
>> +       d="M 494.45105,789.05652 H 657.82418 V 1278.7498 H 867.36292"
>> +       id="path7730"
>> +       inkscape:connector-type="orthogonal"
>> +       inkscape:connector-curvature="0"
>> +       inkscape:connection-end="#rect1831"
>> +       sodipodi:nodetypes="cccc" />
>> +    <path
>> +       
>> style="fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:6, 
>> 6;stroke-dashoffset:0;stroke-opacity:1"
>> +       d="m 494.40445,841.80254 h 167.41973 v 0.94718 h 205.53874"
>> +       id="path8140"
>> +       inkscape:connector-type="orthogonal"
>> +       inkscape:connector-curvature="0"
>> +       inkscape:connection-start="#rect1962"
>> +       inkscape:connection-end="#rect1825" />
>> +    <path
>> +       
>> style="fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:6, 
>> 6;stroke-dashoffset:0;stroke-opacity:1"
>> +       d="m 494.40445,913.80254 h 167.41973 v -1.05282 h 205.53874"
>> +       id="path8142"
>> +       inkscape:connector-type="orthogonal"
>> +       inkscape:connector-curvature="0"
>> +       inkscape:connection-start="#rect1964"
>> +       inkscape:connection-end="#rect1827" />
>> +    <path
>> +       
>> style="fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:6, 
>> 6;stroke-dashoffset:0;stroke-opacity:1"
>> +       d="m 494.40445,979.80254 h 167.41973 v -1.05282 h 205.53874"
>> +       id="path8144"
>> +       inkscape:connector-type="orthogonal"
>> +       inkscape:connector-curvature="0"
>> +       inkscape:connection-start="#rect1966"
>> +       inkscape:connection-end="#rect1829" />
>> +    <path
>> +       
>> style="fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:6, 
>> 6;stroke-dashoffset:0;stroke-opacity:1"
>> +       d="M 494.37697,1500.7498 H 867.36292"
>> +       id="path8150"
>> +       inkscape:connector-type="orthogonal"
>> +       inkscape:connector-curvature="0"
>> +       inkscape:connection-start="#rect2428"
>> +       inkscape:connection-end="#rect1917" />
>> +    <path
>> +       
>> style="fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:6, 
>> 6;stroke-dashoffset:0;stroke-opacity:1"
>> +       d="m 494.46762,1570.7498 h 372.8953"
>> +       id="path8152"
>> +       inkscape:connector-type="orthogonal"
>> +       inkscape:connector-curvature="0"
>> +       inkscape:connection-start="#rect2430"
>> +       inkscape:connection-end="#rect1919" />
>> +    <path
>> +       
>> style="fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:6, 
>> 6;stroke-dashoffset:0;stroke-opacity:1"
>> +       d="M 1396.3848,1289.175 H 1288.1445 V 582.74972 h -198.4368"
>> +       id="path8154"
>> +       inkscape:connector-type="orthogonal"
>> +       inkscape:connector-curvature="0"
>> +       inkscape:connection-start="#rect1623"
>> +       inkscape:connection-end="#rect1819" />
>> +    <path
>> +       
>> style="fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:6, 
>> 6;stroke-dashoffset:0;stroke-opacity:1"
>> +       d="m 1396.3848,1369.175 -159.2837,-1.364 0.5816,-88.2579 
>> -147.975,-0.8033"
>> +       id="path8462"
>> +       inkscape:connector-type="orthogonal"
>> +       inkscape:connector-curvature="0"
>> +       inkscape:connection-start="#rect1705"
>> +       inkscape:connection-end="#rect1831"
>> +       sodipodi:nodetypes="cccc" />
>> +    <path
>> +       
>> style="fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:6, 
>> 6;stroke-dashoffset:0;stroke-opacity:1"
>> +       d="m 1089.7077,1500.7498 h 375.3403 v -26.6834"
>> +       id="path8668"
>> +       inkscape:connector-type="orthogonal"
>> +       inkscape:connector-curvature="0"
>> +       inkscape:connection-start="#rect1917"
>> +       inkscape:connection-end="#rect1707" />
>> +    <path
>> +       
>> style="fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:6, 
>> 6;stroke-dashoffset:0;stroke-opacity:1"
>> +       d="M 1389.9988,212.74973 H 1089.7077"
>> +       id="path8672"
>> +       inkscape:connector-type="orthogonal"
>> +       inkscape:connector-curvature="0"
>> +       inkscape:connection-start="#rect1349"
>> +       inkscape:connection-end="#rect1731" />
>> +    <path
>> +       
>> style="display:inline;fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:6, 
>> 6;stroke-dashoffset:0;stroke-opacity:1"
>> +       d="M 1389.9988,230.9507 H 1223.331 v 109.79902 h -133.6233"
>> +       id="path8674"
>> +       inkscape:connector-type="orthogonal"
>> +       inkscape:connector-curvature="0"
>> +       inkscape:connection-end="#rect1815"
>> +       sodipodi:nodetypes="cccc" />
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:40px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="58.63356"
>> +       y="69.574417"
>> +       id="text28675"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan28673"
>> +         x="58.63356"
>> +         y="69.574417" /></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="56.388252"
>> +       y="221.86568"
>> +       id="text31913"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan31911"
>> +         x="56.388252"
>> +         y="221.86568">Matrix</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="53.441296"
>> +       y="300.866"
>> +       id="text38843"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan38841"
>> +         x="53.441296"
>> +         y="300.866">1D LUT</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="53.441296"
>> +       y="378.866"
>> +       id="text41049"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan41047"
>> +         x="53.441296"
>> +         y="378.866">3D LUT</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="40.831493"
>> +       y="460.87411"
>> +       id="text45037"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan45035"
>> +         x="40.831493"
>> +         y="460.87411"
>> +         style="font-size:18.6667px">Unpacking</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="62.130371"
>> +       y="540.68872"
>> +       id="text49945"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan49943"
>> +         x="62.130371"
>> +         y="540.68872"
>> +         style="font-size:18.6667px">Other</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="1423.2806"
>> +       y="128.08769"
>> +       id="text55719"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan55717"
>> +         x="1423.2806"
>> +         y="128.08769"
>> +         style="font-size:18.6667px">drm_framebuffer</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="1439.9988"
>> +       y="218.74973"
>> +       id="text62479"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan62477"
>> +         x="1439.9988"
>> +         y="218.74973"
>> +         style="font-size:18.6667px">format</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="1475.2806"
>> +       y="340.08771"
>> +       id="text64465"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan64463"
>> +         x="1475.2806"
>> +         y="340.08771"
>> +         style="font-size:18.6667px">drm_plane</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="1589.2806"
>> +       y="1178.0876"
>> +       id="text64469"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan64467"
>> +         x="1589.2806"
>> +         y="1178.0876"
>> +         style="font-size:18.6667px">drm_crtc</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="872.23993"
>> +       y="1172.4491"
>> +       id="text64469-9"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan64467-2"
>> +         x="872.23993"
>> +         y="1172.4491"
>> +         style="font-size:18.6667px">Stream</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="328.26071"
>> +       y="1175.6371"
>> +       id="text64469-9-2"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan64467-2-8"
>> +         x="328.26071"
>> +         y="1175.6371"
>> +         style="font-size:18.6667px">MPC</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="330.14737"
>> +       y="114.41869"
>> +       id="text64469-9-9"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan64467-2-7"
>> +         x="330.14737"
>> +         y="114.41869"
>> +         style="font-size:18.6667px">DPP</tspan></text>
>> +    <path
>> +       d="m 1488.3608,401.47792 c 0.025,10.97895 0.01,773.03788 
>> 0.049,784.01888 2.5462,-1.1592 5.0637,-2.3779 7.6202,-3.5187 
>> -2.7411,4.8298 -5.4987,9.6453 -8.2624,14.4607 -2.7925,-4.8257 
>> -5.5993,-9.6453 -8.3856,-14.4751 2.6221,1.1736 5.2217,2.3923 
>> 7.8398,3.5721 0,-10.8825 -0.035,-772.84093 -0.031,-783.72345 
>> 0.053,-0.30366 -0.2175,-0.50268 -0.3652,-0.72837 l 1.5347,0.39394 z"
>> +       id="path106"
>> +       sodipodi:nodetypes="cccccccccc"
>> +       style="stroke-width:0.205176"
>> +       inkscape:transform-center-x="-325.50819"
>> +       inkscape:transform-center-y="-121.97185" />
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="1495.9988"
>> +       y="1224.7498"
>> +       id="text78849"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan78847"
>> +         x="1495.9988"
>> +         y="1224.7498"
>> +         style="font-size:18.6667px">Blender</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="1417.9988"
>> +       y="1294.7498"
>> +       id="text78853"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan78851"
>> +         x="1417.9988"
>> +         y="1294.7498"
>> +         style="font-size:18.6667px">Degamma</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="1451.9988"
>> +       y="1376.7498"
>> +       id="text78857"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan78855"
>> +         x="1451.9988"
>> +         y="1376.7498"
>> +         style="font-size:18.6667px">CTM</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="1427.9988"
>> +       y="1458.7498"
>> +       id="text78861"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan78859"
>> +         x="1427.9988"
>> +         y="1458.7498"
>> +         style="font-size:18.6667px">Gamma</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="949.99878"
>> +       y="218.74973"
>> +       id="text104653"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan104651"
>> +         x="949.99878"
>> +         y="218.74973"
>> +         style="font-size:18.6667px">format</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="911.99878"
>> +       y="284.74973"
>> +       id="text104657"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan104655"
>> +         x="911.99878"
>> +         y="284.74973"
>> +         style="font-size:18.6667px">bias_and_scale</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="887.99878"
>> +       y="346.74973"
>> +       id="text104661"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan104659"
>> +         x="887.99878"
>> +         y="346.74973"
>> +         style="font-size:18.6667px">color space matrix</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="871.99878"
>> +       y="442.74973"
>> +       id="text104665"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan104663"
>> +         x="871.99878"
>> +         y="442.74973"
>> +         
>> style="font-size:18.6667px">input_csc_color_matrix</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="905.99878"
>> +       y="586.74976"
>> +       id="text125075"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan125073"
>> +         x="905.99878"
>> +         y="586.74976"
>> +         style="font-size:18.6667px">in_transfer_func</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="945.0083"
>> +       y="702.85938"
>> +       id="text117309"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan117307"
>> +         x="945.0083"
>> +         y="702.85938"
>> +         style="font-size:18.6667px">hdr_mult</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="874.5556"
>> +       y="773.42615"
>> +       id="text117309-6"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan117307-7"
>> +         x="874.5556"
>> +         y="773.42615"
>> +         style="font-size:18.6667px">gamut_remap_matrix</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="913.72528"
>> +       y="846.55896"
>> +       id="text117309-5"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan117307-3"
>> +         x="913.72528"
>> +         y="846.55896"
>> +         style="font-size:18.6667px">in_shaper_func</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="937.72528"
>> +       y="918.25787"
>> +       id="text117309-56"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan117307-2"
>> +         x="937.72528"
>> +         y="918.25787"
>> +         style="font-size:18.6667px">lut3d_func</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="945.9895"
>> +       y="986.10767"
>> +       id="text117309-9"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan117307-1"
>> +         x="945.9895"
>> +         y="986.10767"
>> +         style="font-size:18.6667px">blend_tf</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="975.91803"
>> +       y="1224.5564"
>> +       id="text137434"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan137432"
>> +         x="975.91803"
>> +         y="1224.5564"
>> +         style="font-size:18.6667px">Blender</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="879.31372"
>> +       y="1283.4249"
>> +       id="text137434-2"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan137432-7"
>> +         x="879.31372"
>> +         y="1283.4249"
>> +         style="font-size:18.6667px">gamut_remap_matrix</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="925.31372"
>> +       y="1359.2747"
>> +       id="text137434-0"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan137432-9"
>> +         x="925.31372"
>> +         y="1359.2747"
>> +         style="font-size:18.6667px">func_shaper</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="930.33252"
>> +       y="1430.2566"
>> +       id="text137434-3"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan137432-6"
>> +         x="930.33252"
>> +         y="1430.2566"
>> +         style="font-size:18.6667px">lut3d_func</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="900.18158"
>> +       y="1504.6725"
>> +       id="text137434-06"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan137432-2"
>> +         x="900.18158"
>> +         y="1504.6725"
>> +         style="font-size:18.6667px">out_transfer_func</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="904.0307"
>> +       y="1575.8053"
>> +       id="text137434-6"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan137432-1"
>> +         x="904.0307"
>> +         y="1575.8053"
>> +         style="font-size:18.6667px">csc_color_matrix</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="903.16278"
>> +       y="1642.1078"
>> +       id="text137434-8"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan137432-79"
>> +         x="903.16278"
>> +         y="1642.1078"
>> +         style="font-size:18.6667px">bit_depth_param</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="939.31372"
>> +       y="1713.8068"
>> +       id="text137434-20"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan137432-23"
>> +         x="939.31372"
>> +         y="1713.8068"
>> +         style="font-size:18.6667px">clamping</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="894.0307"
>> +       y="1782.5244"
>> +       id="text137434-7"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan137432-5"
>> +         x="894.0307"
>> +         y="1782.5244"
>> +         style="font-size:18.6667px">output_color_space</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="869.63062"
>> +       y="117.7968"
>> +       id="text176429"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan176427"
>> +         x="869.63062"
>> +         y="117.7968"
>> +         style="font-size:18.6667px">Plane</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="27.605465"
>> +       y="162.20587"
>> +       id="text176429-2"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan176427-0"
>> +         x="27.605465"
>> +         y="162.20587"
>> +         style="font-size:18.6667px">Legend</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="298.63959"
>> +       y="59.293999"
>> +       id="text176429-9"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan176427-2"
>> +         x="298.63959"
>> +         y="59.293999"
>> +         style="font-size:18.6667px">DCN 2.0</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="826.65735"
>> +       y="59.458061"
>> +       id="text176429-66"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan176427-4"
>> +         x="826.65735"
>> +         y="59.458061"
>> +         style="font-size:18.6667px">DC Interface</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="1362.9948"
>> +       y="59.458061"
>> +       id="text176429-95"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan176427-04"
>> +         x="1362.9948"
>> +         y="59.458061"
>> +         style="font-size:18.6667px">DRM Interface</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:40px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="867.34656"
>> +       y="1194.5068"
>> +       id="text184728"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan184726"
>> +         x="867.34656"
>> +         y="1194.5068" /></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="389.01593"
>> +       y="159.8909"
>> +       id="text64469-9-3"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan64467-2-6"
>> +         x="389.01593"
>> +         y="159.8909"
>> +         style="font-size:18.6667px">CNVC</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="365.88379"
>> +       y="303.59048"
>> +       id="text64469-9-1"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan64467-2-2"
>> +         x="365.88379"
>> +         y="303.59048"
>> +         style="font-size:18.6667px">Input CSC</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="409.06488"
>> +       y="404.95001"
>> +       id="text64469-9-93"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan64467-2-1"
>> +         x="409.06488"
>> +         y="404.95001"
>> +         
>> style="font-size:18.6667px;text-align:center;text-anchor:middle">DeGamma</tspan><tspan 
>>
>> +         sodipodi:role="line"
>> +         x="409.06488"
>> +         y="428.28339"
>> +         
>> style="font-size:18.6667px;text-align:center;text-anchor:middle"
>> +         id="tspan233797">RAM and ROM</tspan><tspan
>> +         sodipodi:role="line"
>> +         x="409.06488"
>> +         y="451.61676"
>> +         
>> style="font-size:10.6667px;text-align:center;text-anchor:middle"
>> +         id="tspan242597">(sRGB, BT2020</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="351.16684"
>> +       y="700.34918"
>> +       id="text64469-9-0"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan64467-2-3"
>> +         x="351.16684"
>> +         y="700.34918"
>> +         style="font-size:18.6667px">HDR Multiply</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="345.16684"
>> +       y="771.33112"
>> +       id="text64469-9-6"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan64467-2-10"
>> +         x="345.16684"
>> +         y="771.33112"
>> +         style="font-size:18.6667px">Gamut Remap</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="412.5184"
>> +       y="836.04877"
>> +       id="text64469-9-63"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan64467-2-20"
>> +         x="412.5184"
>> +         y="836.04877"
>> +         
>> style="font-size:18.6667px;text-align:center;text-anchor:middle">Shaper LUT</tspan><tspan 
>>
>> +         sodipodi:role="line"
>> +         x="412.5184"
>> +         y="859.38214"
>> +         
>> style="font-size:18.6667px;text-align:center;text-anchor:middle"
>> +         id="tspan222533">RAM</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="413.54086"
>> +       y="908.61554"
>> +       id="text64469-9-61"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan64467-2-55"
>> +         x="413.54086"
>> +         y="908.61554"
>> +         
>> style="font-size:18.6667px;text-align:center;text-anchor:middle">3D 
>> LUT</tspan><tspan
>> +         sodipodi:role="line"
>> +         x="413.54086"
>> +         y="931.94891"
>> +         
>> style="font-size:18.6667px;text-align:center;text-anchor:middle"
>> +         id="tspan221121">RAM</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="344.0347"
>> +       y="985.33319"
>> +       id="text64469-9-47"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan64467-2-65"
>> +         x="344.0347"
>> +         y="985.33319"
>> +         style="font-size:18.6667px">Blend Gamma</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="433.84625"
>> +       y="1223.411"
>> +       id="text64469-9-69"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan64467-2-37"
>> +         x="433.84625"
>> +         y="1223.411"
>> +         style="font-size:18.6667px">Blender</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="408.64996"
>> +       y="1492.8102"
>> +       id="text64469-9-8"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan64467-2-84"
>> +         x="408.64996"
>> +         y="1492.8102"
>> +         
>> style="font-size:18.6667px;text-align:center;text-anchor:middle">Gamma</tspan><tspan 
>>
>> +         sodipodi:role="line"
>> +         x="408.64996"
>> +         y="1516.1436"
>> +         
>> style="font-size:18.6667px;text-align:center;text-anchor:middle"
>> +         id="tspan197733">RAM</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="385.46863"
>> +       y="1575.2261"
>> +       id="text64469-9-31"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan64467-2-49"
>> +         x="385.46863"
>> +         y="1575.2261"
>> +         style="font-size:18.6667px">OCSC</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:40px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="1356.5106"
>> +       y="53.140579"
>> +       id="text273287"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan273285"
>> +         x="1356.5106"
>> +         y="53.140579" /></text>
>> +    <rect
>> +       
>> style="fill:#f9f7ed;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1411"
>> +       width="177.28049"
>> +       height="38.940468"
>> +       x="1392.2576"
>> +       y="459.24118" />
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="1411.7203"
>> +       y="485.93231"
>> +       id="text78841"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan78839"
>> +         x="1411.7203"
>> +         y="485.93231"
>> +         style="font-size:18.6667px">color_encoding</tspan></text>
>> +    <rect
>> +       
>> style="fill:#f9f7ed;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1515"
>> +       width="175.11876"
>> +       height="43.239407"
>> +       x="1393.7493"
>> +       y="525.6983" />
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:17.3333px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="1399.212"
>> +       y="553.44904"
>> +       id="text78845"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan78843"
>> +         x="1399.212"
>> +         y="553.44904">pixel_blend_mode</tspan></text>
>> +    <rect
>> +       
>> style="fill:#f9f7ed;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect371322"
>> +       width="177.28049"
>> +       height="38.940468"
>> +       x="1391.6781"
>> +       y="385.61713" />
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="1427.5771"
>> +       y="409.29523"
>> +       id="text78837"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan78835"
>> +         x="1427.5771"
>> +         y="409.29523"
>> +         style="font-size:18.6667px">color_range</tspan></text>
>> +    <path
>> +       d="m 1469.6815,1334.9145 c 3.2597,-1.4841 6.4827,-3.0444 
>> 9.7556,-4.5049 -3.5093,6.1834 -7.0396,12.3483 -10.5778,18.5131 
>> -3.575,-6.178 -7.1683,-12.3481 -10.7354,-18.5314 3.3569,1.5025 
>> 6.685,3.0627 10.0367,4.5731 0,0 0,0 1.5209,-0.05 z"
>> +       id="path371636-7"
>> +       sodipodi:nodetypes="cccccc"
>> +       style="stroke-width:0.262672"
>> +       inkscape:transform-center-x="-416.72543"
>> +       inkscape:transform-center-y="-156.15191" />
>> +    <path
>> +       d="m 1467.8882,1256.0056 c 3.2597,-1.4841 6.4827,-3.0443 
>> 9.7556,-4.5048 -3.5093,6.1833 -7.0396,12.3482 -10.5778,18.5131 
>> -3.575,-6.178 -7.1683,-12.3482 -10.7354,-18.5315 3.3569,1.5025 
>> 6.685,3.0628 10.0367,4.5731 0,0 0,0 1.5209,-0.05 z"
>> +       id="path371636-7-2"
>> +       sodipodi:nodetypes="cccccc"
>> +       style="stroke-width:0.262672"
>> +       inkscape:transform-center-x="-416.72543"
>> +       inkscape:transform-center-y="-156.15191" />
>> +    <path
>> +       d="m 1487.6154,441.80981 c 3.2597,-1.48411 6.4827,-3.04435 
>> 9.7556,-4.50482 -3.5093,6.18331 -7.0396,12.34823 -10.5778,18.51307 
>> -3.575,-6.17798 -7.1683,-12.34815 -10.7354,-18.53146 3.3569,1.50251 
>> 6.685,3.06275 10.0367,4.57314 0,0 0,0 1.5209,-0.0499 z"
>> +       id="path371636-7-7"
>> +       sodipodi:nodetypes="cccccc"
>> +       style="stroke-width:0.262672"
>> +       inkscape:transform-center-x="-416.72543"
>> +       inkscape:transform-center-y="-156.15191" />
>> +    <path
>> +       d="m 1489.4088,515.3385 c 3.2597,-1.48411 6.4827,-3.04435 
>> 9.7556,-4.50482 -3.5093,6.18331 -7.0396,12.34823 -10.5778,18.51307 
>> -3.575,-6.17798 -7.1683,-12.34815 -10.7354,-18.53146 3.3569,1.50251 
>> 6.685,3.06275 10.0367,4.57314 0,0 0,0 1.5209,-0.0499 z"
>> +       id="path371636-7-22"
>> +       sodipodi:nodetypes="cccccc"
>> +       style="stroke-width:0.262672"
>> +       inkscape:transform-center-x="-416.72543"
>> +       inkscape:transform-center-y="-156.15191" />
>> +    <path
>> +       d="m 400.8254,264.26491 c 3.2597,-1.48411 6.4827,-3.04435 
>> 9.7556,-4.50482 -3.5093,6.18331 -7.0396,12.34823 -10.5778,18.51307 
>> -3.575,-6.17798 -7.1683,-12.34815 -10.7354,-18.53146 3.3569,1.50251 
>> 6.685,3.06275 10.0367,4.57314 0,0 0,0 1.5209,-0.0499 z"
>> +       id="path371636-7-6"
>> +       sodipodi:nodetypes="cccccc"
>> +       style="stroke-width:0.262672"
>> +       inkscape:transform-center-x="-416.72543"
>> +       inkscape:transform-center-y="-156.15191" />
>> +    <path
>> +       d="m 402.6188,346.76052 c 3.2597,-1.48411 6.4827,-3.04435 
>> 9.7556,-4.50482 -3.5093,6.18331 -7.0396,12.34823 -10.5778,18.51307 
>> -3.575,-6.17798 -7.1683,-12.34815 -10.7354,-18.53146 3.3569,1.50251 
>> 6.685,3.06275 10.0367,4.57314 0,0 0,0 1.5209,-0.0499 z"
>> +       id="path371636-7-1"
>> +       sodipodi:nodetypes="cccccc"
>> +       style="stroke-width:0.262672"
>> +       inkscape:transform-center-x="-416.72543"
>> +       inkscape:transform-center-y="-156.15191" />
>> +    <path
>> +       d="m 402.6188,658.80913 c 3.2597,-1.48411 6.4827,-3.04435 
>> 9.7556,-4.50482 -3.5093,6.18331 -7.0396,12.34823 -10.5778,18.51307 
>> -3.575,-6.17798 -7.1683,-12.34815 -10.7354,-18.53146 3.3569,1.50251 
>> 6.685,3.06275 10.0367,4.57314 0,0 0,0 1.5209,-0.0499 z"
>> +       id="path371636-7-5"
>> +       sodipodi:nodetypes="cccccc"
>> +       style="stroke-width:0.262672"
>> +       inkscape:transform-center-x="-416.72543"
>> +       inkscape:transform-center-y="-156.15191" />
>> +    <path
>> +       d="m 402.6188,732.33782 c 3.2597,-1.48411 6.4827,-3.04435 
>> 9.7556,-4.50482 -3.5093,6.18331 -7.0396,12.34823 -10.5778,18.51307 
>> -3.575,-6.17798 -7.1683,-12.34815 -10.7354,-18.53146 3.3569,1.50251 
>> 6.685,3.06275 10.0367,4.57314 0,0 0,0 1.5209,-0.0499 z"
>> +       id="path371636-7-9"
>> +       sodipodi:nodetypes="cccccc"
>> +       style="stroke-width:0.262672"
>> +       inkscape:transform-center-x="-416.72543"
>> +       inkscape:transform-center-y="-156.15191" />
>> +    <path
>> +       d="m 402.4121,800.48637 c 3.2597,-1.48411 6.4827,-3.04435 
>> 9.7556,-4.50482 -3.5093,6.18331 -7.0396,12.34823 -10.5778,18.51307 
>> -3.575,-6.17798 -7.1683,-12.34815 -10.7354,-18.53146 3.3569,1.50251 
>> 6.685,3.06275 10.0367,4.57314 0,0 0,0 1.5209,-0.0499 z"
>> +       id="path371636-7-4"
>> +       sodipodi:nodetypes="cccccc"
>> +       style="stroke-width:0.262672"
>> +       inkscape:transform-center-x="-416.72543"
>> +       inkscape:transform-center-y="-156.15191" />
>> +    <path
>> +       d="m 402.2055,875.80845 c 3.2597,-1.48411 6.4827,-3.04435 
>> 9.7556,-4.50482 -3.5093,6.18331 -7.0396,12.34823 -10.5778,18.51307 
>> -3.575,-6.17798 -7.1683,-12.34815 -10.7354,-18.53146 3.3569,1.50251 
>> 6.685,3.06275 10.0367,4.57314 0,0 0,0 1.5209,-0.0499 z"
>> +       id="path371636-7-90"
>> +       sodipodi:nodetypes="cccccc"
>> +       style="stroke-width:0.262672"
>> +       inkscape:transform-center-x="-416.72543"
>> +       inkscape:transform-center-y="-156.15191" />
>> +    <path
>> +       d="m 400.4121,942.16362 c 3.2597,-1.48411 6.4827,-3.04435 
>> 9.7556,-4.50482 -3.5093,6.18331 -7.0396,12.34823 -10.5778,18.51307 
>> -3.575,-6.17798 -7.1683,-12.34815 -10.7354,-18.53146 3.3569,1.50251 
>> 6.685,3.06275 10.0367,4.57314 0,0 0,0 1.5209,-0.0499 z"
>> +       id="path371636-7-91"
>> +       sodipodi:nodetypes="cccccc"
>> +       style="stroke-width:0.262672"
>> +       inkscape:transform-center-x="-416.72543"
>> +       inkscape:transform-center-y="-156.15191" />
>> +    <path
>> +       d="m 407.9989,1458.6579 c 3.2597,-1.4841 6.4827,-3.0444 
>> 9.7556,-4.5049 -3.5093,6.1834 -7.0396,12.3483 -10.5778,18.5131 
>> -3.575,-6.178 -7.1683,-12.3481 -10.7354,-18.5314 3.3569,1.5025 
>> 6.685,3.0627 10.0367,4.5731 0,0 0,0 1.5209,-0.05 z"
>> +       id="path371636-7-59"
>> +       sodipodi:nodetypes="cccccc"
>> +       style="stroke-width:0.262672"
>> +       inkscape:transform-center-x="-416.72543"
>> +       inkscape:transform-center-y="-156.15191" />
>> +  </g>
>> +</svg>
>> diff --git a/Documentation/gpu/amdgpu/display/dcn3_cm_drm_current.svg 
>> b/Documentation/gpu/amdgpu/display/dcn3_cm_drm_current.svg
>> new file mode 100644
>> index 000000000000..7299ee9b6d64
>> --- /dev/null
>> +++ b/Documentation/gpu/amdgpu/display/dcn3_cm_drm_current.svg
>> @@ -0,0 +1,1529 @@
>> +<?xml version="1.0" encoding="UTF-8" standalone="no"?>
>> +<!-- Created with Inkscape 
>> (http://www.inkscape.org/ 
>> -->
>> +
>> +<svg
>> +   version="1.1"
>> +   id="svg2019"
>> +   width="1702"
>> +   height="1845"
>> +   viewBox="0 0 1702 1845"
>> +   sodipodi:docname="dcn3_cm_drm_current.svg"
>> +   inkscape:version="1.1.2 (0a00cf5339, 2022-02-04)"
>> +   
>> xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape 
>>
>> +   
>> xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd 
>>
>> +   
>> xmlns="http://www.w3.org/2000/svg 
>>
>> +   
>> xmlns:svg="http://www.w3.org/2000/svg 
>>
>> +  <defs
>> +     id="defs2023" />
>> +  <sodipodi:namedview
>> +     id="namedview2021"
>> +     pagecolor="#ffffff"
>> +     bordercolor="#666666"
>> +     borderopacity="1.0"
>> +     inkscape:pageshadow="2"
>> +     inkscape:pageopacity="0.0"
>> +     inkscape:pagecheckerboard="0"
>> +     showgrid="false"
>> +     inkscape:zoom="0.55760543"
>> +     inkscape:cx="1011.4679"
>> +     inkscape:cy="249.28021"
>> +     inkscape:window-width="1920"
>> +     inkscape:window-height="1011"
>> +     inkscape:window-x="0"
>> +     inkscape:window-y="0"
>> +     inkscape:window-maximized="1"
>> +     inkscape:current-layer="g2025" />
>> +  <g
>> +     inkscape:groupmode="layer"
>> +     inkscape:label="Image"
>> +     id="g2025">
>> +    <rect
>> +       
>> style="fill:#000000;fill-opacity:0;stroke:#000000;stroke-opacity:1"
>> +       id="rect34"
>> +       width="208.83351"
>> +       height="486.09872"
>> +       x="0.90158081"
>> +       y="132.77872" />
>> +    <rect
>> +       
>> style="fill:#fad7ac;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1019"
>> +       width="126.38867"
>> +       height="55.320732"
>> +       x="25.960823"
>> +       y="188.06937" />
>> +    <rect
>> +       
>> style="fill:#d0cee2;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1021"
>> +       width="126.38867"
>> +       height="55.320732"
>> +       x="25.960823"
>> +       y="346.06937" />
>> +    <rect
>> +       
>> style="fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1103"
>> +       width="126.38867"
>> +       height="55.320732"
>> +       x="25.960823"
>> +       y="266.06937" />
>> +    <rect
>> +       
>> style="fill:#f9f7ed;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1105"
>> +       width="126.38867"
>> +       height="55.320732"
>> +       x="25.960823"
>> +       y="426.06937" />
>> +    <rect
>> +       
>> style="fill:#e6e6e6;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1107"
>> +       width="126.38867"
>> +       height="55.320732"
>> +       x="25.960823"
>> +       y="506.06934" />
>> +    <path
>> +       d="m 402.61883,171.88069 c 0.025,10.97895 0.01,1001.03791 
>> 0.049,1012.01891 2.5462,-1.1592 5.0637,-2.3779 7.6202,-3.5187 
>> -2.7411,4.8298 -5.4987,9.6453 -8.2624,14.4607 -2.7925,-4.8257 
>> -5.5993,-9.6453 -8.3856,-14.4751 2.6221,1.1736 5.2217,2.3923 
>> 7.8398,3.5721 0,-10.8825 -0.035,-1000.84096 -0.031,-1011.72348 
>> 0.053,-0.30366 -0.2175,-0.50268 -0.3652,-0.72837 l 1.5347,0.39394 z"
>> +       id="path381056"
>> +       sodipodi:nodetypes="cccccccccc"
>> +       style="stroke-width:0.205176"
>> +       inkscape:transform-center-x="-325.50819"
>> +       inkscape:transform-center-y="-121.97185" />
>> +    <rect
>> +       
>> style="fill:#000000;fill-opacity:0;stroke:#000000;stroke-opacity:1"
>> +       id="rect1131"
>> +       width="239.47592"
>> +       height="1015.9909"
>> +       x="298.65631"
>> +       y="82.399658" />
>> +    <rect
>> +       
>> style="fill:#000000;fill-opacity:0;stroke:#000000;stroke-width:1.27861;stroke-opacity:1" 
>>
>> +       id="rect1133"
>> +       width="340.44653"
>> +       height="525.77448"
>> +       x="298.79562"
>> +       y="1142.5299" />
>> +    <rect
>> +       
>> style="fill:#000000;fill-opacity:0;stroke:#000000;stroke-opacity:1"
>> +       id="rect1237"
>> +       width="284.00113"
>> +       height="945.41412"
>> +       x="827.75012"
>> +       y="82.880798"
>> +       inkscape:connector-avoid="true" />
>> +    <rect
>> +       
>> style="fill:#000000;fill-opacity:0;stroke:#000000;stroke-opacity:1"
>> +       id="rect1239"
>> +       width="239.37569"
>> +       height="179.03308"
>> +       x="1356.9507"
>> +       y="98.758331" />
>> +    <rect
>> +       
>> style="fill:#000000;fill-opacity:0;stroke:#000000;stroke-width:1.00744;stroke-opacity:1" 
>>
>> +       id="rect1241"
>> +       width="239.4184"
>> +       height="713.64905"
>> +       x="1356.9543"
>> +       y="307.7951"
>> +       inkscape:connector-avoid="true" />
>> +    <rect
>> +       
>> style="fill:#000000;fill-opacity:0;stroke:#000000;stroke-opacity:1"
>> +       id="rect1345"
>> +       width="330.32059"
>> +       height="409.44757"
>> +       x="1363.8723"
>> +       y="1147.7572" />
>> +    <rect
>> +       
>> style="fill:#000000;fill-opacity:0;stroke:#000000;stroke-opacity:1"
>> +       id="rect1347"
>> +       width="369.8941"
>> +       height="682.32245"
>> +       x="825.72528"
>> +       y="1146.6448"
>> +       inkscape:connector-avoid="true" />
>> +    <rect
>> +       
>> style="fill:#f9f7ed;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1349"
>> +       width="163.95746"
>> +       height="40.144867"
>> +       x="1389.9988"
>> +       y="190.80583" />
>> +    <rect
>> +       
>> style="fill:#000000;fill-opacity:0;stroke:#000000;stroke-width:0.964132;stroke-opacity:1" 
>>
>> +       id="rect1619"
>> +       width="271.99091"
>> +       height="42.038273"
>> +       x="1393.981"
>> +       y="1197.161"
>> +       inkscape:connector-avoid="true" />
>> +    <path
>> +       d="m 1469.3028,1238.8328 c 0.025,10.9789 0.01,175.0378 
>> 0.049,186.0188 2.5462,-1.1592 5.0637,-2.3779 7.6202,-3.5187 
>> -2.7411,4.8298 -5.4987,9.6453 -8.2624,14.4607 -2.7925,-4.8257 
>> -5.5993,-9.6453 -8.3856,-14.4751 2.6221,1.1736 5.2217,2.3923 
>> 7.8398,3.5721 0,-10.8825 -0.035,-174.8409 -0.031,-185.7234 
>> 0.053,-0.3037 -0.2175,-0.5027 -0.3652,-0.7284 l 1.5347,0.394 z"
>> +       id="path106-1"
>> +       sodipodi:nodetypes="cccccccccc"
>> +       style="stroke-width:0.205176"
>> +       inkscape:transform-center-x="-325.50819"
>> +       inkscape:transform-center-y="-121.97185" />
>> +    <path
>> +       d="m 407.4759,1238.4728 c 0.025,10.9789 0.01,291.0378 
>> 0.049,302.0188 2.5462,-1.1592 5.0637,-2.3779 7.6202,-3.5187 
>> -2.7411,4.8298 -5.4987,9.6453 -8.2624,14.4607 -2.7925,-4.8257 
>> -5.5993,-9.6453 -8.3856,-14.4751 2.6221,1.1736 5.2217,2.3923 
>> 7.8398,3.5721 0,-10.8825 -0.035,-290.8409 -0.031,-301.7234 
>> 0.053,-0.3037 -0.2175,-0.5027 -0.3652,-0.7284 l 1.5347,0.394 z"
>> +       id="path106-1-7"
>> +       sodipodi:nodetypes="cccccccccc"
>> +       style="stroke-width:0.205176"
>> +       inkscape:transform-center-x="-325.50819"
>> +       inkscape:transform-center-y="-121.97185" />
>> +    <rect
>> +       
>> style="fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1623"
>> +       width="137.32646"
>> +       height="41.782684"
>> +       x="1396.3848"
>> +       y="1268.2837"
>> +       inkscape:connector-avoid="true" />
>> +    <rect
>> +       
>> style="fill:#fad7ac;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1705"
>> +       width="137.32646"
>> +       height="41.782684"
>> +       x="1396.3848"
>> +       y="1348.2837" />
>> +    <rect
>> +       
>> style="fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1707"
>> +       width="137.32646"
>> +       height="41.782684"
>> +       x="1396.3848"
>> +       y="1432.2837" />
>> +    <rect
>> +       
>> style="fill:#f9f7ed;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1731"
>> +       width="222.34483"
>> +       height="44.64616"
>> +       x="867.36292"
>> +       y="190.42665"
>> +       inkscape:connector-avoid="true" />
>> +    <rect
>> +       
>> style="fill:#f9f7ed;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1813"
>> +       width="222.34483"
>> +       height="44.64616"
>> +       x="867.36292"
>> +       y="254.42664"
>> +       inkscape:connector-avoid="true" />
>> +    <rect
>> +       
>> style="fill:#f9f7ed;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1815"
>> +       width="222.34483"
>> +       height="44.64616"
>> +       x="867.36292"
>> +       y="318.42664"
>> +       inkscape:connector-avoid="true" />
>> +    <rect
>> +       
>> style="fill:#fad7ac;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1817"
>> +       width="222.34483"
>> +       height="44.64616"
>> +       x="867.36292"
>> +       y="412.42664"
>> +       inkscape:connector-avoid="true" />
>> +    <rect
>> +       
>> style="fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1819"
>> +       width="222.34483"
>> +       height="44.64616"
>> +       x="867.36292"
>> +       y="560.42664" />
>> +    <rect
>> +       
>> style="fill:#e6e6e6;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1821"
>> +       width="222.34483"
>> +       height="44.64616"
>> +       x="867.36292"
>> +       y="674.42664"
>> +       inkscape:connector-avoid="true" />
>> +    <rect
>> +       
>> style="fill:#fad7ac;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1823"
>> +       width="222.34483"
>> +       height="44.64616"
>> +       x="867.36292"
>> +       y="744.42664"
>> +       inkscape:connector-avoid="true" />
>> +    <rect
>> +       
>> style="fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1825"
>> +       width="222.34483"
>> +       height="44.64616"
>> +       x="867.36292"
>> +       y="820.42664"
>> +       inkscape:connector-avoid="true" />
>> +    <rect
>> +       
>> style="fill:#d0cee2;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1827"
>> +       width="222.34483"
>> +       height="44.64616"
>> +       x="867.36292"
>> +       y="890.42664"
>> +       inkscape:connector-avoid="true" />
>> +    <rect
>> +       
>> style="fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1829"
>> +       width="222.34483"
>> +       height="44.64616"
>> +       x="867.36292"
>> +       y="956.42664"
>> +       inkscape:connector-avoid="true" />
>> +    <rect
>> +       
>> style="fill:#fad7ac;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1831"
>> +       width="222.34483"
>> +       height="44.64616"
>> +       x="867.36292"
>> +       y="1256.4268" />
>> +    <rect
>> +       
>> style="fill:#d0cee2;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1833"
>> +       width="222.34483"
>> +       height="44.64616"
>> +       x="867.36292"
>> +       y="1402.4268" />
>> +    <rect
>> +       
>> style="fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1915"
>> +       width="222.34483"
>> +       height="44.64616"
>> +       x="867.36292"
>> +       y="1330.4268"
>> +       inkscape:connector-avoid="true" />
>> +    <rect
>> +       
>> style="fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1917"
>> +       width="222.34483"
>> +       height="44.64616"
>> +       x="867.36292"
>> +       y="1478.4268" />
>> +    <rect
>> +       
>> style="fill:#fad7ac;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1919"
>> +       width="222.34483"
>> +       height="44.64616"
>> +       x="867.36292"
>> +       y="1548.4268" />
>> +    <rect
>> +       
>> style="fill:#eeeeee;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1921"
>> +       width="222.34483"
>> +       height="44.64616"
>> +       x="867.36292"
>> +       y="1614.4268" />
>> +    <rect
>> +       
>> style="fill:#eeeeee;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1923"
>> +       width="222.34483"
>> +       height="44.64616"
>> +       x="867.36292"
>> +       y="1686.4268" />
>> +    <rect
>> +       
>> style="fill:#eeeeee;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1925"
>> +       width="222.34483"
>> +       height="44.64616"
>> +       x="867.36292"
>> +       y="1754.4268" />
>> +    <rect
>> +       
>> style="fill:#f9f7ed;fill-opacity:1;stroke:#000000;stroke-width:0.872749;stroke-opacity:1" 
>>
>> +       id="rect1925-3"
>> +       width="169.23357"
>> +       height="44.678963"
>> +       x="325.21747"
>> +       y="134.37756" />
>> +    <rect
>> +       
>> style="fill:#fad7ac;fill-opacity:1;stroke:#000000;stroke-width:0.872749;stroke-opacity:1" 
>>
>> +       id="rect1954"
>> +       width="169.23357"
>> +       height="44.678963"
>> +       x="325.21747"
>> +       y="276.37756"
>> +       inkscape:connector-avoid="true" />
>> +    <rect
>> +       
>> style="fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-width:0.87333333;stroke-opacity:1;stroke-miterlimit:4;stroke-dasharray:none" 
>>
>> +       id="rect1956"
>> +       width="168.66573"
>> +       height="122.14091"
>> +       x="325.50134"
>> +       y="358.6615"
>> +       inkscape:connector-avoid="true" />
>> +    <rect
>> +       
>> style="fill:#e6e6e6;fill-opacity:1;stroke:#000000;stroke-width:0.872749;stroke-opacity:1" 
>>
>> +       id="rect1958"
>> +       width="169.23357"
>> +       height="44.678963"
>> +       x="325.21747"
>> +       y="672.37756" />
>> +    <rect
>> +       
>> style="fill:#fad7ac;fill-opacity:1;stroke:#000000;stroke-width:0.872749;stroke-opacity:1" 
>>
>> +       id="rect1960"
>> +       width="169.23357"
>> +       height="44.678963"
>> +       x="325.21747"
>> +       y="744.37756" />
>> +    <rect
>> +       
>> style="fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-width:0.965912;stroke-opacity:1" 
>>
>> +       id="rect1962"
>> +       width="169.14041"
>> +       height="54.756817"
>> +       x="325.26404"
>> +       y="814.42413"
>> +       inkscape:connector-avoid="true" />
>> +    <rect
>> +       
>> style="fill:#d0cee2;fill-opacity:1;stroke:#000000;stroke-width:0.965912;stroke-opacity:1" 
>>
>> +       id="rect1964"
>> +       width="169.14041"
>> +       height="54.756817"
>> +       x="325.26404"
>> +       y="886.42413"
>> +       inkscape:connector-avoid="true" />
>> +    <rect
>> +       
>> style="fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-width:0.965912;stroke-opacity:1" 
>>
>> +       id="rect1966"
>> +       width="169.14041"
>> +       height="54.756817"
>> +       x="325.26404"
>> +       y="952.42413"
>> +       inkscape:connector-avoid="true" />
>> +    <rect
>> +       
>> style="fill:#fad7ac;fill-opacity:1;stroke:#000000;stroke-width:0.872749;stroke-opacity:1" 
>>
>> +       id="rect2418"
>> +       width="169.23357"
>> +       height="44.678963"
>> +       x="325.21747"
>> +       y="510.37756"
>> +       inkscape:connector-avoid="true" />
>> +    <rect
>> +       
>> style="fill:#fad7ac;fill-opacity:1;stroke:#000000;stroke-width:0.872749;stroke-opacity:1" 
>>
>> +       id="rect2422"
>> +       width="169.23357"
>> +       height="44.678963"
>> +       x="325.21747"
>> +       y="1262.3777" />
>> +    <rect
>> +       
>> style="fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-width:0.981369;stroke-opacity:1" 
>>
>> +       id="rect2424"
>> +       width="169.12494"
>> +       height="56.528603"
>> +       x="325.27179"
>> +       y="1322.432" />
>> +    <rect
>> +       
>> style="fill:#d0cee2;fill-opacity:1;stroke:#000000;stroke-width:0.981369;stroke-opacity:1" 
>>
>> +       id="rect2426"
>> +       width="169.12494"
>> +       height="56.528603"
>> +       x="325.27179"
>> +       y="1396.432" />
>> +    <rect
>> +       
>> style="fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-width:1.02091;stroke-opacity:1" 
>>
>> +       id="rect2428"
>> +       width="169.0854"
>> +       height="61.19017"
>> +       x="325.29156"
>> +       y="1468.4518" />
>> +    <rect
>> +       
>> style="fill:#fad7ac;fill-opacity:1;stroke:#000000;stroke-width:0.839627;stroke-opacity:1" 
>>
>> +       id="rect2430"
>> +       width="169.26669"
>> +       height="41.344128"
>> +       x="325.20093"
>> +       y="1550.3611" />
>> +    <rect
>> +       
>> style="fill:#000000;fill-opacity:0;stroke:#000000;stroke-width:1.13491;stroke-opacity:1" 
>>
>> +       id="rect2432"
>> +       width="287.86237"
>> +       height="44.416805"
>> +       x="325.34854"
>> +       y="1194.5088" />
>> +    <rect
>> +       
>> style="fill:#000000;fill-opacity:0;stroke:#000000;stroke-width:1.13102;stroke-opacity:1" 
>>
>> +       id="rect2434"
>> +       width="285.86655"
>> +       height="44.4207"
>> +       x="867.34656"
>> +       y="1194.5068" />
>> +    <path
>> +       
>> style="fill:none;stroke:#000000;stroke-width:2.66666675;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4;stroke-dasharray:8.00000024, 
>> 8.00000024;stroke-dashoffset:0"
>> +       d="m 867.36292,235.07281 v 0"
>> +       id="path2509" />
>> +    <path
>> +       
>> style="fill:none;stroke:#000000;stroke-width:2.66666675;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4;stroke-dasharray:8.00000024, 
>> 8.00000024;stroke-dashoffset:0"
>> +       d="m 867.36292,235.07281 v 0"
>> +       id="path2511" />
>> +    <path
>> +       
>> style="fill:none;stroke:#000000;stroke-width:2.66666675;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4;stroke-dasharray:8.00000024, 
>> 8.00000024;stroke-dashoffset:0"
>> +       d="m 867.36292,235.07281 v 0"
>> +       id="path2513" />
>> +    <path
>> +       
>> style="fill:none;stroke:#000000;stroke-width:2.66666675;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4;stroke-dasharray:8.00000024, 
>> 8.00000024;stroke-dashoffset:0"
>> +       d="m 867.36292,235.07281 v 0"
>> +       id="path2515" />
>> +    <path
>> +       
>> style="fill:none;stroke:#000000;stroke-width:2.66666675;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4;stroke-dasharray:8.00000024, 
>> 8.00000024;stroke-dashoffset:0"
>> +       d="m 867.36292,235.07281 v 0"
>> +       id="path2517" />
>> +    <path
>> +       
>> style="fill:none;stroke:#000000;stroke-width:2.66666675;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4;stroke-dasharray:8.00000024, 
>> 8.00000024;stroke-dashoffset:0"
>> +       d="m 867.36292,235.07281 v 0"
>> +       id="path2519" />
>> +    <path
>> +       
>> style="fill:none;stroke:#000000;stroke-width:2.66666675;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4;stroke-dasharray:8.00000024, 
>> 8.00000024;stroke-dashoffset:0"
>> +       d="m 867.36292,235.07281 v 0"
>> +       id="path2521" />
>> +    <path
>> +       
>> style="fill:none;stroke:#000000;stroke-width:2.66666675;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4;stroke-dasharray:8.00000024, 
>> 8.00000024;stroke-dashoffset:0"
>> +       d="m 867.36292,235.07281 v 0"
>> +       id="path2523" />
>> +    <path
>> +       
>> style="fill:none;stroke:#000000;stroke-width:2.66666675;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4;stroke-dasharray:8.00000024, 
>> 8.00000024;stroke-dashoffset:0"
>> +       d="m 867.36292,235.07281 v 0"
>> +       id="path2525" />
>> +    <path
>> +       
>> style="fill:none;stroke:#000000;stroke-width:2.66666675;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4;stroke-dasharray:8.00000024, 
>> 8.00000024;stroke-dashoffset:0"
>> +       d="m 867.36292,235.07281 v 0"
>> +       id="path2527" />
>> +    <path
>> +       
>> style="fill:none;stroke:#000000;stroke-width:2.66666675;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4;stroke-dasharray:8.00000024, 
>> 8.00000024;stroke-dashoffset:0"
>> +       d="m 867.36292,235.07281 v 0"
>> +       id="path2529" />
>> +    <path
>> +       
>> style="fill:none;stroke:#000000;stroke-width:2.66666675;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4;stroke-dasharray:8.00000024, 
>> 8.00000024;stroke-dashoffset:0"
>> +       d="m 867.36292,235.07281 v 0"
>> +       id="path2531" />
>> +    <path
>> +       
>> style="fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:6, 
>> 6;stroke-dashoffset:0;stroke-opacity:1"
>> +       d="m 449.83425,179.05653 v 33.6932 h 417.52867"
>> +       id="path6876"
>> +       inkscape:connector-type="orthogonal"
>> +       inkscape:connector-curvature="0"
>> +       inkscape:connection-start="#rect1925-3"
>> +       inkscape:connection-end="#rect1731"
>> +       sodipodi:nodetypes="ccc" />
>> +    <path
>> +       
>> style="display:inline;fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:6, 
>> 6;stroke-dashoffset:0;stroke-opacity:1"
>> +       d="m 494.45103,156.71704 h 216.64955 v 161.7096 h 156.26234"
>> +       id="path6878"
>> +       inkscape:connector-type="orthogonal"
>> +       inkscape:connector-curvature="0"
>> +       inkscape:connection-start="#rect1925-3"
>> +       sodipodi:nodetypes="cccc" />
>> +    <path
>> +       
>> style="fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:6, 
>> 6;stroke-dashoffset:0;stroke-opacity:1"
>> +       d="m 451.83425,321.05653 v 19.69319 h 415.52867"
>> +       id="path7294"
>> +       inkscape:connector-type="orthogonal"
>> +       inkscape:connector-curvature="0"
>> +       inkscape:connection-start="#rect1954"
>> +       inkscape:connection-end="#rect1815"
>> +       sodipodi:nodetypes="ccc" />
>> +    <path
>> +       
>> style="fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:6, 
>> 6;stroke-dashoffset:0;stroke-opacity:1"
>> +       d="M 494.45103,298.71704 H 659.10058 V 434.74972 H 867.36292"
>> +       id="path7296"
>> +       inkscape:connector-type="orthogonal"
>> +       inkscape:connector-curvature="0"
>> +       inkscape:connection-end="#rect1817"
>> +       inkscape:connection-start="#rect1954"
>> +       sodipodi:nodetypes="cccc" />
>> +    <path
>> +       
>> style="display:inline;fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:6, 
>> 6;stroke-dashoffset:0;stroke-opacity:1"
>> +       d="M 867.36292,560.42664 H 661.10058 V 480.8024 H 494.16705"
>> +       id="path7720"
>> +       inkscape:connector-type="orthogonal"
>> +       inkscape:connector-curvature="0"
>> +       sodipodi:nodetypes="cccc" />
>> +    <path
>> +       
>> style="fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:6, 
>> 6;stroke-dashoffset:0;stroke-opacity:1"
>> +       d="M 455.83425,594.37756 V 582.74972 H 867.36292"
>> +       id="path7724"
>> +       inkscape:connector-type="orthogonal"
>> +       inkscape:connector-curvature="0"
>> +       inkscape:connection-start="#rect2420"
>> +       inkscape:connection-end="#rect1819"
>> +       sodipodi:nodetypes="ccc" />
>> +    <rect
>> +       
>> style="fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-width:0.872749;stroke-opacity:1" 
>>
>> +       id="rect2420"
>> +       width="169.23357"
>> +       height="44.678963"
>> +       x="325.21747"
>> +       y="594.37756" />
>> +    <path
>> +       
>> style="fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:6, 
>> 6;stroke-dashoffset:0;stroke-opacity:1"
>> +       d="M 494.45103,696.74972 H 867.36292"
>> +       id="path7726"
>> +       inkscape:connector-type="orthogonal"
>> +       inkscape:connector-curvature="0"
>> +       inkscape:connection-start="#rect1958"
>> +       inkscape:connection-end="#rect1821" />
>> +    <path
>> +       
>> style="fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:6, 
>> 6;stroke-dashoffset:0;stroke-opacity:1"
>> +       d="M 867.36292,766.74972 H 494.45103"
>> +       id="path7728"
>> +       inkscape:connector-type="orthogonal"
>> +       inkscape:connector-curvature="0"
>> +       inkscape:connection-start="#rect1823"
>> +       inkscape:connection-end="#rect1960" />
>> +    <path
>> +       
>> style="display:inline;fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:6, 
>> 6;stroke-dashoffset:0;stroke-opacity:1"
>> +       d="M 494.45105,789.05652 H 657.82418 V 1278.7498 H 867.36292"
>> +       id="path7730"
>> +       inkscape:connector-type="orthogonal"
>> +       inkscape:connector-curvature="0"
>> +       inkscape:connection-end="#rect1831"
>> +       sodipodi:nodetypes="cccc" />
>> +    <path
>> +       
>> style="fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:6, 
>> 6;stroke-dashoffset:0;stroke-opacity:1"
>> +       d="m 494.40445,841.80254 h 167.41973 v 0.94718 h 205.53874"
>> +       id="path8140"
>> +       inkscape:connector-type="orthogonal"
>> +       inkscape:connector-curvature="0"
>> +       inkscape:connection-start="#rect1962"
>> +       inkscape:connection-end="#rect1825" />
>> +    <path
>> +       
>> style="fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:6, 
>> 6;stroke-dashoffset:0;stroke-opacity:1"
>> +       d="m 494.40445,913.80254 h 167.41973 v -1.05282 h 205.53874"
>> +       id="path8142"
>> +       inkscape:connector-type="orthogonal"
>> +       inkscape:connector-curvature="0"
>> +       inkscape:connection-start="#rect1964"
>> +       inkscape:connection-end="#rect1827" />
>> +    <path
>> +       
>> style="fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:6, 
>> 6;stroke-dashoffset:0;stroke-opacity:1"
>> +       d="m 494.40445,979.80254 h 167.41973 v -1.05282 h 205.53874"
>> +       id="path8144"
>> +       inkscape:connector-type="orthogonal"
>> +       inkscape:connector-curvature="0"
>> +       inkscape:connection-start="#rect1966"
>> +       inkscape:connection-end="#rect1829" />
>> +    <path
>> +       
>> style="fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:6, 
>> 6;stroke-dashoffset:0;stroke-opacity:1"
>> +       d="M 494.39673,1352.7498 H 867.36292"
>> +       id="path8146"
>> +       inkscape:connector-type="orthogonal"
>> +       inkscape:connector-curvature="0"
>> +       inkscape:connection-start="#rect2424"
>> +       inkscape:connection-end="#rect1915" />
>> +    <path
>> +       
>> style="fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:6, 
>> 6;stroke-dashoffset:0;stroke-opacity:1"
>> +       d="M 494.39673,1424.7498 H 867.36292"
>> +       id="path8148"
>> +       inkscape:connector-type="orthogonal"
>> +       inkscape:connector-curvature="0"
>> +       inkscape:connection-start="#rect2426"
>> +       inkscape:connection-end="#rect1833" />
>> +    <path
>> +       
>> style="fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:6, 
>> 6;stroke-dashoffset:0;stroke-opacity:1"
>> +       d="M 494.37697,1500.7498 H 867.36292"
>> +       id="path8150"
>> +       inkscape:connector-type="orthogonal"
>> +       inkscape:connector-curvature="0"
>> +       inkscape:connection-start="#rect2428"
>> +       inkscape:connection-end="#rect1917" />
>> +    <path
>> +       
>> style="fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:6, 
>> 6;stroke-dashoffset:0;stroke-opacity:1"
>> +       d="m 494.46762,1570.7498 h 372.8953"
>> +       id="path8152"
>> +       inkscape:connector-type="orthogonal"
>> +       inkscape:connector-curvature="0"
>> +       inkscape:connection-start="#rect2430"
>> +       inkscape:connection-end="#rect1919" />
>> +    <path
>> +       
>> style="fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:6, 
>> 6;stroke-dashoffset:0;stroke-opacity:1"
>> +       d="M 1396.3848,1289.175 H 1288.1445 V 582.74972 h -198.4368"
>> +       id="path8154"
>> +       inkscape:connector-type="orthogonal"
>> +       inkscape:connector-curvature="0"
>> +       inkscape:connection-start="#rect1623"
>> +       inkscape:connection-end="#rect1819" />
>> +    <path
>> +       
>> style="fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:6, 
>> 6;stroke-dashoffset:0;stroke-opacity:1"
>> +       d="m 1396.3848,1369.175 h -156.2403 v -90.4252 h -150.4368"
>> +       id="path8462"
>> +       inkscape:connector-type="orthogonal"
>> +       inkscape:connector-curvature="0"
>> +       inkscape:connection-start="#rect1705"
>> +       inkscape:connection-end="#rect1831"
>> +       sodipodi:nodetypes="cccc" />
>> +    <path
>> +       
>> style="fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:6, 
>> 6;stroke-dashoffset:0;stroke-opacity:1"
>> +       d="m 1089.7077,1500.7498 h 375.3403 v -26.6834"
>> +       id="path8668"
>> +       inkscape:connector-type="orthogonal"
>> +       inkscape:connector-curvature="0"
>> +       inkscape:connection-start="#rect1917"
>> +       inkscape:connection-end="#rect1707" />
>> +    <path
>> +       
>> style="fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:6, 
>> 6;stroke-dashoffset:0;stroke-opacity:1"
>> +       d="M 1389.9988,212.74973 H 1089.7077"
>> +       id="path8672"
>> +       inkscape:connector-type="orthogonal"
>> +       inkscape:connector-curvature="0"
>> +       inkscape:connection-start="#rect1349"
>> +       inkscape:connection-end="#rect1731" />
>> +    <path
>> +       
>> style="display:inline;fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:6, 
>> 6;stroke-dashoffset:0;stroke-opacity:1"
>> +       d="M 1389.9988,230.9507 H 1223.331 v 109.79902 h -133.6233"
>> +       id="path8674"
>> +       inkscape:connector-type="orthogonal"
>> +       inkscape:connector-curvature="0"
>> +       inkscape:connection-end="#rect1815"
>> +       sodipodi:nodetypes="cccc" />
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:40px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="58.63356"
>> +       y="69.574417"
>> +       id="text28675"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan28673"
>> +         x="58.63356"
>> +         y="69.574417" /></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="56.388252"
>> +       y="221.86568"
>> +       id="text31913"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan31911"
>> +         x="56.388252"
>> +         y="221.86568">Matrix</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="53.441296"
>> +       y="300.866"
>> +       id="text38843"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan38841"
>> +         x="53.441296"
>> +         y="300.866">1D LUT</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="53.441296"
>> +       y="378.866"
>> +       id="text41049"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan41047"
>> +         x="53.441296"
>> +         y="378.866">3D LUT</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="40.831493"
>> +       y="460.87411"
>> +       id="text45037"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan45035"
>> +         x="40.831493"
>> +         y="460.87411"
>> +         style="font-size:18.6667px">Unpacking</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="62.130371"
>> +       y="540.68872"
>> +       id="text49945"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan49943"
>> +         x="62.130371"
>> +         y="540.68872"
>> +         style="font-size:18.6667px">Other</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="1423.2806"
>> +       y="128.08769"
>> +       id="text55719"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan55717"
>> +         x="1423.2806"
>> +         y="128.08769"
>> +         style="font-size:18.6667px">drm_framebuffer</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="1439.9988"
>> +       y="218.74973"
>> +       id="text62479"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan62477"
>> +         x="1439.9988"
>> +         y="218.74973"
>> +         style="font-size:18.6667px">format</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="1475.2806"
>> +       y="340.08771"
>> +       id="text64465"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan64463"
>> +         x="1475.2806"
>> +         y="340.08771"
>> +         style="font-size:18.6667px">drm_plane</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="1589.2806"
>> +       y="1178.0876"
>> +       id="text64469"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan64467"
>> +         x="1589.2806"
>> +         y="1178.0876"
>> +         style="font-size:18.6667px">drm_crtc</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="872.23993"
>> +       y="1172.4491"
>> +       id="text64469-9"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan64467-2"
>> +         x="872.23993"
>> +         y="1172.4491"
>> +         style="font-size:18.6667px">Stream</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="328.26071"
>> +       y="1175.6371"
>> +       id="text64469-9-2"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan64467-2-8"
>> +         x="328.26071"
>> +         y="1175.6371"
>> +         style="font-size:18.6667px">MPC</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="330.14737"
>> +       y="114.41869"
>> +       id="text64469-9-9"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan64467-2-7"
>> +         x="330.14737"
>> +         y="114.41869"
>> +         style="font-size:18.6667px">DPP</tspan></text>
>> +    <path
>> +       d="m 1488.3608,401.47792 c 0.025,10.97895 0.01,773.03788 
>> 0.049,784.01888 2.5462,-1.1592 5.0637,-2.3779 7.6202,-3.5187 
>> -2.7411,4.8298 -5.4987,9.6453 -8.2624,14.4607 -2.7925,-4.8257 
>> -5.5993,-9.6453 -8.3856,-14.4751 2.6221,1.1736 5.2217,2.3923 
>> 7.8398,3.5721 0,-10.8825 -0.035,-772.84093 -0.031,-783.72345 
>> 0.053,-0.30366 -0.2175,-0.50268 -0.3652,-0.72837 l 1.5347,0.39394 z"
>> +       id="path106"
>> +       sodipodi:nodetypes="cccccccccc"
>> +       style="stroke-width:0.205176"
>> +       inkscape:transform-center-x="-325.50819"
>> +       inkscape:transform-center-y="-121.97185" />
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="1495.9988"
>> +       y="1224.7498"
>> +       id="text78849"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan78847"
>> +         x="1495.9988"
>> +         y="1224.7498"
>> +         style="font-size:18.6667px">Blender</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="1417.9988"
>> +       y="1294.7498"
>> +       id="text78853"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan78851"
>> +         x="1417.9988"
>> +         y="1294.7498"
>> +         style="font-size:18.6667px">Degamma</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="1451.9988"
>> +       y="1376.7498"
>> +       id="text78857"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan78855"
>> +         x="1451.9988"
>> +         y="1376.7498"
>> +         style="font-size:18.6667px">CTM</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="1427.9988"
>> +       y="1458.7498"
>> +       id="text78861"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan78859"
>> +         x="1427.9988"
>> +         y="1458.7498"
>> +         style="font-size:18.6667px">Gamma</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="949.99878"
>> +       y="218.74973"
>> +       id="text104653"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan104651"
>> +         x="949.99878"
>> +         y="218.74973"
>> +         style="font-size:18.6667px">format</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="911.99878"
>> +       y="284.74973"
>> +       id="text104657"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan104655"
>> +         x="911.99878"
>> +         y="284.74973"
>> +         style="font-size:18.6667px">bias_and_scale</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="887.99878"
>> +       y="346.74973"
>> +       id="text104661"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan104659"
>> +         x="887.99878"
>> +         y="346.74973"
>> +         style="font-size:18.6667px">color space matrix</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="871.99878"
>> +       y="442.74973"
>> +       id="text104665"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan104663"
>> +         x="871.99878"
>> +         y="442.74973"
>> +         
>> style="font-size:18.6667px">input_csc_color_matrix</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="905.99878"
>> +       y="586.74976"
>> +       id="text125075"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan125073"
>> +         x="905.99878"
>> +         y="586.74976"
>> +         style="font-size:18.6667px">in_transfer_func</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="945.0083"
>> +       y="702.85938"
>> +       id="text117309"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan117307"
>> +         x="945.0083"
>> +         y="702.85938"
>> +         style="font-size:18.6667px">hdr_mult</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="874.5556"
>> +       y="773.42615"
>> +       id="text117309-6"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan117307-7"
>> +         x="874.5556"
>> +         y="773.42615"
>> +         style="font-size:18.6667px">gamut_remap_matrix</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="913.72528"
>> +       y="846.55896"
>> +       id="text117309-5"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan117307-3"
>> +         x="913.72528"
>> +         y="846.55896"
>> +         style="font-size:18.6667px">in_shaper_func</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="937.72528"
>> +       y="918.25787"
>> +       id="text117309-56"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan117307-2"
>> +         x="937.72528"
>> +         y="918.25787"
>> +         style="font-size:18.6667px">lut3d_func</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="945.9895"
>> +       y="986.10767"
>> +       id="text117309-9"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan117307-1"
>> +         x="945.9895"
>> +         y="986.10767"
>> +         style="font-size:18.6667px">blend_tf</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="975.91803"
>> +       y="1224.5564"
>> +       id="text137434"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan137432"
>> +         x="975.91803"
>> +         y="1224.5564"
>> +         style="font-size:18.6667px">Blender</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="879.31372"
>> +       y="1283.4249"
>> +       id="text137434-2"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan137432-7"
>> +         x="879.31372"
>> +         y="1283.4249"
>> +         style="font-size:18.6667px">gamut_remap_matrix</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="925.31372"
>> +       y="1359.2747"
>> +       id="text137434-0"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan137432-9"
>> +         x="925.31372"
>> +         y="1359.2747"
>> +         style="font-size:18.6667px">func_shaper</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="930.33252"
>> +       y="1430.2566"
>> +       id="text137434-3"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan137432-6"
>> +         x="930.33252"
>> +         y="1430.2566"
>> +         style="font-size:18.6667px">lut3d_func</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="900.18158"
>> +       y="1504.6725"
>> +       id="text137434-06"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan137432-2"
>> +         x="900.18158"
>> +         y="1504.6725"
>> +         style="font-size:18.6667px">out_transfer_func</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="904.0307"
>> +       y="1575.8053"
>> +       id="text137434-6"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan137432-1"
>> +         x="904.0307"
>> +         y="1575.8053"
>> +         style="font-size:18.6667px">csc_color_matrix</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="903.16278"
>> +       y="1642.1078"
>> +       id="text137434-8"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan137432-79"
>> +         x="903.16278"
>> +         y="1642.1078"
>> +         style="font-size:18.6667px">bit_depth_param</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="939.31372"
>> +       y="1713.8068"
>> +       id="text137434-20"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan137432-23"
>> +         x="939.31372"
>> +         y="1713.8068"
>> +         style="font-size:18.6667px">clamping</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="894.0307"
>> +       y="1782.5244"
>> +       id="text137434-7"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan137432-5"
>> +         x="894.0307"
>> +         y="1782.5244"
>> +         style="font-size:18.6667px">output_color_space</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="869.63062"
>> +       y="117.7968"
>> +       id="text176429"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan176427"
>> +         x="869.63062"
>> +         y="117.7968"
>> +         style="font-size:18.6667px">Plane</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="27.605465"
>> +       y="162.20587"
>> +       id="text176429-2"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan176427-0"
>> +         x="27.605465"
>> +         y="162.20587"
>> +         style="font-size:18.6667px">Legend</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="298.63959"
>> +       y="59.293999"
>> +       id="text176429-9"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan176427-2"
>> +         x="298.63959"
>> +         y="59.293999"
>> +         style="font-size:18.6667px">DCN 3.0</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="826.65735"
>> +       y="59.458061"
>> +       id="text176429-66"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan176427-4"
>> +         x="826.65735"
>> +         y="59.458061"
>> +         style="font-size:18.6667px">DC Interface</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="1362.9948"
>> +       y="59.458061"
>> +       id="text176429-95"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan176427-04"
>> +         x="1362.9948"
>> +         y="59.458061"
>> +         style="font-size:18.6667px">DRM Interface</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:40px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="867.34656"
>> +       y="1194.5068"
>> +       id="text184728"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan184726"
>> +         x="867.34656"
>> +         y="1194.5068" /></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="389.01593"
>> +       y="159.8909"
>> +       id="text64469-9-3"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan64467-2-6"
>> +         x="389.01593"
>> +         y="159.8909"
>> +         style="font-size:18.6667px">CNVC</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="365.88379"
>> +       y="303.59048"
>> +       id="text64469-9-1"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan64467-2-2"
>> +         x="365.88379"
>> +         y="303.59048"
>> +         style="font-size:18.6667px">Input CSC</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="413.06488"
>> +       y="390.95001"
>> +       id="text64469-9-93"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan64467-2-1"
>> +         x="413.06488"
>> +         y="390.95001"
>> +         
>> style="font-size:18.6667px;text-align:center;text-anchor:middle">DeGamma</tspan><tspan 
>>
>> +         sodipodi:role="line"
>> +         x="413.06488"
>> +         y="414.28339"
>> +         
>> style="font-size:18.6667px;text-align:center;text-anchor:middle"
>> +         id="tspan233797">ROM</tspan><tspan
>> +         sodipodi:role="line"
>> +         x="413.06488"
>> +         y="437.61676"
>> +         
>> style="font-size:10.6667px;text-align:center;text-anchor:middle"
>> +         id="tspan233799">(sRGB, BT2020, Gamma 2.2,</tspan><tspan
>> +         sodipodi:role="line"
>> +         x="413.06488"
>> +         y="460.95013"
>> +         
>> style="font-size:10.6667px;text-align:center;text-anchor:middle"
>> +         id="tspan242597">PQ, HLG)</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="372.44986"
>> +       y="538.83807"
>> +       id="text64469-9-94"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan64467-2-78"
>> +         x="372.44986"
>> +         y="538.83807"
>> +         style="font-size:18.6667px">Post CSC</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:16px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="335.31775"
>> +       y="622.23511"
>> +       id="text64469-9-4"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan64467-2-5"
>> +         x="335.31775"
>> +         y="622.23511"
>> +         style="font-size:16px">Gamma Correction</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="351.16684"
>> +       y="700.34918"
>> +       id="text64469-9-0"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan64467-2-3"
>> +         x="351.16684"
>> +         y="700.34918"
>> +         style="font-size:18.6667px">HDR Multiply</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="345.16684"
>> +       y="771.33112"
>> +       id="text64469-9-6"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan64467-2-10"
>> +         x="345.16684"
>> +         y="771.33112"
>> +         style="font-size:18.6667px">Gamut Remap</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="412.5184"
>> +       y="836.04877"
>> +       id="text64469-9-63"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan64467-2-20"
>> +         x="412.5184"
>> +         y="836.04877"
>> +         
>> style="font-size:18.6667px;text-align:center;text-anchor:middle">Shaper LUT</tspan><tspan 
>>
>> +         sodipodi:role="line"
>> +         x="412.5184"
>> +         y="859.38214"
>> +         
>> style="font-size:18.6667px;text-align:center;text-anchor:middle"
>> +         id="tspan222533">RAM</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="413.54086"
>> +       y="908.61554"
>> +       id="text64469-9-61"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan64467-2-55"
>> +         x="413.54086"
>> +         y="908.61554"
>> +         
>> style="font-size:18.6667px;text-align:center;text-anchor:middle">3D 
>> LUT</tspan><tspan
>> +         sodipodi:role="line"
>> +         x="413.54086"
>> +         y="931.94891"
>> +         
>> style="font-size:18.6667px;text-align:center;text-anchor:middle"
>> +         id="tspan221121">RAM</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="344.0347"
>> +       y="985.33319"
>> +       id="text64469-9-47"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan64467-2-65"
>> +         x="344.0347"
>> +         y="985.33319"
>> +         style="font-size:18.6667px">Blend Gamma</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="433.84625"
>> +       y="1223.411"
>> +       id="text64469-9-69"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan64467-2-37"
>> +         x="433.84625"
>> +         y="1223.411"
>> +         style="font-size:18.6667px">Blender</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="343.73291"
>> +       y="1290.2421"
>> +       id="text64469-9-45"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan64467-2-25"
>> +         x="343.73291"
>> +         y="1290.2421"
>> +         style="font-size:18.6667px">Gamut Remap</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="408.74442"
>> +       y="1344.2428"
>> +       id="text64469-9-474"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan64467-2-4"
>> +         x="408.74442"
>> +         y="1344.2428"
>> +         
>> style="font-size:18.6667px;text-align:center;text-anchor:middle">Shaper LUT</tspan><tspan 
>>
>> +         sodipodi:role="line"
>> +         x="408.74442"
>> +         y="1367.5762"
>> +         
>> style="font-size:18.6667px;text-align:center;text-anchor:middle"
>> +         id="tspan208303">RAM</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="407.1257"
>> +       y="1420.2435"
>> +       id="text64469-9-30"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan64467-2-786"
>> +         x="407.1257"
>> +         y="1420.2435"
>> +         
>> style="font-size:18.6667px;text-align:center;text-anchor:middle">3D 
>> LUT</tspan><tspan
>> +         sodipodi:role="line"
>> +         x="407.1257"
>> +         y="1443.5769"
>> +         
>> style="font-size:18.6667px;text-align:center;text-anchor:middle"
>> +         id="tspan204749">RAM</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="408.64996"
>> +       y="1492.8102"
>> +       id="text64469-9-8"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan64467-2-84"
>> +         x="408.64996"
>> +         y="1492.8102"
>> +         
>> style="font-size:18.6667px;text-align:center;text-anchor:middle">Gamma</tspan><tspan 
>>
>> +         sodipodi:role="line"
>> +         x="408.64996"
>> +         y="1516.1436"
>> +         
>> style="font-size:18.6667px;text-align:center;text-anchor:middle"
>> +         id="tspan197733">RAM</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="385.46863"
>> +       y="1575.2261"
>> +       id="text64469-9-31"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan64467-2-49"
>> +         x="385.46863"
>> +         y="1575.2261"
>> +         style="font-size:18.6667px">OCSC</tspan></text>
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:40px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="1356.5106"
>> +       y="53.140579"
>> +       id="text273287"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan273285"
>> +         x="1356.5106"
>> +         y="53.140579" /></text>
>> +    <rect
>> +       
>> style="fill:#f9f7ed;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1411"
>> +       width="177.28049"
>> +       height="38.940468"
>> +       x="1392.2576"
>> +       y="459.24118" />
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="1411.7203"
>> +       y="485.93231"
>> +       id="text78841"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan78839"
>> +         x="1411.7203"
>> +         y="485.93231"
>> +         style="font-size:18.6667px">color_encoding</tspan></text>
>> +    <rect
>> +       
>> style="fill:#f9f7ed;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect1515"
>> +       width="175.11876"
>> +       height="43.239407"
>> +       x="1393.7493"
>> +       y="525.6983" />
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:17.3333px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="1399.212"
>> +       y="553.44904"
>> +       id="text78845"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan78843"
>> +         x="1399.212"
>> +         y="553.44904">pixel_blend_mode</tspan></text>
>> +    <rect
>> +       
>> style="fill:#f9f7ed;fill-opacity:1;stroke:#000000;stroke-opacity:1"
>> +       id="rect371322"
>> +       width="177.28049"
>> +       height="38.940468"
>> +       x="1391.6781"
>> +       y="385.61713" />
>> +    <text
>> +       xml:space="preserve"
>> +       
>> style="font-style:normal;font-weight:normal;font-size:18.6667px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:none" 
>>
>> +       x="1427.5771"
>> +       y="409.29523"
>> +       id="text78837"><tspan
>> +         sodipodi:role="line"
>> +         id="tspan78835"
>> +         x="1427.5771"
>> +         y="409.29523"
>> +         style="font-size:18.6667px">color_range</tspan></text>
>> +    <path
>> +       d="m 1469.6815,1334.9145 c 3.2597,-1.4841 6.4827,-3.0444 
>> 9.7556,-4.5049 -3.5093,6.1834 -7.0396,12.3483 -10.5778,18.5131 
>> -3.575,-6.178 -7.1683,-12.3481 -10.7354,-18.5314 3.3569,1.5025 
>> 6.685,3.0627 10.0367,4.5731 0,0 0,0 1.5209,-0.05 z"
>> +       id="path371636-7"
>> +       sodipodi:nodetypes="cccccc"
>> +       style="stroke-width:0.262672"
>> +       inkscape:transform-center-x="-416.72543"
>> +       inkscape:transform-center-y="-156.15191" />
>> +    <path
>> +       d="m 1467.8882,1256.0056 c 3.2597,-1.4841 6.4827,-3.0443 
>> 9.7556,-4.5048 -3.5093,6.1833 -7.0396,12.3482 -10.5778,18.5131 
>> -3.575,-6.178 -7.1683,-12.3482 -10.7354,-18.5315 3.3569,1.5025 
>> 6.685,3.0628 10.0367,4.5731 0,0 0,0 1.5209,-0.05 z"
>> +       id="path371636-7-2"
>> +       sodipodi:nodetypes="cccccc"
>> +       style="stroke-width:0.262672"
>> +       inkscape:transform-center-x="-416.72543"
>> +       inkscape:transform-center-y="-156.15191" />
>> +    <path
>> +       d="m 1487.6154,441.80981 c 3.2597,-1.48411 6.4827,-3.04435 
>> 9.7556,-4.50482 -3.5093,6.18331 -7.0396,12.34823 -10.5778,18.51307 
>> -3.575,-6.17798 -7.1683,-12.34815 -10.7354,-18.53146 3.3569,1.50251 
>> 6.685,3.06275 10.0367,4.57314 0,0 0,0 1.5209,-0.0499 z"
>> +       id="path371636-7-7"
>> +       sodipodi:nodetypes="cccccc"
>> +       style="stroke-width:0.262672"
>> +       inkscape:transform-center-x="-416.72543"
>> +       inkscape:transform-center-y="-156.15191" />
>> +    <path
>> +       d="m 1489.4088,515.3385 c 3.2597,-1.48411 6.4827,-3.04435 
>> 9.7556,-4.50482 -3.5093,6.18331 -7.0396,12.34823 -10.5778,18.51307 
>> -3.575,-6.17798 -7.1683,-12.34815 -10.7354,-18.53146 3.3569,1.50251 
>> 6.685,3.06275 10.0367,4.57314 0,0 0,0 1.5209,-0.0499 z"
>> +       id="path371636-7-22"
>> +       sodipodi:nodetypes="cccccc"
>> +       style="stroke-width:0.262672"
>> +       inkscape:transform-center-x="-416.72543"
>> +       inkscape:transform-center-y="-156.15191" />
>> +    <path
>> +       d="m 400.8254,264.26491 c 3.2597,-1.48411 6.4827,-3.04435 
>> 9.7556,-4.50482 -3.5093,6.18331 -7.0396,12.34823 -10.5778,18.51307 
>> -3.575,-6.17798 -7.1683,-12.34815 -10.7354,-18.53146 3.3569,1.50251 
>> 6.685,3.06275 10.0367,4.57314 0,0 0,0 1.5209,-0.0499 z"
>> +       id="path371636-7-6"
>> +       sodipodi:nodetypes="cccccc"
>> +       style="stroke-width:0.262672"
>> +       inkscape:transform-center-x="-416.72543"
>> +       inkscape:transform-center-y="-156.15191" />
>> +    <path
>> +       d="m 402.6188,346.76052 c 3.2597,-1.48411 6.4827,-3.04435 
>> 9.7556,-4.50482 -3.5093,6.18331 -7.0396,12.34823 -10.5778,18.51307 
>> -3.575,-6.17798 -7.1683,-12.34815 -10.7354,-18.53146 3.3569,1.50251 
>> 6.685,3.06275 10.0367,4.57314 0,0 0,0 1.5209,-0.0499 z"
>> +       id="path371636-7-1"
>> +       sodipodi:nodetypes="cccccc"
>> +       style="stroke-width:0.262672"
>> +       inkscape:transform-center-x="-416.72543"
>> +       inkscape:transform-center-y="-156.15191" />
>> +    <path
>> +       d="m 404.2055,500.78482 c 3.2597,-1.48411 6.4827,-3.04435 
>> 9.7556,-4.50482 -3.5093,6.18331 -7.0396,12.34823 -10.5778,18.51307 
>> -3.575,-6.17798 -7.1683,-12.34815 -10.7354,-18.53146 3.3569,1.50251 
>> 6.685,3.06275 10.0367,4.57314 0,0 0,0 1.5209,-0.0499 z"
>> +       id="path371636-7-0"
>> +       sodipodi:nodetypes="cccccc"
>> +       style="stroke-width:0.262672"
>> +       inkscape:transform-center-x="-416.72543"
>> +       inkscape:transform-center-y="-156.15191" />
>> +    <path
>> +       d="m 402.6188,581.69367 c 3.2597,-1.48411 6.4827,-3.04435 
>> 9.7556,-4.50482 -3.5093,6.18331 -7.0396,12.34823 -10.5778,18.51307 
>> -3.575,-6.17798 -7.1683,-12.34815 -10.7354,-18.53146 3.3569,1.50251 
>> 6.685,3.06275 10.0367,4.57314 0,0 0,0 1.5209,-0.0499 z"
>> +       id="path371636-7-61"
>> +       sodipodi:nodetypes="cccccc"
>> +       style="stroke-width:0.262672"
>> +       inkscape:transform-center-x="-416.72543"
>> +       inkscape:transform-center-y="-156.15191" />
>> +    <path
>> +       d="m 402.6188,658.80913 c 3.2597,-1.48411 6.4827,-3.04435 
>> 9.7556,-4.50482 -3.5093,6.18331 -7.0396,12.34823 -10.5778,18.51307 
>> -3.575,-6.17798 -7.1683,-12.34815 -10.7354,-18.53146 3.3569,1.50251 
>> 6.685,3.06275 10.0367,4.57314 0,0 0,0 1.5209,-0.0499 z"
>> +       id="path371636-7-5"
>> +       sodipodi:nodetypes="cccccc"
>> +       style="stroke-width:0.262672"
>> +       inkscape:transform-center-x="-416.72543"
>> +       inkscape:transform-center-y="-156.15191" />
>> +    <path
>> +       d="m 402.6188,732.33782 c 3.2597,-1.48411 6.4827,-3.04435 
>> 9.7556,-4.50482 -3.5093,6.18331 -7.0396,12.34823 -10.5778,18.51307 
>> -3.575,-6.17798 -7.1683,-12.34815 -10.7354,-18.53146 3.3569,1.50251 
>> 6.685,3.06275 10.0367,4.57314 0,0 0,0 1.5209,-0.0499 z"
>> +       id="path371636-7-9"
>> +       sodipodi:nodetypes="cccccc"
>> +       style="stroke-width:0.262672"
>> +       inkscape:transform-center-x="-416.72543"
>> +       inkscape:transform-center-y="-156.15191" />
>> +    <path
>> +       d="m 402.4121,800.48637 c 3.2597,-1.48411 6.4827,-3.04435 
>> 9.7556,-4.50482 -3.5093,6.18331 -7.0396,12.34823 -10.5778,18.51307 
>> -3.575,-6.17798 -7.1683,-12.34815 -10.7354,-18.53146 3.3569,1.50251 
>> 6.685,3.06275 10.0367,4.57314 0,0 0,0 1.5209,-0.0499 z"
>> +       id="path371636-7-4"
>> +       sodipodi:nodetypes="cccccc"
>> +       style="stroke-width:0.262672"
>> +       inkscape:transform-center-x="-416.72543"
>> +       inkscape:transform-center-y="-156.15191" />
>> +    <path
>> +       d="m 402.2055,875.80845 c 3.2597,-1.48411 6.4827,-3.04435 
>> 9.7556,-4.50482 -3.5093,6.18331 -7.0396,12.34823 -10.5778,18.51307 
>> -3.575,-6.17798 -7.1683,-12.34815 -10.7354,-18.53146 3.3569,1.50251 
>> 6.685,3.06275 10.0367,4.57314 0,0 0,0 1.5209,-0.0499 z"
>> +       id="path371636-7-90"
>> +       sodipodi:nodetypes="cccccc"
>> +       style="stroke-width:0.262672"
>> +       inkscape:transform-center-x="-416.72543"
>> +       inkscape:transform-center-y="-156.15191" />
>> +    <path
>> +       d="m 400.4121,942.16362 c 3.2597,-1.48411 6.4827,-3.04435 
>> 9.7556,-4.50482 -3.5093,6.18331 -7.0396,12.34823 -10.5778,18.51307 
>> -3.575,-6.17798 -7.1683,-12.34815 -10.7354,-18.53146 3.3569,1.50251 
>> 6.685,3.06275 10.0367,4.57314 0,0 0,0 1.5209,-0.0499 z"
>> +       id="path371636-7-91"
>> +       sodipodi:nodetypes="cccccc"
>> +       style="stroke-width:0.262672"
>> +       inkscape:transform-center-x="-416.72543"
>> +       inkscape:transform-center-y="-156.15191" />
>> +    <path
>> +       d="m 407.9989,1311.6005 c 3.2597,-1.4841 6.4827,-3.0444 
>> 9.7556,-4.5048 -3.5093,6.1833 -7.0396,12.3482 -10.5778,18.513 
>> -3.575,-6.1779 -7.1683,-12.3481 -10.7354,-18.5314 3.3569,1.5025 
>> 6.685,3.0627 10.0367,4.5731 0,0 0,0 1.5209,-0.05 z"
>> +       id="path371636-7-77"
>> +       sodipodi:nodetypes="cccccc"
>> +       style="stroke-width:0.262672"
>> +       inkscape:transform-center-x="-416.72543"
>> +       inkscape:transform-center-y="-156.15191" />
>> +    <path
>> +       d="m 407.9989,1381.5424 c 3.2597,-1.4841 6.4827,-3.0443 
>> 9.7556,-4.5048 -3.5093,6.1833 -7.0396,12.3482 -10.5778,18.5131 
>> -3.575,-6.178 -7.1683,-12.3482 -10.7354,-18.5315 3.3569,1.5025 
>> 6.685,3.0627 10.0367,4.5731 0,0 0,0 1.5209,-0.05 z"
>> +       id="path371636-7-11"
>> +       sodipodi:nodetypes="cccccc"
>> +       style="stroke-width:0.262672"
>> +       inkscape:transform-center-x="-416.72543"
>> +       inkscape:transform-center-y="-156.15191" />
>> +    <path
>> +       d="m 407.9989,1458.6579 c 3.2597,-1.4841 6.4827,-3.0444 
>> 9.7556,-4.5049 -3.5093,6.1834 -7.0396,12.3483 -10.5778,18.5131 
>> -3.575,-6.178 -7.1683,-12.3481 -10.7354,-18.5314 3.3569,1.5025 
>> 6.685,3.0627 10.0367,4.5731 0,0 0,0 1.5209,-0.05 z"
>> +       id="path371636-7-59"
>> +       sodipodi:nodetypes="cccccc"
>> +       style="stroke-width:0.262672"
>> +       inkscape:transform-center-x="-416.72543"
>> +       inkscape:transform-center-y="-156.15191" />
>> +  </g>
>> +</svg>
>> diff --git a/Documentation/gpu/amdgpu/display/display-manager.rst 
>> b/Documentation/gpu/amdgpu/display/display-manager.rst
>> index b1b0f11aed83..8960a5f1fa66 100644
>> --- a/Documentation/gpu/amdgpu/display/display-manager.rst
>> +++ b/Documentation/gpu/amdgpu/display/display-manager.rst
>> @@ -49,3 +49,38 @@ Color Management Properties
>>   .. kernel-doc:: drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
>>      :internal:
>> +
>> +
>> +DC Color Capabilities between DCN generations
>> +---------------------------------------------
>> +
>> +DRM/KMS framework defines three CRTC color correction properties: 
>> degamma,
>> +color transformation matrix (ctm) and gamma, and two properties for 
>> degamma and
> 
> Abbreviations should be written as all-uppercase
> https://docs.kernel.org/gpu/introduction.html?highlight=uppercase#style-guidelines 
> 
> 
>> +gamma lut sizes. AMD DC programs some of the color correction features
>> +pre-blending but DRM/KMS has not per-plane color correction properties.
>> +
>> +What's possible to do before and after blending has changed quite a 
>> bit between
>> +DCN generations as it depends on hardware color capabilities. DPP and 
>> MPC color
>> +correction caps are described below.
>> +
>> +.. kernel-doc:: drivers/gpu/drm/amd/display/dc/dc.h
>> +   :doc: color-management-caps
>> +
>> +.. kernel-doc:: drivers/gpu/drm/amd/display/dc/dc.h
>> +   :internal:
>> +
>> +In general, the DRM three properties are programed to DC, as follows: 
>> CRT > +gamma after blending, and CRTC degamma pre-blending. Although 
>> CTM is 
> programmed
>> +after blending, it is mapped to DPP hw blocks (pre-blending). Other 
>> color caps
>> +available in the hw is not currently exposed by DRM interface and are by
>> +passed.  To illustrate DCN generation capabilities and differences 
>> between
> 
> possible typo: "by\npassed" -> "bypassed"
> 
>> +them, you can compare the color management schemas for DCN 2.0 and 
>> DCN 3.0
>> +families below.
>> +
>> +**DCN 2.0 family color caps and mapping**
>> +
>> +.. kernel-figure:: dcn2_cm_drm_current.svg
>> +
>> +**DCN 3.0 family color caps and mapping**
>> +
>> +.. kernel-figure:: dcn3_cm_drm_current.svg
>> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h 
>> b/drivers/gpu/drm/amd/display/dc/dc.h
>> index 7c42377f0aae..84275f3974c1 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dc.h
>> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
>> @@ -118,7 +118,26 @@ struct dc_plane_cap {
>>       uint32_t min_height;
>>   };
>> -// Color management caps (DPP and MPC)
>> +/**
>> + * DOC: color-management-caps
>> + *
>> + * **Color management caps (DPP and MPC)**
>> + *
>> + * Modules/color calculates various colour operations which are 
>> translated to
> 
> Nit: colour -> color
> The DRM documentation has a **preference** for the american spelling 
> https://www.kernel.org/doc/html/latest/gpu/introduction.html?highlight=American%20English#style-guidelines 
> 
> 
>> + * abstracted HW. DCE 5-12 had almost no important changes, but 
>> starting with
>> + * DCN1, every new generation comes with fairly major differences in 
>> color
>> + * pipeline. Therefore, we abstract color pipe capabilities so 
>> modules/DM can
>> + * decide mapping to HW block based on logical capabilities.
>> + */
>> +
>> +/**
>> + * struct rom_curve_caps - predefined transfer function caps for 
>> degamma and regamma
>> + * @srgb: RGB color space transfer func
>> + * @bt2020: BT.2020 transfer func
>> + * @gamma2_2: standard gamma
>> + * @pq: perceptual quantizer transfer function
>> + * @hlg: hybrid log–gamma transfer function
>> + */
>>   struct rom_curve_caps {
>>       uint16_t srgb : 1;
>>       uint16_t bt2020 : 1;
>> @@ -127,36 +146,65 @@ struct rom_curve_caps {
>>       uint16_t hlg : 1;
>>   };
>> +/**
>> + * struct dpp_color_caps - color pipeline capabilities for display 
>> pipe and
>> + * plane blocks
>> + *
>> + * @dcn_arch: all DCE generations treated the same
>> + * @input_lut_shared: shared with DGAM. Input lut is different than 
>> most LUTs,
>> + * just plain 256-entry lookup
>> + * @icsc: input color space conversion
> 
> ./drivers/gpu/drm/amd/display/dc/dc.h:181: warning: Function parameter 
> or member 'dgam_ram' not described in 'dpp_color_caps'

Hi,

I was trying to figure out the meaning of some of these fields.


First of all, and in the LUT context, notice that some fields have the 
prefix _ram, and others have _rom. When you see the ram, it means that 
we have a hardware LUT in the device, and we can program its values. If 
you see rom, it also means that we have hardware LUT but have 
pre-hardcoded values, which means that we can only select between a few 
of them (e.g., sRGB, PQ, etc.). I guess ROM is preferable since it 
requires less configuration.

> 
>> + * @post_csc: post color space conversion, before gamut remap
>> + * @gamma_corr: degamma correction
>> + * @hw_3d_lut: 3d lut support. It implies a shaper LUT before, it may 
>> be shared
>> + * with MPC by setting mpc:shared_3d_lut flag
>> + * @ogam_ram: blend gamma

dgam refers to 'degamma'

and

ogam to 'out gamma'.


>> + * @ocsc: output color space conversion
> 
> ./drivers/gpu/drm/amd/display/dc/dc.h:181: warning: Function parameter 
> or member 'dgam_rom_for_yuv' not described in 'dpp_color_caps'

dgam_rom_for_yuv -> I don't know precisely why we have this, but since 
DCN3 introduced it, I guess this is a specific behavior to compute yuv.

afaik, this caps stands for capabilities, i.e., dpp_color_caps describes 
the DPP color capabilities configured for the specific hardware and setup.

Best Regards
Siqueira

> 
>> + * @dgam_rom_caps: caps for degamma
>> + * @ogam_rom_caps: caps for regamma 1D lut
>> + *
>> + * Note: hdr_mult and gamut remap (ctm) are always available in DPP 
>> (in that order)
>> + */
>>   struct dpp_color_caps {
>> -    uint16_t dcn_arch : 1; // all DCE generations treated the same
>> -    // input lut is different than most LUTs, just plain 256-entry 
>> lookup
>> -    uint16_t input_lut_shared : 1; // shared with DGAM
>> +    uint16_t dcn_arch : 1;
>> +    uint16_t input_lut_shared : 1;
>>       uint16_t icsc : 1;
>>       uint16_t dgam_ram : 1;
>> -    uint16_t post_csc : 1; // before gamut remap
>> +    uint16_t post_csc : 1;
>>       uint16_t gamma_corr : 1;
>> -
>> -    // hdr_mult and gamut remap always available in DPP (in that order)
>> -    // 3d lut implies shaper LUT,
>> -    // it may be shared with MPC - check MPC:shared_3d_lut flag
>>       uint16_t hw_3d_lut : 1;
>> -    uint16_t ogam_ram : 1; // blnd gam
>> +    uint16_t ogam_ram : 1;
>>       uint16_t ocsc : 1;
>>       uint16_t dgam_rom_for_yuv : 1;
>>       struct rom_curve_caps dgam_rom_caps;
>>       struct rom_curve_caps ogam_rom_caps;
>>   };
>> +/**
>> + * struct mpc_color_caps - color pipeline capabilities for multiple 
>> pipe and
>> + * plane combined blocks
>> + *
>> + * @gamut_remap: color transformation matrix
> 
> ./drivers/gpu/drm/amd/display/dc/dc.h:201: warning: Function parameter 
> or member 'ogam_ram' not described in 'mpc_color_caps'
> 
>> + * @ocsc: output color space conversion matrix
>> + * @num_3dluts: 3d lut, always assumes a preceding shaper LUT
>> + * @shared_3d_lut: shared 3d lut flag, can be either DPP or MPC, but 
>> single
>> + * instance
>> + * @ogam_rom_caps: caps for regama 1d lut
> 
> typo: regama -> regamma
> 
>> + */
>>   struct mpc_color_caps {
>>       uint16_t gamut_remap : 1;
>>       uint16_t ogam_ram : 1;
>>       uint16_t ocsc : 1;
>> -    uint16_t num_3dluts : 3; //3d lut always assumes a preceding 
>> shaper LUT
>> -    uint16_t shared_3d_lut:1; //can be in either DPP or MPC, but 
>> single instance
>> -
>> +    uint16_t num_3dluts : 3;
>> +    uint16_t shared_3d_lut:1;
>>       struct rom_curve_caps ogam_rom_caps;
>>   };
>> +/**
>> + * struct dc_color_caps - color pipes capabilities for DPP and MPC hw 
>> blocks
>> + * @dpp: color pipes caps for DPP
>> + * @mpc: color pipes caps for MPC
>> + */
>>   struct dc_color_caps {
>>       struct dpp_color_caps dpp;
>>       struct mpc_color_caps mpc;
> 
> 
> Again, thanks for the documentation patch!
> 
> Kind regards,
> Tales Aparecida

