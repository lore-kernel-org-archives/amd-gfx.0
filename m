Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E51E2C4167B
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Nov 2022 00:07:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BBB110E284;
	Wed, 30 Nov 2022 00:07:44 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7CB010E284
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Nov 2022 00:07:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sui+Dv6DWFnBHzT78pyX/VFN6p3gCzA3eXnKWIeAu/R1DuwqoKZcnDKVcjo9VOR+pq91IyuobrblyNkMMqkkFxi56DJ9KCfAxlduNfA6iRG1jqedD+r2SMIHHVsaPfFQGhrqZ7ElH6nbUMvRRKy407EFhcIasPtb73FJSIEjN1M7JiNjpxID/7EuGJnqgDi9TA3NT7wEAgAc4fHtPQO7Ig1weghuDp7vCtGu43zUdWUlu601bmmVT8CKWH7HYnuud+Naqy3MqPpaQVsC/SucknzBz52WaBozf1RrygPL8jUseZliS2eJ0CnM6vTJ1FaWLroujYoXoe6q1WFPAS6tYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Choas/5ykjr7EuLFaU5yr+QH1D7UuCvralMJd2HUryM=;
 b=DtNuSzBFE8dLa3x1win5eOSKRV2DZAKyqt+OU3L3Pi+WKby/UPmlEK05hxl+4PWMgc/c4iEOHa6laSKr3czeXOaIpWPZIrDKfVyuQj5EMeZNjQ5iOg7Wxs/HgomJZbmH/lBhnQVnza6dEWY+daxmXLbUfSY7ER5xyEmiz3JMnHz7+U69dV3HtaGbLKuGr6DgpEeLYmWSUqLUHzosta0KjVKf6ONVl2MOXACyVTGai4QrgN73nq2z5Otvq3THiLWNWnnhAS6i2O1iXPJiOk/4Q5nBJ5BE60E++Dui1WyghNL0zfdLfhqLxWe0rYMYRoPWYvkDn0JUm87tyMdzHOxaPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Choas/5ykjr7EuLFaU5yr+QH1D7UuCvralMJd2HUryM=;
 b=qkCpSOL65mfMv1bn8R9tg3sBavqqMAQDLXpgyQHNK50KUxqqDb9+ye6R9sFt3oQPc7wks+lYAWvQxe4F0mTpviSY7PM3VPRGHVOVj6uXCOpxeBP2iZTupC1xqbvGw/cs/t8IqAOYnNNbH3IFcvlgM7CUyGauytURGE1UXh/z7lM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16)
 by CY5PR12MB6526.namprd12.prod.outlook.com (2603:10b6:930:31::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 00:07:40 +0000
Received: from DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::9f39:64d4:333e:40e5]) by DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::9f39:64d4:333e:40e5%11]) with mapi id 15.20.5857.023; Wed, 30 Nov
 2022 00:07:38 +0000
Content-Type: multipart/alternative;
 boundary="------------K9ncRtIvyF6OizHBFiNp6bJ8"
