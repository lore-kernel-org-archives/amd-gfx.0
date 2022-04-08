Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35CCC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 13:33:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46E4710F19A;
	Fri,  8 Apr 2022 13:33:44 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2078.outbound.protection.outlook.com [40.107.102.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F9A610F19A
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 13:33:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABxP1iBtfXh0dqV5+KZH4tBQ2B41Ln/ZMvjWIm7I+uvbd4NyDMzZMOqxz/het3316kCxlujWNdB4zMy3X3bT+KBSpFUUGqkZgPU8MNnAZbs2kbdSpCI6qTncwqcSkkn3S1hgOSR4dKm0vZbwyjb+oms/kZdry0a9B2a/4dzQkaYnNiclFFYTFh/VDW43gVQUs4XTc/lW8+2FWzq1NDNpfvPexlQWojswJ8HmOJEE+ysSR5zZhBsaz7g5ZXMqcv2QZNBGQwx61mH7uKD5WUUQ75npvgjeP8jfGPgLSn+UD3UHDXXm/PC7EVNd3fFBANflwKk32ORXy+7Lj4mEZCO0YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5PZNGSM8RSLtZxGVfDpkxd/1afUvBygl0zmemzLDCpo=;
 b=Z9JmGTdzb+vIcjzaTgOvsh5CFWjbKSrk5o49oF8Giku6nx74UhqfYHBxZAOrCwq5i5PgQjCqjVpsO9NlOtGGlQzvqT6dmvMV8zxBActOrLZ5BwYd2BHtDDKpr4Nuf73l6WAO/lDhx5ExPg2Tq8rGGxAMCy3lvc7sBXo8AGNc1YUfzmQwhG/GZeR5kNycUtKCEpH24eM+vt/ZeXsqHf8CkZcd9hUVRYwwkrapPDwUDrAzBMCkJRwswC6wnCNlx0a/j8ZLp/xPfZ017IzNPe45ml4MwTvccsQ9/1KdeeiGP2R5KL81lF9zHnS29Yi3vdmQCsmYm12K/PiFnD5Oewnzjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PZNGSM8RSLtZxGVfDpkxd/1afUvBygl0zmemzLDCpo=;
 b=JHkeLTVaSDMX8MuBLW/ELT+qeMOYt2bdDdJ9AfxPmEwFVRstiRHw2m3JsT2ca2tpbIXD7jqCDoV/C9Hq4S2o7QmBXTsDSecKgzCC89Yy2CEqI7twn49D+UgB/IwJA1SVbR79MYpt2GEe55v4akhe0zMdfOl1yIY9f7pQJ/FKrMk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 DM6PR12MB2906.namprd12.prod.outlook.com (2603:10b6:5:15f::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.26; Fri, 8 Apr 2022 13:33:38 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::3111:c071:1ca6:1e9b]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::3111:c071:1ca6:1e9b%3]) with mapi id 15.20.5144.022; Fri, 8 Apr 2022
 13:33:38 +0000
Message-ID: <2b3c10db-4eeb-3b7b-4ae4-ef3aeb3128ee@amd.com>
Date: Fri, 8 Apr 2022 09:33:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/1] amdgpu/pm: Clarify Documentation of error handling in
 send_smc_mesg
