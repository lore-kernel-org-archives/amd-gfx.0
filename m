Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF5CC352A1
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Dec 2022 07:43:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E49C010E071;
	Wed,  7 Dec 2022 07:43:22 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83E1510E071;
 Wed,  7 Dec 2022 07:43:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZ+Bk/Pw+Noj07zylEpHW8xzmpGPzdd83iBS9Zq6W9N/vyP4TV0FENVauDR0tqs8ySQGv1SZyLLm/Ktde38Be8KqvvJ6iAAm+pZY1KKSXOxMSU03sqHrKomNiL0a6Ap25gInuhbU1RPZ+bOTY2bkdY6vdqNMcFUBZDzFXtXoDDBQrafH4QUqCF65Magiwyzgb+F6Z6z4whSxScXxXcuNSSs02rFBXZ/FB8+R2ZS+HnpUjVKpGrwbjCxkp1ARIvFn1WYurJrSW2DZrrPORIuYGeKKYyztMjZeJw3OuaLnDaIrQBVhpK54n1Db7rcrmPt/kfw6OIv5xF+9Vfe/ZI2FNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ouLHp1qLdfQw+wxIXWRNx2UM6e9LcQ10WU7eA5i63eo=;
 b=GWSLOLGrauLBytO3nhoK2awQDEv4xgBOdZWfzr11GdSECaFGreacdrorzjuvlIJIuB5uAGEZFxGxxVRFGFaEcgEU8fkdV2GTk4sEXWr6RlNlaLzsuV4sPTnwZknxAfXhXy67dlVaAfgHeu4q1MIUVkT8OsT8hGrZU/EnzmDX6w+Fdyc/CG6do79oFNFBNvR5NI0YKYr37qJNk1UuTVYX5BtV8vxoGlJ5mZhbKUlx7wT3rZZ0jqS5J1bK+XN81tRv+tqmNc4kZ6EZgi7H1Lxo9PX/iT6B3VI/Z+3i7k1Ng/8zY0Piad3cqbGjTY5u4BJW241IFVtKgFAGavA4vSURQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouLHp1qLdfQw+wxIXWRNx2UM6e9LcQ10WU7eA5i63eo=;
 b=Aj0MrfH/+aBhU4e3LJsDuCWWlnDENnCarMSzFGAZviVOZ9iJ3OuOldDzFb0skY7xl+HDGI69NkPvWJ7qt+IlZBdrLsbDxaLzVh16ie+fs8hwFqQjUku1fvZ0iCgFBPcuOJRVJ3RMqpEjhXZ6QUrRhbFAJYf6ifAkAKqrgIKaHIE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BL1PR12MB5302.namprd12.prod.outlook.com (2603:10b6:208:31d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 07:43:17 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421%7]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 07:43:16 +0000
Content-Type: multipart/alternative;
 boundary="------------mfdCVhBV54AGlBBUtpmFI4it"
Message-ID: <f62f42b4-89ba-0efc-0f98-06a65630a532@amd.com>
Date: Wed, 7 Dec 2022 08:43:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdgpu: try allowed domain when pin framebuffer failed
Content-Language: en-US
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>,
 "Zhang, Yifan" <Yifan1.Zhang@amd.com>