Message-ID: <e1c1341a-c655-b0ab-dc95-2a07f10e2ba3@amd.com>
Date: Tue, 29 Nov 2022 19:07:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] drm/amdgpu: enable Vangogh VCN indirect sram mode
Content-Language: en-US
To: Leo Liu <leo.liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221130000251.6824-1-leo.liu@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <20221130000251.6824-1-leo.liu@amd.com>
X-ClientProxiedBy: BL0PR02CA0025.namprd02.prod.outlook.com
 (2603:10b6:207:3c::38) To DM5PR12MB1753.namprd12.prod.outlook.com
 (2603:10b6:3:10d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB1753:EE_|CY5PR12MB6526:EE_
X-MS-Office365-Filtering-Correlation-Id: 3412a24e-1198-4c44-2aba-08dad266e41c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u2eBAMDOq7NzgWhS6WYkqXPznQFF27ALjPX4z4SATH838VGiJkRKpS1wvFdVgYe+m6KTWogmQ9kE2rJuIlKxBtNXaaMSqKgOeA4qGsN1dz45YocfT+ESvCno8wr2x4lmFlzsqQOR4dlZPMrprnPyUouU1/ooiBcd0kEIsI6gnMHE9bXmXISLROzHbWRB/Zpp/3HLjehawpeJWDR7QFigsUfN9O73C+3Y2KT//9xzz0yiSj1wQPQgzZXsdQNqRZBARjfhuFKfHNNpIMuSyE28EjW+152jqePUaAeLZJAl1D7cwdHKXHLRGQu92wz4LVtk5o8ns6h597lXDN2O09C2TcYEtpprkYZ35Tksq8cnTytjuG3GB/ZscqzXiH+UzneT23uzg6v2EqelrhKg9fzxBcpJRYmnR7iKcVOvJ0eDdD/0hDvyG71vgIf/FaQLHzq1YHzSZB848oZMR0lF4E5+NF3R1ox9DbmC5MnuuSiRxLP0yd+f7NjXZL/Go69Igop3YOJZyqYaoPkn8/dFu+9aeeaOIzbsxw6dWvPAXz+MyFoJv8M1AmOADKDHLEZgkqMYh9P/S03Jfo9K4SX1EfhEvPxh0s7veyHGnrp4fVE+IG7rXc7kvOMlzPskmiqKUs1sriJoX1aXgrjmMaCoOzyF6XI+MHwS593EHKx1zoPAXT8RODx4qJ9MMIaA3AY1c34nJoW9wHOJL1UqMaHfkAYtmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(39860400002)(376002)(396003)(346002)(136003)(451199015)(66476007)(66556008)(66946007)(4326008)(8936002)(5660300002)(4001150100001)(36756003)(33964004)(41300700001)(31696002)(316002)(26005)(6512007)(6506007)(53546011)(2616005)(186003)(36916002)(38100700002)(6486002)(478600001)(8676002)(2906002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTAyQ0cyQytsblpvUzlPMVNWeEd3dmgzSm40eFh4VEY1cVJnUjJXN2x2eHh5?=
 =?utf-8?B?azgyQkFpWnFUYVJyeEtOekovNGd2T21SbzhVMmZXdmsvQmJaVWxqZHdpeWRC?=
 =?utf-8?B?YVg4YWFROWl6c0kzRUdya25vYUVwVDM3TWZxNi9LZHZabE9SenFiQkV3WFJT?=
 =?utf-8?B?andDaHpnNWM2WTRXNitER3RVTmxORHJFTG1Iem1WN3RxUGFpUHBkODB5VmNl?=
 =?utf-8?B?bFJWLzcxaEZ0dG9MQmZzMTQzM3ZBK3cyd2tJajMxMTBINlUwK3Ixd2s0eUNp?=
 =?utf-8?B?SExWa1plVXpWNVYvbmxUNzBDdmNseTNaRllUMXd1cVBTaVA4UFR6ZTZpRHlG?=
 =?utf-8?B?RGFqWWRrK0xWN1lPdENldmhWaTBKNXVJMks4QXhOK0V5ZlcyTGxTS05SOGxH?=
 =?utf-8?B?R0d5UGp6SG9zaVp0WTJGdkcxRjF3eHNlTkpPSmplbHhmd2tOSzFIVVFYYVg4?=
 =?utf-8?B?WjhwNEZ5QzZ0US81UThCbi9HdG9ORUVzNXdlOGorWjQ3aWFuSVc2azE5S3Z0?=
 =?utf-8?B?VFJKcGZvbGd5WHFvcnduRVdGUm9RNm0xZC8zemNZUGhtYTZMZ3VDd2lma2VK?=
 =?utf-8?B?ZStiMVh3eTNsVXgzcTlPMDN2cWl6OG1ZRHh5Z1FsbVBtMlVMNk9Vb3lGVU1B?=
 =?utf-8?B?aDJINUJoN2J6eGFJbnRvVE9GUlBMQTRwKzh6cWNLamlTN3h1eUdQYkcyQksx?=
 =?utf-8?B?bWJ4MjJaWXFrblZ2VWdUOEJqeC9WWkhCVXA4Q1hheG1EMkdXKzNRZ3NWZ2Y2?=
 =?utf-8?B?NFI1ZXRGU1RLM2xTWkNjelJ6MDNqUnVHOEhEaE1lcFdNVkhOWUQ1OTZZTGY0?=
 =?utf-8?B?ZXYvV2xNMjYyWEtLQVpKYTVpRnRad1NLUjAyTk1oY2E2bEZMZ1U2S1FEcUZr?=
 =?utf-8?B?R0szK1k1anVZb2N1Lyt4QUZJZGUvZGRiSndTU0k1UXRzSGRrbzhyQkRiNFdR?=
 =?utf-8?B?dEV1cytuUGwzNHU5RzJ4amdQN2JIOTNhUHA2cytUMUcwMVMrRWZqN2w1K1NM?=
 =?utf-8?B?U0dGOWd3Q2M3VXJhZ3FLenpUenF4VjQ1TUtjSm9vZmpabC81UzJkcnA5d0hk?=
 =?utf-8?B?enIxTXUxMEtLNDZwZWdmMFRtOG1PaGp2RWhCRG5tS2thWWx5ZUpiM1ZXTGpY?=
 =?utf-8?B?bVJvVHRZekhnUFlwMm0wRXNPREo3VU5rMThrOFUwRzZDcmJoR2RSQ0Z0MXB4?=
 =?utf-8?B?TWwxQ2VWdzNGZjRWckpMNG5KdGkzcXFIbFV4ck40TW9vUUdXRE1EV25HRjlq?=
 =?utf-8?B?WE5pc1p4SlIyUWRMTVdCYVlUazZuS0dUdE5VZENjU1JlT2s5SCtVZFI4YUdv?=
 =?utf-8?B?K25xdEZSMStaTDlEck9lUk5VMlJEK1RhMVVRK0FSNEwwUC9sakVwaDREeFNG?=
 =?utf-8?B?Zm96TGJOTGNycTNidWxBckRzSTZFUndXTmZKYjViek80akVrWWJtSi9CY29o?=
 =?utf-8?B?Z2ZCemFzcngvSitZVCtHRjljZU01RGRoUnE0aG9QdERnbWpPOHFJT2toeTdC?=
 =?utf-8?B?L0pQYkVBeFlRdmJ2OWxTRUE0YW1hNWRGTFRhdFN1bmdtY3NFakpSY29jVXNp?=
 =?utf-8?B?VTFPRVdxZ1dMMnF6S2l1b3BoQS85RmpCb3Y4THAzb0xPVnplQlFJRFpQVU9u?=
 =?utf-8?B?UWwvUEhmY1RHa2Iya3hkaVdpb3VKdVpPK3VackQzWVdCald0aFE5UEtjQy84?=
 =?utf-8?B?K1FTY2toSWlkYmI2V3B5OHVtZFcwQTlvRDhzMDhwT0VaZFRTYXZKbWFaYWJI?=
 =?utf-8?B?NEI5N281eHBTTGFzdkNWRUpxZlo1eWYzZUhZb2dOM01rQ3BtMUxyTDhhNm82?=
 =?utf-8?B?cnR2NmlkeXlBd0RtbHpMenFGNEd6MEtjVDVVejhBUVNhRUlRMDB5L1NkbTQx?=
 =?utf-8?B?b0JCOFZZV01MV1UzQWlHaWZ1Z3JLSzBPbGtyaFhvaDVGTUFaV2N0RzU0aXJu?=
 =?utf-8?B?Sk9LV28yUlhkTHdLTjZ3Unh1SndhZmttTllCYS8xcWMxNUtiTjVqY1hvdmg0?=
 =?utf-8?B?Mnd0TGhQQ2F1cnArWk1mVEVQQTR6TUJ3MnBkWVBveENFNUJ6UWMvdE9tRUkr?=
 =?utf-8?B?MkNId0toNkdZbWJSVnNSd09sWjBlT3RxQ2UvL0FQRDNlbTdhRUxHKzAwcmZq?=
 =?utf-8?Q?AzvQOk8Hd3S4A960+sKmkajf8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3412a24e-1198-4c44-2aba-08dad266e41c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 00:07:38.3613 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SQwlzya2rDIIY7obfASU0hZYiHrRwoZSAbi2eaHRvw+pPSNQc8jhEoEhHjF0OB6S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6526
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
Cc: James.Zhu@amd.com, richardqi.liang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------K9ncRtIvyF6OizHBFiNp6bJ8
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

ThispatchisReviewed-by:JamesZhu<James.Zhu@amd.com>

On 2022-11-29 19:02, Leo Liu wrote:
> So that uses PSP to initialize HW.
>
> Fixes: 0c2c02b6 (drm/amdgpu/vcn: add firmware support for dimgrey_cavefish)
>
> Signed-off-by: Leo Liu<leo.liu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index c448c1bdf84d..72fa14ff862f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -156,6 +156,9 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
>   		break;
>   	case IP_VERSION(3, 0, 2):
>   		fw_name = FIRMWARE_VANGOGH;
> +		if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
> +		    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
> +			adev->vcn.indirect_sram = true;
>   		break;
>   	case IP_VERSION(3, 0, 16):
>   		fw_name = FIRMWARE_DIMGREY_CAVEFISH;
--------------K9ncRtIvyF6OizHBFiNp6bJ8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>
</p>
    <pre style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;">This<span style=" color:#c0c0c0;"> </span>patch<span style=" color:#c0c0c0;"> </span>is<span style=" color:#c0c0c0;"> </span>Reviewed-by:<span style=" color:#c0c0c0;"> </span>James<span style=" color:#c0c0c0;"> </span>Zhu<span style=" color:#c0c0c0;"> </span><a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a></pre>
    <p><style type="text/css">p, li { white-space: pre-wrap; }</style></p>
    <div class="moz-cite-prefix">On 2022-11-29 19:02, Leo Liu wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20221130000251.6824-1-leo.liu@amd.com">
      <pre class="moz-quote-pre" wrap="">So that uses PSP to initialize HW.

Fixes: 0c2c02b6 (drm/amdgpu/vcn: add firmware support for dimgrey_cavefish)

Signed-off-by: Leo Liu <a class="moz-txt-link-rfc2396E" href="mailto:leo.liu@amd.com">&lt;leo.liu@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index c448c1bdf84d..72fa14ff862f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -156,6 +156,9 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 		break;
 	case IP_VERSION(3, 0, 2):
 		fw_name = FIRMWARE_VANGOGH;
+		if ((adev-&gt;firmware.load_type == AMDGPU_FW_LOAD_PSP) &amp;&amp;
+		    (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG))
+			adev-&gt;vcn.indirect_sram = true;
 		break;
 	case IP_VERSION(3, 0, 16):
 		fw_name = FIRMWARE_DIMGREY_CAVEFISH;
</pre>
    </blockquote>
  </body>
</html>

--------------K9ncRtIvyF6OizHBFiNp6bJ8--