Content-Language: en-CA
To: Darren Powell <darren.powell@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220408022639.7909-1-darren.powell@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20220408022639.7909-1-darren.powell@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0079.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::18) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 512cb79f-d906-4795-f63d-08da19646361
X-MS-TrafficTypeDiagnostic: DM6PR12MB2906:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB29064E3960F07589FC7C2A2A99E99@DM6PR12MB2906.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fdKruLcgDQ+KRTXOXt/x+RInQPSbG/yb6GQO3/ARVss2r/MJ1qthy82V+K4RCg18K5QIqUauTopP8tR+HRSIgEN3hxQV3G99CTgcdduKJc2R93w2iA1fZsOMyI6+zkfNQ9SqCHEAixb1Fclmnp5U+x+ehygI8lqvsPUj2+wKPcPfMJ/60+3zhLYabSIR+nf8dVqIbW7ic6Nbt/xxAgg30S+ryC9Pisc3tKNyZzUAh65BCg+zS/XBXKOqZYwbLnAWG1pNwNA/2kT/adfmZ3N8ad44LyWh3UHaMTwOy3FK4/0YG8TkPvnim28Kfb4XfZ5n75b3EY7hvUJdKOoQ+o3ErG93IhqxHEeljcQxp2Acs8oFFdM0fxMdg5lbL8cobG9AtOjYoXRFmJHt2PbBrIEmlZv6ClfEECW0pTyNYVMR7amZDHb3zTH0PYAR+QONzfKW5YHn8pQjzEclFmxvqVcsukwSveg1M+k8HXirFSad1+qbTygZ3XhlL364tt20Tc3iCkr3Y1bgde/LSHnu8TqfRFfXf3HKlE1QlKgm2X46iRMzzlXhmHlTCQCgSpLUOAwjlQvP9mUcZ9g5d1rAnU5xxD0/ij1lp7Buing8CFIiRWdHb23l2LqGJwBZ3xdU+fhlavQOQskfnEzomf9mTN1EPqDj3frT1RKkIxyiYhTeD2AxtvWaBXaA0LDXeD93Y/T/wbyfxRqPZhuqMj3AemFy96VsfvD0xxInI69IFhG/1vE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(66476007)(4326008)(66946007)(66556008)(38100700002)(8676002)(6512007)(83380400001)(6486002)(44832011)(186003)(36756003)(508600001)(2906002)(26005)(86362001)(2616005)(31696002)(31686004)(6666004)(5660300002)(53546011)(6506007)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlAzMWhsK3hBdE4wUFI4Q0djeWNGNmQ4dTQ4YjY3SEFzVkt6dXpya2FWazlW?=
 =?utf-8?B?aWh4bENNUmdrQmhacWNmbXpMZlVqNjVNaHdUaWREL3lLTFFJV2FYeVZ1V2pk?=
 =?utf-8?B?dmpKSklkS00wV3lLQnlOSFJJYlZCT3VSWHFXeUhXaXEwU0xZVU4wTmttRlp6?=
 =?utf-8?B?c2JUZEo1SW1oOFVYano1TVJrTXlCZUEvVmRrNVY1YzhDU0dWYXN4YXhtcGlI?=
 =?utf-8?B?YU9VUjd4eW5acjFTY04rYmd2V3E1K3hZMktpWUhwWTVQQjQrRE9TSmlHNzhE?=
 =?utf-8?B?UTFGSWx4YmkwY1o3RkZwTElLTnlSUy9meC82SXh4YmJCZ29FVGN0L2VoaStD?=
 =?utf-8?B?MXBQTW5vUDBhcFZMb1didFZEck0yMUUyaXhZSjdqY3lzN1V6Z28zNFFUdERm?=
 =?utf-8?B?dm83cEhsRXVkandaNlZyYVVmQXhYSzB6bzVKSHFWdFJ3RkZjWTZNYUttVHNS?=
 =?utf-8?B?RHF2c0UxNzNybGlZSGp3UEM1OXBOYnFjQ20wWjc1ZWFCMEZyT0IrbFJTQ0pm?=
 =?utf-8?B?blBZZ1ArWk9wMm81RWNMSE1Gc1VCWjZaOWVDNElkcXZxb1B4TWQ1NGlNenI4?=
 =?utf-8?B?VU9yMDZ0VFpEWHFBUDVSN2d2dlhJRkk4eWdkaW1SekpTMkFKZDhBMVZCbVhL?=
 =?utf-8?B?cTIvSUpIRG5QL2NWTmxpM2t6TFlsNy90NnR4b1krc1RDNTM2Qi92OSt1SHBX?=
 =?utf-8?B?OXRldTVUK2NGdFprSWsva0Rhc0drcENMMHNrR0UzR0JvRVpLSUtzaWk0a1pC?=
 =?utf-8?B?aVhlRGw4OVFVeHE4NGpwUXhSa1NacUw1aDV1MFJDTHBGVjVpOWJHSUs4Y3Bx?=
 =?utf-8?B?eDBheFB2cDlxTWIrdkxlTEV0YjRid05lOXgvM090aFJSSjdZUGgzYThLbVdj?=
 =?utf-8?B?aGZpRGtWTWljczdOdFlJREJGNGp3am1vL1pNT0lmbUxGb3VlZWpySkZ4NzdF?=
 =?utf-8?B?RGoza2owRFBESi9KY3lCUFJ2TUI5MVBOL3VuV3IwMDA0MmliVEZHKy81Mkp2?=
 =?utf-8?B?MisxQ0RKSi83K3FLU3Vyc2ZLajVXYlFhbnV6cU5WMVA0YU0zYzVZd043bDYr?=
 =?utf-8?B?VnFEeTlPSUxiUDNOWnFtZkV0MjlLTmV5UWg0WXBtLzltN2syRUtTcGkrVmZ1?=
 =?utf-8?B?WVdFMHZ5TytCamFlaVlVbmlEM0hadXBFUERQNDlOd2h5OWpackZKT2pYc2Jn?=
 =?utf-8?B?b0lhd1IyUXd3Z2pyN1JKdnYwMndoVE04TG1TUGQxbzhvQmFmZlNBMExxcEVr?=
 =?utf-8?B?UDZpeGNjQ2V4L0dxdWJlZ2s2VTZ0RzNEQyt1WGNEalFKM2hjYUFGYUR3cHZG?=
 =?utf-8?B?MTljWVllZFhnRWFNa2hpcUFwUEZuRk0vaWswNTc3d2UxenJJa0psaVFBRnJ4?=
 =?utf-8?B?c1NQcDdsWXBoMnorV3RrSEdsc3BpVlRvQTd0dWVwVDBRTlVHVVNMUHdjV0Nu?=
 =?utf-8?B?YkNtLy9HOWR0Q0o1U0tsd1BCbjNEaEVQZVdoRzAvUHZCYTI2MzYrTXZYdWJk?=
 =?utf-8?B?L2ZRd0RGWm9mZmZJYWdWWHdRRk1JVm0yN0NnYStFUEZBbWpLUDFibUl0YkJ0?=
 =?utf-8?B?K0FpbFdjK2NFblkwK0tvbmc3OUgvb3REU0hYWlFyT2krMWhkbGlkd09MWFox?=
 =?utf-8?B?U0t5cXlRcTdtMElnMDhiRU9ERW5sVCtpU3lJcXlWZGorUmw2NS9uY3JaWnAv?=
 =?utf-8?B?empZdE5Lclh2OVBKcmZvSEx3cDdiQ0kvaUFub0NVbFkyOXUzZVh2MzBzRDFm?=
 =?utf-8?B?WVB3cDBUajlrT3kyYWtjNTBnSk1IS3ZFZWZhOFZtejhNYTFGNnRrcXBrU3NY?=
 =?utf-8?B?VkRHV0kySG9zTHhEMmhSaHlZWmRmMkZOVzI2eGd0NGY0VE9ackRwNUw3dVlH?=
 =?utf-8?B?ajRRNjdoMzF1dzJuS0pyaloxaTRCVW0xOEFBRDJRSi9ScUpBa1ZKOEVONjVJ?=
 =?utf-8?B?amIxUldodWI1L3AwdXNxeG5SYVBIYUpOTk84QW5TcFROQTdpenZtWjVVd1N4?=
 =?utf-8?B?QnIvR0tnZHpBY0kwRjMvR3NvazBKcjNtQXpUUFpBWlZDWmNaVVg0MlRRSjdR?=
 =?utf-8?B?WVFkeHMvckRVU1QwdVhCS0x6a2VKbmh0QmhCcXJvUmJZUWUxbXRvbzRUby9G?=
 =?utf-8?B?T0ZpOUhkeFo1SlFPanBIaVYrZHR5aGx0aFlUVnNDU1c2ZmJzM1M1dGlNcmZH?=
 =?utf-8?B?ZEFUc3pZUzNGUmltRkhob0JwcDdZT0MzTU5SUkRLWlFSYXBQejVNWWN4eHB2?=
 =?utf-8?B?VzI2cGZmbmxtZG0wQWlSWk1zREJzd0Rac1ZUeWE3dWtBd2ZIdzYra2NVSXl5?=
 =?utf-8?B?OFQxTDhON2s1RDJjMjRVUE1nUzVJLy8wblZKSU5KM0Y0enFrbnZ5UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 512cb79f-d906-4795-f63d-08da19646361
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 13:33:38.2541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eJ3j/kn8BnvjALXj4B+NA+MTi6Ad2BS+Nf/RuylSDOEaq9rgT94UkKghiSArRO4U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2906
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
Cc: andrey.grodzovsky@amd.com, evan.quan@amd.com, Wenhui.Sheng@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I'd add who and how is the message dropped, and also mention that we're unable
to recognize a dropped message.

