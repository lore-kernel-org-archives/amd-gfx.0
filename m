Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 976FFC4321E
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Dec 2022 21:55:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA73910E672;
	Thu,  1 Dec 2022 21:55:06 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DB6210E672
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Dec 2022 21:55:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHEL9g8sdpLuNXHZaK2j4uhC7APYChYjC36n6+r5Om16iUrRNQg+dmM7fFPhy1Tpqq1soJcud0RLfe7eJOke6s3ci0uGzKS9vc0irZwLUWbtLBy+QmkrSSUktEindu19lP6Y1K/9J6m6F6uJSdK86K39qkS0X8OJBqOskla4jG/bIWcq5KYzODNmQq4gtHEwIBVEh0OIwqgwohDJgCjtFjgYV6toeVDbPLu9hZpdCuQCl6DuzIW+aG05g4FTf/lV3aTfKUywfZsK63MRsAlVfcS3u64x51nkcDxQPJP/Aw4GIVzi9XJcq6O8Kt9sFm6U3Uz0YdRXtlTH+QcsYxWozw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KcmlfcLAccwmZtQfkAtb3owAPMN/LPexUgM3MOZjj1E=;
 b=BvVU4Ybbt/1wI5HzIjXSfKGu/2BhAxiJGwtRLZXdAi9nf8ALtN5rHxB2X48Ao9tbJ8MOANVJOPvi5ZnG0+pN/lFN8OuqA1gHMTKVAKQk/Hbew1E7NisICR6dQTDgsYxipTpcfWdbaKFqQzidzQ8647wTg6qJLTh0lb1HhjiFvOvQzZQUSBW5saU+fvdb4XbmZAKfEXariIJd3/wus0sMZ0MtQGo6iaj1wY/SZ2nnfPUH0EdsidtVX9bhIbpHEE1yhgeKwLL4RgPb6rOsCGA8AdhbnrfEz5BOpT1bx3SoGGHbvpC89XN18KOiYmbxTZov9PfAO+yBGY4jf9x+xfGGhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcmlfcLAccwmZtQfkAtb3owAPMN/LPexUgM3MOZjj1E=;
 b=jFPI7xsrEXVwasFMOzwUWCdU54Rjr9WSNz0gRDntHdhXmww167EtgSLtKzLcvFF1zG66px4ogApYJCPveEeAhsHic0A6uIukfiwm/gtUXIbOTpsnfD4SQY1kCWffZww8cNT5z225doSF8mP0ObMU2Bk43nPyzVfHZ8zpieZ+NVI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ0PR12MB5485.namprd12.prod.outlook.com (2603:10b6:a03:305::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Thu, 1 Dec
 2022 21:54:58 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350%3]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 21:54:58 +0000
Message-ID: <bd1c195d-eac3-d83e-ba84-7a2e38fcafcb@amd.com>
Date: Thu, 1 Dec 2022 16:54:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/3] drm/amdgpu: mention RDNA support in docu
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
References: <20221201153820.257570-1-bellosilicio@gmail.com>
 <20221201153820.257570-4-bellosilicio@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20221201153820.257570-4-bellosilicio@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:610:52::29) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ0PR12MB5485:EE_