References: <DM4PR12MB51524585CEC4E2B4B8370874E31A9@DM4PR12MB5152.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <DM4PR12MB51524585CEC4E2B4B8370874E31A9@DM4PR12MB5152.namprd12.prod.outlook.com>
X-ClientProxiedBy: FR3P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::19) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|BL1PR12MB5302:EE_
X-MS-Office365-Filtering-Correlation-Id: d429ee1b-6162-4b70-c0c6-08dad826b403
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xpnCIjg4/+kTEoC3/CA1JU2133zbxF84pEn79QveQhmDIr2emJoYfw0a30HDZ79lTd+XfQIKGRKN7b6T10b1e73CmLNZqQDWhY/Ajm7O/2H25ZEUZHTlb/lbgjq3EvaRxNsYGVTFP+MWTH1xyiRRmuW7REFPpEFvk54xa8mpl1VklVHLBgmroeP4aOb40aE1Ar4xcTovEPf1/ef+46hQkKTTZUnyXwFBXCHmIbEvnpVP0sHrAiUib4r/qTpbsGIp5P2Pr4yUg0QgRx2v9KnGTkrgYwLh7RDq5VUG99tId6wrP6Yp1bGTnI3ixXwKYmwYY02LXUyM75kld81RnhsQzDcToZdnYkzkVGbGRFiu5A/3Gyt8Nz11ajt7lI2Dx/Ttz84LaumWImzriPZSrAaTEmuken40qQ8/skI1LinsA0WvKvvs6Jff9HcAeFiTd2xBFi0tFXanetwb/qq8G47b5+Ad+2zM4DUPl4KxvsOCs2xxhmlEpstRki24Hh9nuJO5hE+t8ZBsmZTg8iOJQzYeGRtWFEc7tkhX4x3drJRkWYC7vpxh8SatVmVUA9ALP9UR+PkW4/z4f97TosacyeOr6qRewJuVTZ7w2aDq1XjXY/lo7FD0GjbQDqT7ybvlLlgOT/thvgDXg3UFMpqhut4Cf4LGFGEut0L3kNMSZvDGJEG3T920p0TVx5RLNzuv9/06PZ2PgXW7z0Yyq3BaYPe0tegPcvliSPquwZfCc5JKdubuXG0C2DL40/m1YceB638h+kqT1SAnt6WPOYowV+fWM6o16D797Ao0NjsJrYzbsLU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(136003)(39860400002)(376002)(396003)(346002)(451199015)(83380400001)(31686004)(41300700001)(86362001)(6486002)(316002)(38100700002)(31696002)(8936002)(5660300002)(4326008)(2906002)(8676002)(450100002)(33964004)(6666004)(66946007)(6506007)(186003)(6512007)(6636002)(66556008)(54906003)(2616005)(66476007)(478600001)(110136005)(36756003)(43740500002)(45980500001)(414714003)(473944003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjNSaTdxaWZld0RwSE1QNE56N0o1Tmc4NkNVbm5jWE8rUngremoxRFNrMTQv?=
 =?utf-8?B?TVQrNE9ONE4wQkp0WmUzMURyVXVlY2V4Y2UyU2pmT0Zob1Q2VHhmcUFveGJl?=
 =?utf-8?B?NXN6bU1aaFVENmNsQ25JcEZJTEFDbGxkUmVpOFlpNzlRU2h3dXVzUjhFMEFR?=
 =?utf-8?B?bFRpZE9wK0JicjdOeVpYdkRDOFhUcTd3Ylg0MVBqczVPS2ZxVkFrV0ZZQ2dO?=
 =?utf-8?B?a1Y4UUxwUkhjQmNCcjlXenh4QndDYzFjbyszWWxaWmVlNnBtSEN4eTdBSzRL?=
 =?utf-8?B?Z0xuL2lYaXd2NzZtOWpaWVFzNUhFUHFwdmRibnlGbHB1TXhUTlBaUFdoVVFy?=
 =?utf-8?B?aFFlcGN2UnJwWXVPZG1SY2dVc1VBR25rQmUwNzVHYUFwM2V3YTJzY21RSFov?=
 =?utf-8?B?UFdBcjBLQ3N4a3RKUWcvSlBKYmVXSnJRcjAwSVJoZkxoaEl5SFNySzZvWGRD?=
 =?utf-8?B?VFJkWGI3VnFWSklvWnNReEdsZ2s4QWNEVm9JTzNQNlRwZHBLNVpYdGhhVFB5?=
 =?utf-8?B?UnExeDI0ZlQwNzFwb3EzK1I5blp4QzZQVW1OZ25YSDdIQmIzQ1l1RXE5bThw?=
 =?utf-8?B?TWpVYmtCMVo5aC83U2RvR0Z6cW5xSzRlclRKeVhrdVVHMVR5TWY0NWZZR0tu?=
 =?utf-8?B?Q21ucGZ6R3FEbE5udldOUml2UXp4OWo5S2JTSEFEd3lPNUJJRUhaRTJUbFFt?=
 =?utf-8?B?a2xVVEUzWW1OUGlZVktERkk1eFF2V3UxTk56N1RYdytKek0yU0g4YjdUeHNH?=
 =?utf-8?B?ZWtTTzJzN2cwZmVueGJtR3dMTndYa2tmVEQrUE9pQS92M0sxcHpvKzRiL1py?=
 =?utf-8?B?NE4yaU5hR1cvbVZ3dmZzTDh0a1ZadnlKUUdsVXNlNTVXcVA1OERHc2k3clVD?=
 =?utf-8?B?MTJEZDlTdUxWOGhQR0xWN0RqWjhQcTRqTUxrYkFGSTJhbVlQcWF5NkRJSWVu?=
 =?utf-8?B?cFR4UlJmbnFRcFdhM2NOTEwrSU9hN2hsQ2E4cmNMMUIwNTM5WUphRk1JamxT?=
 =?utf-8?B?WnlsWHlHM2M4MGVPTkxHMXU1d2RnYk9KNlZkTlhJbU1OWGFpQ1JWRUtma0tK?=
 =?utf-8?B?MU4xTDV5SjdpaitBUlgzak44MlNLWG1JK0lVSGVXS3E2Y3JZay9QK3Z5KzFV?=
 =?utf-8?B?NTF2aDlsVGVSUy9yNWwwYnI0UTRuRU1QZXV6K1RNR29kaEZ4aER2UGFQQUk1?=
 =?utf-8?B?dHZYTVMyZVZhUTdoTVMxNUhlUTJ0ZmFhYVMyU0Y0RUd6c1M5NXVUMWxiakM0?=
 =?utf-8?B?VXBzcXNvaFkrTXovWjNSR05hVkozU3hMR2dmSVd1WHkwd0tydXNKN1ZUNjNB?=
 =?utf-8?B?Zlg4U2xmVWRFM2R1TDFhOUFUaW1ad3ZaZURZbnNvZUV6R1ltSWtsSnlJcHlD?=
 =?utf-8?B?Q000RmIzcHB5cTJDZURpY0xrNVhWUFNaUmNoUVl0bDYydmZLVmZidmZ3WFhq?=
 =?utf-8?B?dTFTYzFuL1lKbHFnNi84L3NxOU5kT1ZrczRCUDVEMVdRTjVJU3ZnU2c5TmNJ?=
 =?utf-8?B?czYrWUJCSE5FalgzZXovVzdlZnArMWl6STlGM0RhSE50cHVMM1UxUXB6R2Mz?=
 =?utf-8?B?V1lrbDJCdjRlK2dpanVNcC9PZkYzcjVVUmorbWt5RmF1bU53R0M5WjNISU5q?=
 =?utf-8?B?bGViaVZRbTVScDRkRW40aS9uMm1VRFk2OHMwZG1IVU1pZEJ6TnQ5eEg3QlJH?=
 =?utf-8?B?UGVSWWp6ZkZjeTgzVy9VV3pZQldTZmxLNmd4ejNiZ0VYNkxKSnovSDAzN050?=
 =?utf-8?B?OXp3eVlPVTdGZGJDbTBRZ0RxdFpWM055STVEbDN6RWNFWEo5YjRCR0NXQnBO?=
 =?utf-8?B?cERYTG1lNWFTZ1N4SHJzUXJIM0VmUmoxSjZoM0l2c2xiTUV4ZG9hNDRWRjdY?=
 =?utf-8?B?U2dwa29yRE9yYUxBRi9xYkZZdXoreDZwYXQrNkt5Njd2STV5MC9vUzE3UGtU?=
 =?utf-8?B?ODVMUVVkNm1zTTNzTGsxTjJGekcycFdtYkJtcDJ4eW5yQk1vRHBlZVA5ajl0?=
 =?utf-8?B?WlNwQ0hVci9abE1vSW9oQlYxU2hqYldVT3FnSnQyTklnbGNrNkdBSDhaU0Z4?=
 =?utf-8?B?UE1XdlBNQWRDVWRzaW1DQzRYYXlteUdsSXRYVGtHbW1YZmMwamJGdE9GbWlW?=
 =?utf-8?B?Vm1HQlFmZWNadm5ISlY5YkQrMmdKZXQvcDh3NnlxS0l1dm05QkJ6djJLREUr?=
 =?utf-8?Q?Kddo168bD6kS1T8ze/vmRrND5D3I93DDueGESpvE/U9o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d429ee1b-6162-4b70-c0c6-08dad826b403
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 07:43:16.9035 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y7HOYJHAD6Fudfun1+wEccFqX9XPCXbhwcyPJPVCapAOAFU2vLF5MVnQDpTldJLw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5302
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
Cc: amd-gfx <amd-gfx-bounces@lists.freedesktop.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------mfdCVhBV54AGlBBUtpmFI4it
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 07.12.22 um 08:27 schrieb Zhang, Jesse(Jie):
>
> [AMD Official Use Only - General]
>
>
>     drm/amdgpu: try allowed domain when pin framebuffer failed.
>
>     [WHY&HOW]
>
>     in some scenarios, the allocate memory often failed. such as do 
> hot plug or play games.
>
>     so we can try allowed domain, if the preferred domain cannot 
> allocate memory.
>

Not sure why you send it again, but this patch is still a pretty clear NAK.

Christian.

>     Signed-off-by: jie1zhan jesse.zhang@amd.com
>
>     Change-Id: I4b62e2ff072d02c515f901000a5789339d481273
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>
> index 1ae0c8723348..05fcaf7f9d92 100644
>
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>
> @@ -39,6 +39,7 @@
>
> #include "amdgpu.h"
>
> #include "amdgpu_trace.h"
>
> #include "amdgpu_amdkfd.h"
>
> +#include "amdgpu_display.h"
>
> /**
>
>   * DOC: amdgpu_object
>
> @@ -942,8 +943,14 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo 
> *bo, u32 domain,
>
>         bo->placements[i].lpfn = lpfn;
>
>         }
>
> +       retry:
>
>         r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>
>         if (unlikely(r)) {
>
> +               //try allowed domain when pin failed. just a workaround.
>
> +               if (unlikely(r == -ENOMEM) && domain != 
> bo->allowed_domains) {
>
> + amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
>
> +                       goto retry;
>
> +               }
>
>                 dev_err(adev->dev, "%p pin failed\n", bo);
>
>                 goto error;
>
>         }
>

--------------mfdCVhBV54AGlBBUtpmFI4it
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Am 07.12.22 um 08:27 schrieb Zhang, Jesse(Jie):<br>
    <blockquote type="cite" cite="mid:DM4PR12MB51524585CEC4E2B4B8370874E31A9@DM4PR12MB5152.namprd12.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <p class="msipheaderdf3d92d6" style="margin:0" align="Left"><span style="font-size:10.0pt;font-family:Arial;color:#0000FF">[AMD
          Official Use Only - General]</span></p>
      <br>
      <div class="WordSection1">
        <p class="MsoNormal">&nbsp;&nbsp;&nbsp; drm/amdgpu: try allowed domain when pin
          framebuffer failed.<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">&nbsp;&nbsp;&nbsp; [WHY&amp;HOW]<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">&nbsp;&nbsp;&nbsp; in some scenarios, the allocate memory
          often failed. such as do hot plug or play games.<o:p></o:p></p>
        <p class="MsoNormal">&nbsp;&nbsp;&nbsp; so we can try allowed domain, if the
          preferred domain cannot allocate memory.</p>
      </div>
    </blockquote>
    <br>
    Not sure why you send it again, but this patch is still a pretty
    clear NAK.<br>
    <br>
    Christian.<br>
    <br>
    <blockquote type="cite" cite="mid:DM4PR12MB51524585CEC4E2B4B8370874E31A9@DM4PR12MB5152.namprd12.prod.outlook.com">
      <div class="WordSection1">
        <p class="MsoNormal"><o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">&nbsp;&nbsp;&nbsp; Signed-off-by: jie1zhan <a href="mailto:jesse.zhang@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">
            jesse.zhang@amd.com</a><o:p></o:p></p>
        <p class="MsoNormal">&nbsp;&nbsp;&nbsp; Change-Id:
          I4b62e2ff072d02c515f901000a5789339d481273<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">diff --git
          a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<o:p></o:p></p>
        <p class="MsoNormal">index 1ae0c8723348..05fcaf7f9d92 100644<o:p></o:p></p>
        <p class="MsoNormal">---
          a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<o:p></o:p></p>
        <p class="MsoNormal">+++
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<o:p></o:p></p>
        <p class="MsoNormal">@@ -39,6 +39,7 @@<o:p></o:p></p>
        <p class="MsoNormal">#include &quot;amdgpu.h&quot;<o:p></o:p></p>
        <p class="MsoNormal">#include &quot;amdgpu_trace.h&quot;<o:p></o:p></p>
        <p class="MsoNormal">#include &quot;amdgpu_amdkfd.h&quot;<o:p></o:p></p>
        <p class="MsoNormal">+#include &quot;amdgpu_display.h&quot;<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">/**<o:p></o:p></p>
        <p class="MsoNormal">&nbsp; * DOC: amdgpu_object<o:p></o:p></p>
        <p class="MsoNormal">@@ -942,8 +943,14 @@ int
          amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,<o:p></o:p></p>
        <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bo-&gt;placements[i].lpfn = lpfn;<o:p></o:p></p>
        <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retry:<o:p></o:p></p>
        <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
          ttm_bo_validate(&amp;bo-&gt;tbo, &amp;bo-&gt;placement,
          &amp;ctx);<o:p></o:p></p>
        <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(r)) {<o:p></o:p></p>
        <p class="MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //try allowed domain when
          pin failed. just a workaround.<o:p></o:p></p>
        <p class="MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(r == -ENOMEM)
          &amp;&amp; domain != bo-&gt;allowed_domains) {<o:p></o:p></p>
        <p class="MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          amdgpu_bo_placement_from_domain(bo, bo-&gt;allowed_domains);<o:p></o:p></p>
        <p class="MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto retry;<o:p></o:p></p>
        <p class="MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
        <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;%p
          pin failed\n&quot;, bo);<o:p></o:p></p>
        <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error;<o:p></o:p></p>
        <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------mfdCVhBV54AGlBBUtpmFI4it--