On 2022-04-07 22:26, Darren Powell wrote:
>  Contrary to the smu_cmn_send_smc_msg_with_param documentation, two
>  cases exist where messages are silently dropped with no error returned
>  to the caller. These cases occur in unusual situations where either:
>   1. the caller is a virtual GPU, or

The caller? Isn't this code executed on a CPU sending to the SMU (which lives on a GPU)?

>   2. a PCI recovery is underway and the HW is not yet in sync with the SW
> 
>  For more details see
>   commit 4ea5081c82c4 ("drm/amd/powerplay: enable SMC message filter")
>   commit bf36b52e781d ("drm/amdgpu: Avoid accessing HW when suspending SW state")
> 
> Signed-off-by: Darren Powell <darren.powell@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index b8d0c70ff668..b1bd1990c88b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -356,12 +356,15 @@ int smu_cmn_wait_for_response(struct smu_context *smu)
>   * completion of the command, and return back a value from the SMU in
>   * @read_arg pointer.
>   *
> - * Return 0 on success, -errno on error, if we weren't able to send
> + * Return 0 on success, or if the message is dropped.
> + * On error, -errno is returned if we weren't able to send

Something like this:

  Return 0 on success, -errno on error. If the message was dropped
  due to PCI bus recovery or sending to a virtual GPU, we're unable
  to detect this and success is also returned.

>   * the message or if the message completed with some kind of
>   * error. See __smu_cmn_reg2errno() for details of the -errno.
>   *
>   * If we weren't able to send the message to the SMU, we also print
> - * the error to the standard log.
> + * the error to the standard log. Dropped messages can be caused
> + * due to PCI slot recovery or attempting to send from a virtual GPU,
> + * and do not print an error.

This is a moot point with the clarification I suggested above and I'd remove that.

>   *
>   * Command completion status is printed only if the -errno is
>   * -EREMOTEIO, indicating that the SMU returned back an
> 
> base-commit: 4585c45a6a66cb17cc97f4370457503746e540b7

Regards,
-- 
Luben