X-MS-Office365-Filtering-Correlation-Id: b73e1a64-4dc4-4e48-5306-08dad3e6b06c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QXbhxMcLipsxNxKTbLToQANUCCsDxbH4I0VTP0WCPO5xfF0wmO69JsjJMveln4f47FJ8fxa7y9xV2LcBVmZ5yTv6kf+TZApbaNCAhGzEEQW4QBB9QYFvqearHMYT0XR1oeD3HUv4CxuWUrerwz9fqVez2rdmpn6ZjOVxRFKA0kMgBx1kRZdocGDdZPcKMoYacuEXwq+VMCb9hBuCvkb4SiSJRWm1Q+CFHlVQK6r+Sg6M3Bii2NMMlUEHrFpIMtVMKsLvMa2DJygu9aDsQSU85dy4PnWnXzrI2lGzKefzaM0psbolN3oNm7qkq8C6REf8Dprxp9m6t5cN13mAwUhrkywBkajh+XSGO77fnUT7R1FyeI16O+dQkH3GZNj0+6OhN8TTCkiUF9owxN8bfwrFN9A6thL/nDSBF3+OR2K0hOTCdIHe+8SuzzGx82ktgw5wxi/RZ15of1f1hAq/nD7jGYAWyJty3W4qXARelPcSOv5Buw5QLFYney5UkY3NDQUGlWfpETNkpWY9nMg2aZEGQjAYyqIRuMXLplj568RHBdhhRXK9Pims96ufRrrzqzUDL0LGZDE4mLZsIBrpPchHddOBXzzfbUAIuieAbbteRfkdl3NjoejzzH3rix4BihWn60nf+FQDducRNMgriafoHLMHZBV0/lU4zl8xDrCUbaKm+3yZNqYppMIQ/nvy7OLnNOBoIIjRsVAe4uLrGi4X9vgYVlYclckd8wnDGaCjCNQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(451199015)(8676002)(6512007)(26005)(6506007)(31696002)(86362001)(83380400001)(66946007)(66556008)(66476007)(53546011)(31686004)(36756003)(36916002)(478600001)(44832011)(8936002)(5660300002)(6486002)(186003)(2616005)(6916009)(316002)(2906002)(41300700001)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGNsaGEwaEMvWW5FSDB1VVhIQnN1ak9MQnpQZDRGVTFhdHo0aVI2V2ZoL1U2?=
 =?utf-8?B?SEp3ZDZJWjJTcmhxSitIMkNQTVR1UmNwMW1WQmxoeHFkbnBVNVFEdmRvc3hs?=
 =?utf-8?B?VkJBYUZvQ0FhdlBTU3hTS0RNZTIxVGhPSitDbGpKZHk5K3NKOG82dUZSNWs0?=
 =?utf-8?B?SXFsT1hCREVjeFg5OWpaNGhzd3p1aFJRa3FtZ1lRL2k5WXdjUGdUdGxlQkpj?=
 =?utf-8?B?bC9od3JIU1RuZGZrclUrelpISDNwNkdWaXBjREJwbElBYUJkcWRxand0MDk2?=
 =?utf-8?B?N3VlU3BpdzFTT2RLUnE2VGZYaWtqNjBZbDFtcDVtMm94UDI0SjFUYlJDSnZO?=
 =?utf-8?B?ZERleElpZDUrTHpwSGRhU0xINVRQeE1XSWRWa0JTMVJrZUd0U3JrdG9zUTBh?=
 =?utf-8?B?bUpvMDh2NHV5WXpaS1hyYlRoRkpHTXdad1VzRlZZallDQTI5NE9BZ1NHZ3dI?=
 =?utf-8?B?Q2dscWNpK1pMR1ZWeDVKamNUdUNLaHN3cDdZdWRuOEthaWpRbjhDdjJtOElt?=
 =?utf-8?B?bE82U2JTRTZPbWMyQldQWXphSWF3b0pJNU1JSlUxRlJVOTUrK1RjcW1ZbzhS?=
 =?utf-8?B?ZFNUd3g0eWcrMlZRWUsrdU5TTkNQZ2hsVzBOc2R4N0ltQklhVFE0SWxpQ2Nv?=
 =?utf-8?B?dE43QjBncm1Ga3R5TXRNUjBFWVErYThnTDc3WHArN1hYYU05Tk1tT3pSUFhK?=
 =?utf-8?B?Z2J5b3N5anZtV25Eckp3eVhicFhQY2tjVEZFckRlSCtDWFZaRXBQUGlPeHRM?=
 =?utf-8?B?YW9JdGhiN2F6enVqQkJlQmx6T2Vxa1N6VENpczlQMm1UTVF5NjhhMGxnSUhs?=
 =?utf-8?B?L3RCSlk0TU1JZmpndUd2SnM4WjQ4RzhlT3pCRFd4dWU0Q3hFL3I0dkdHd2Zk?=
 =?utf-8?B?MittY3E2N01VUEVWMXJZamwweHRZZm1zZWpaMU9ZdlhoeFFCU1RpWERaVFFH?=
 =?utf-8?B?cUZkMnhTN0FNSWhYMm1Zejd0dzBaa2kwOXZwVUNRK1lhZUhFMlpza1FrUWJM?=
 =?utf-8?B?VjYvS1NiaUpvQ1FXbG11SFBDWkYyakZRRFArV21lSDllQXdEZ25TdjJLajZ4?=
 =?utf-8?B?NHk3dVA4YkR0aFQ5bGl2Snd5dlA1enhHZk01RGhsTk81cjNDZ3BEOVQrcVVy?=
 =?utf-8?B?STh5S3dQNmVZbi9uNkViRitUd00wMXVlVldoVDJndTRQZ3FKMmVBOVZna0tD?=
 =?utf-8?B?Y1FGMnN2eG5WSlRFZU5DVHBFNXhjMEUzMVVjYU1rNTJpUDYrdCtndXVoV0JN?=
 =?utf-8?B?WCtzaDl2Z1RnOVVJMHdlay9MME9rSDlpdjJYd1dLVmg2dU11QWVWQTM1YmRV?=
 =?utf-8?B?ZDBjNkUvOGdBeFYzMnQvMVZhMWZneDc3QlMrVmNRU05ZUUFuL0ZhRzZFOEFY?=
 =?utf-8?B?R2lzUEZLNlZ0c1NaRTlHYzllZ1dIbC9WK0FNbWdJWTZqS0NOY280b09TVWRm?=
 =?utf-8?B?QjhZK245Znp2R1VYMUQ3dGY2ODRsaG9WdUpMN0tWaVlGZ1lGK0FTUDJ6cFFB?=
 =?utf-8?B?YmRiSXJRcmZRQ3BsR1J5S1ZnMnpVYk5TUi92My93YVFhZ2tXY3orTkowUGJ1?=
 =?utf-8?B?eVc0RSt4NHVtSU5nRDM1OE9xcCtNckh0bGhmd252KzJrNDBpVG5uNGdsUE1K?=
 =?utf-8?B?bmoyaWxiRHlGU2hrSHdRaTNWVzN4ckJPZ3JZK3UxMjhSNW9yN1JOdkxnQkdP?=
 =?utf-8?B?ZEVDQlNoYjlYRTR5RStXWTBicWtGRkxxa1J4eDQ4Y01NZGdxRm5qZHhqTXRN?=
 =?utf-8?B?YkdhOUd6VW9odzErUEFSUHRObVB3OUQ4MWp0ajRFd09pVjMxamFBZFg5SXBq?=
 =?utf-8?B?ak44YWFXM0RyWmV1ODlmM1lUM05ZbCtwZG40SW5yOThoaTM5NWpXeENGRjgr?=
 =?utf-8?B?bFdHSWhiZExLQ2ZTeGRPQy9jeW1EOVFNM2hnbjh0WnVNYnc2ZW96bEtQYXpY?=
 =?utf-8?B?YWdyd0g5WDdLUDJZZDI4VWVEcWhaKzRnYkRrK3hRa2wvWkJxZWFyL3F1Vm1k?=
 =?utf-8?B?Q3FsNk91QmpJY1FmNGpwVUhwUktqZjM0TFRJa3YrdzlQdTEwcU9TQmpZVFJ6?=
 =?utf-8?B?VG5WNTVUYnVNakFQTjVIVTdzbDltbXphMUpyOTF0Z3Q4eUN2Y1BzUlpGcWdV?=
 =?utf-8?Q?aQQCOih/17BUVpm5VnMVAkKqh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b73e1a64-4dc4-4e48-5306-08dad3e6b06c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 21:54:58.6704 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UYnntfzEaLnWnp4acPtB5cnLpp2KppIioVrir5E4kk01hIh6wNYcPFOzVn1Nmj0pSDdOnhDoiw9aY3ff/poeBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5485
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

On 2022-12-01 10:38, Peter Maucher wrote:
> The amdgpu kernel module has supported RDNA for a while,
> mention that in the module description.
>
> Signed-off-by: Peter Maucher <bellosilicio@gmail.com>
> ---
>   Documentation/gpu/amdgpu/index.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/gpu/amdgpu/index.rst b/Documentation/gpu/amdgpu/index.rst
> index a24e1cfa7407..bcc0f5c15f93 100644
> --- a/Documentation/gpu/amdgpu/index.rst
> +++ b/Documentation/gpu/amdgpu/index.rst
> @@ -3,7 +3,7 @@
>   ==========================
>   
>   The drm/amdgpu driver supports all AMD Radeon GPUs based on the Graphics Core
> -Next (GCN) architecture.
> +Next (GCN) and Radeon DNA (RDNA) architectures.

RDNA is still based on the GCN architecture. If you call out RDNA 
specifically, you'll also have to mention CDNA for completeness. But 
once you go down that route, you'll have to update this again when a new 
marketing name is invented. I'm not sure it's worth it.

Regards,
   Felix


>   
>   .. toctree::
>   
