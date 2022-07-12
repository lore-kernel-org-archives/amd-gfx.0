Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00CCCC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 14:31:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78F1F94BB8;
	Tue, 12 Jul 2022 14:31:01 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2082.outbound.protection.outlook.com [40.107.102.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A20C694BB8
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 14:30:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OdEZvHywAqn/kR9Pps3YdqBTF+XNiz7DITIu7qIMOUCJ+RE8jKlinwXCMSnqIOleSL50pCKX/LnUfqDORQdUzu4v+IxwRTIquHVpIsu8308SztAibdtH6CC0ituLbJ1I9dobEbK2oaSePf40suTaeeFWgwO4Ah7T/kkXg7sWKzdl93lyZgCA+DhBoefWEyHLSkeI0XG0MFidT9vUGKtjIhmWzm4Xar7ImVisV1p0Ife8FMR6HZCoAo2PuU0nxcPDpO3F30cC/ku2A7naDIHniAneW8UfSMuI698GWwAVzFEjKJoCDH/QM2grB2+EEirPmroYeUTsTm5s+WrytLTFOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MC4tdxycb8fRETtrtTqimDzfWxvBveaiIUhWz2EZpq0=;
 b=mOwT5N2FybOd2WaAUAjSIEoKUDoRzM73lU+PpHkpbnrA1x13V8qQRxoAY+N6p12ERqP9hdVZZ8oVP8g8Uf7DB5jKvZ7GTVRe3yyhYe4+JKmTlTMvMEYqKN+Wf/sk+QTyoajusIe7wek7nKuGLwtdOFaoc6Ct88EfpN0Y5gGcAKTubZr3kPuNqzTmTSMMrpwMrQskwRGecVWN+u68K0eteUoMk2+ediuNB58Ow2uKhh8HvbFIAeqPRsphKb5mDWrLBijprMAfG5TSaum5Gudvv3d6stnOUxOlZoBfAYFs7HPxEd9V9t2LguFUKMc/qdnALgUT/1vym0FBwF3zPDqclQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MC4tdxycb8fRETtrtTqimDzfWxvBveaiIUhWz2EZpq0=;
 b=356EYTwaoYtMnPgA38TsQjKIf6UL9Ivwm6fgwaR9u7GPKWCN1/LQ2hPGQWAjsZ701tDgFjgGO2taOcsltRM2inrUThhoLR+8x3ERn2hiGxTYb5S6NdFm62yI9DByDHxZvokOtK1O42N6I2S+U69jbboYujDJaGqnuhdsTMFDc6Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by DS7PR12MB6045.namprd12.prod.outlook.com (2603:10b6:8:86::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Tue, 12 Jul
 2022 14:30:51 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::749e:fcd8:1981:fc3d]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::749e:fcd8:1981:fc3d%8]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 14:30:51 +0000
Content-Type: multipart/alternative;
 boundary="------------m8GTuIEFi28df0GRpf31Nllc"
Message-ID: <62c301ac-7fdb-3d4f-404b-3dbbbbbdd9d7@amd.com>
Date: Tue, 12 Jul 2022 10:30:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdkfd: bump KFD version for unified ctx save/restore
 memory
Content-Language: en-US
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220711184153.135021-1-jinhuieric.huang@amd.com>
 <BL1PR12MB5144B5BB5BA660DCE16E8B86F7869@BL1PR12MB5144.namprd12.prod.outlook.com>
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <BL1PR12MB5144B5BB5BA660DCE16E8B86F7869@BL1PR12MB5144.namprd12.prod.outlook.com>
X-ClientProxiedBy: CH2PR19CA0020.namprd19.prod.outlook.com
 (2603:10b6:610:4d::30) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29f33ff8-ed8c-46b8-b4a7-08da64131ed2
X-MS-TrafficTypeDiagnostic: DS7PR12MB6045:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tey+REzCdYNRk22DF4iMvKlk7IrXeY3rseYMpF2iSYw2E4A6AXmfat4qyyAj3hDJc9zTaiksmnRApaHy93F53OxTCZNf5Dfnp0PDWYTvaBVscgYda7yEY/qs1LceObxenJPxYZcscOHuCnrYLusxsRLyDntFIIRnrF3iR/FU0xQXeIuX8zW7e4pld43iJ+5PwIz5oJGe08EaEKL4KdOQEtkCRPArr9Z19N0RkP+LWOqIR9VJWLKlHq4CgEol45mM0nK7xd0XDnlppzykH7saxELPMxaJP45kFmJP+U7215ckcH76lN2B+ac8A3OtRQr1dG0kVF0b+gShfcWdOT/HtVuRNStpXxlnx3FEkRQ4UvfFuEmAzMf9xDyk0H+nWUOO4EVTuX1zuQXMOqLF3MuhV3cao2LtYOM2o7xM5Gzon+/eNiqbA2olY0HuibA0iIzPTUm5LBS9/mEzpnf/sMGivPK6FRj5pTTSKUECSiGBcwCS8hgfzgeUHe0aBBhoy0NLgH1ygUdul1lIQD6z2+NFvCMIx/MZN1BjD+Pnr2OzpqOQiikVzENTV/L7tNh/Yf7wSXQ1JYE4Kp9APLY/Tk8/JaRiuK6fzB49jPuH8tx8qI3eHwAB3WsNyLZ/Tsxzu3PFfROr7D2gUUGLAHMBGpI7LkZ840jNRofbcKEupcsKS/23CsvJoYds++DcDrrQ30wO+gLEHpESwPuezusxaPbsTVKUzJmMY3NSM8Yv6TiKRmdJ1bIuP1CimzqPtAlpTRibJMMwGF1yu+/46e7dCnTCQmMX/durveHgDQvTXzn9TCbxPnr0CtYTiiNqoQM1OilPJwoJyGNXO+EgsA6F9aMuAguCD2pqiIdTXJbQLuw11d0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(478600001)(6506007)(36756003)(83380400001)(2906002)(31686004)(19627405001)(186003)(6486002)(6512007)(66946007)(316002)(86362001)(31696002)(8676002)(110136005)(66476007)(5660300002)(8936002)(2616005)(66556008)(4326008)(41300700001)(33964004)(6666004)(38100700002)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXgwZktlY1F2SHlYaFhXM0NUS2FXY05NeGZ6WmJTaWJBQ2dNR05XV0FtU1Na?=
 =?utf-8?B?TWVueTk0Zis0T3RYMmtUWXIxY2ZlWWlNdmRSdVg1YWxuZ2dQdXhiajgzVStN?=
 =?utf-8?B?c040R0tBT2JoaWxZMSttcngvQjVDRzVHQ0JlTVpZbjExUlAweFdiVzhxRnVR?=
 =?utf-8?B?M3dMT0d1aGN5SVkycWc2QjN1YUhRSUJMVjd2TWZ0bWRhQlVWdktGdkMxcERV?=
 =?utf-8?B?eGQ3dG1lWkJVNXZoNlkrMHdzNzB5SkNpU2VQbS9vK1M3TE41N1V3U2E2MTJB?=
 =?utf-8?B?TnNUcFU0SFBnejV0VGpFdEk0RVB3Y0R5elJPVDZreUp1LzZPQ2VVa1JST20z?=
 =?utf-8?B?SlcyTGIrUWp1RW1md0haR2VQODRrODRHcXl3N3BreGNkQUdScGszQzJmVThj?=
 =?utf-8?B?dEhvaUt2ZzVGWW0xa1RWWm5QY05NYStIeHpGY3Z2SDVUbE95cUtKL2xGRml5?=
 =?utf-8?B?ZW5IbzVtdmo4MjRuV25GYjVwTzRwdHpoZzQ5aVpXQWcxVm1HTTNhMFZYMm5j?=
 =?utf-8?B?UEkrYkphM1Fudkg2Sk56d0FvZ1NOL1VhVlB4b3RrdE9ZUXF6NWN5aHhTWVBL?=
 =?utf-8?B?ZWNEdm83NTcwZkNvcU1Ndk5TblpVT21vZ2NpdjlJR1NmT0tIbUg3UlVXWlNU?=
 =?utf-8?B?c0xOaE4zRytBNitPVHl1OUptUUkxMkxrNXc5Y054dkZwQXBxcHcvR1JueVNQ?=
 =?utf-8?B?enhWa2JLMUNoTGQ1MnYwMVYvbUYwNlZuRWUzb2loMm9pS0JpVEdMWW9KeU80?=
 =?utf-8?B?bmlKcE9rc21ZSlV0eHliRVJXdlBCMnU0UVRIZk94T2toT1UzRERHN0Rzb1Jx?=
 =?utf-8?B?TktWOER1ajlvV2VCajBvdm9rd20vbk5jV2JGV2hzcTBOcmhMSEpmWXI1YWJt?=
 =?utf-8?B?aTA2aTFaS29sQ3pLRUwycHpJem5scitMQzNGUXRKMW1EVEk0UVdGM2lUb0x0?=
 =?utf-8?B?dXZWK0Q3V1BPb0xGVUFqUFpxVnJ5NGdjMm1aTkR1QythekNnTGkxSmZqRE1F?=
 =?utf-8?B?anpHakYwcnJlMWVLNTJ6WmY3UVRwZ20ySjRvT0ptWGZtZzB6OEp3QXlwd2R6?=
 =?utf-8?B?U0hldmV2d0RDc0dWYnhQUllIUENrajVCamF1OHhHUjlTWlVMMFo4YUo4TWxy?=
 =?utf-8?B?Mkw3YkNpUGgzWjRUUllkbWVUeGlNcTBNZmZWK1o2bk9WdWJsMDA3MGlhWGJH?=
 =?utf-8?B?aGRoWFFhMXF6RVM0YkRqM3V2NVdScytad2hqQjhST3hrSzdXWXlsL1MxU2Vl?=
 =?utf-8?B?Q1o3U3phVTZhQ3R1SXZlZEZsRlhuZUdKTlB5UXJBcnpGdFcyVmZPOUczZWd5?=
 =?utf-8?B?MXhHYkowWEwvWTQyR2tqb0twT1RzTWw3Nk42SFRUdUJrVUJYTWFXS3Zsb2ZZ?=
 =?utf-8?B?R2RDMlZsUXR4N2NSRU00cnBpcHNuRStQNlQ4VE9CN2wxUmlRVlNEUnAzSSth?=
 =?utf-8?B?TG14UDdFdVVaZjNDcDFud1FTSDlWNTFmMUZNRngxWUdsUTFYQnF6RjRGRHJs?=
 =?utf-8?B?ZVc5bGZtTytYdHAwN2NGUDN2SHFSNS9CYWVkVzlSZVF2ejlSMnhTSzQzQU9a?=
 =?utf-8?B?VmNUdTNQY1hHeDNNWkxkUWZOWEMyNjR0Rk8rbnRkOWVNUWZxR3dINDdxZ0JV?=
 =?utf-8?B?TEtNNTdQKy9pOHVKdy9CMFAwYzdSRXJybnhkWi9CS2JvSXhKM1lOeWFzNEw0?=
 =?utf-8?B?V1NPMURIU2dySjRMdTZTaXk0YWxQdER1ajFzNWlpR081a3NIUnN1SkFCWXRo?=
 =?utf-8?B?K05DdlhKZ3RESHh0SXU1bUptRkExOGlMRGZCS3VpMnpqNmdRVVZDUnVkNllY?=
 =?utf-8?B?VW8yMGIzaWNscnZGb0FrVmF2U29ac0dVbHNQQkJCRWo5N0U0TXAxMlMvMm1W?=
 =?utf-8?B?OHFUY2hYd1NoVWhlZkIzKzRqSEVkeVo1b0ZmOVk1dlQ5b05pTFdOUEg0aG5m?=
 =?utf-8?B?dENLQjJGcmdLREUxWDc5QVo2MDgrZ1hFVWNrRm4vSm9sb21vQXVGSGFnVTdI?=
 =?utf-8?B?anFrSzFDZEgvSzNFUTRUdWE2bVFQS2JQb3luUnlHZEhkNWorRWVZWmtkZG51?=
 =?utf-8?B?anRzMStBMGhacGZSa1Q1OW1jc2xtT3RNdmpHU0NiUG1QdzZSNG0rbTVpbG9r?=
 =?utf-8?B?bDRPZzltdytOZzEzOGdQbTFBcVQycWRMYldlQkxmVmlITHc4VkhuUzZhOGhm?=
 =?utf-8?Q?FAqjx7OtTm3patMYBWFa7Z9BHKJ+ScQDf6ejvXbJn8/D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f33ff8-ed8c-46b8-b4a7-08da64131ed2
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 14:30:51.2190 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aXJeGvXrJmERufqBHcuov2JCNOZsynDp8MXEL1HJpNRDw59Xz3uLTUAbReg2h3puEPuR2hr277SnmtGVlMsdHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6045
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------m8GTuIEFi28df0GRpf31Nllc
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

The patch has been pushed. I will do that for future patches.

Thanks,
Eric

On 2022-07-12 09:57, Deucher, Alexander wrote:
>
> [AMD Official Use Only - General]
>
>
> Can you please include a link to the proposed userspace in the commit 
> message when you commit this?
>
> Alex
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of 
> Eric Huang <jinhuieric.huang@amd.com>
> *Sent:* Monday, July 11, 2022 2:41 PM
> *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Huang, JinHuiEric <JinHuiEric.Huang@amd.com>; Kuehling, Felix 
> <Felix.Kuehling@amd.com>
> *Subject:* [PATCH] drm/amdkfd: bump KFD version for unified ctx 
> save/restore memory
> To expose unified memory for ctx save/resotre area feature
> availablity to libhsakmt.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>  include/uapi/linux/kfd_ioctl.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/kfd_ioctl.h 
> b/include/uapi/linux/kfd_ioctl.h
> index 7a423855a86e..afd8ff29c74f 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -36,9 +36,10 @@
>   * - 1.8 - CRIU - Support for SDMA transfers with GTT BOs
>   * - 1.9 - Add available memory ioctl
>   * - 1.10 - Add SMI profiler event log
> + * - 1.11 - Add unified memory for ctx save/restore area
>   */
>  #define KFD_IOCTL_MAJOR_VERSION 1
> -#define KFD_IOCTL_MINOR_VERSION 10
> +#define KFD_IOCTL_MINOR_VERSION 11
>
>  struct kfd_ioctl_get_version_args {
>          __u32 major_version;    /* from KFD */
> -- 
> 2.25.1
>

--------------m8GTuIEFi28df0GRpf31Nllc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    The patch has been pushed. I will do that for future patches.<br>
    <br>
    Thanks,<br>
    Eric<br>
    <br>
    <div class="moz-cite-prefix">On 2022-07-12 09:57, Deucher, Alexander
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:BL1PR12MB5144B5BB5BA660DCE16E8B86F7869@BL1PR12MB5144.namprd12.prod.outlook.com">
      
      <style type="text/css" style="display:none;">P {margin-top:0;margin-bottom:0;}</style>
      <p style="font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" align="Left">
        [AMD Official Use Only - General]<br>
      </p>
      <br>
      <div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof">
          Can you please include a link to the proposed userspace in the
          commit message when you commit this?</div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof">
          <br>
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof">
          Alex<br>
        </div>
        <hr style="display:inline-block;width:98%" tabindex="-1">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b>
            amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.org">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a> on
            behalf of Eric Huang <a class="moz-txt-link-rfc2396E" href="mailto:jinhuieric.huang@amd.com">&lt;jinhuieric.huang@amd.com&gt;</a><br>
            <b>Sent:</b> Monday, July 11, 2022 2:41 PM<br>
            <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
            <b>Cc:</b> Huang, JinHuiEric
            <a class="moz-txt-link-rfc2396E" href="mailto:JinHuiEric.Huang@amd.com">&lt;JinHuiEric.Huang@amd.com&gt;</a>; Kuehling, Felix
            <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a><br>
            <b>Subject:</b> [PATCH] drm/amdkfd: bump KFD version for
            unified ctx save/restore memory</font>
          <div>&nbsp;</div>
        </div>
        <div class="BodyFragment"><font size="2"><span style="font-size:11pt;">
              <div class="PlainText">To expose unified memory for ctx
                save/resotre area feature<br>
                availablity to libhsakmt.<br>
                <br>
                Signed-off-by: Eric Huang
                <a class="moz-txt-link-rfc2396E" href="mailto:jinhuieric.huang@amd.com">&lt;jinhuieric.huang@amd.com&gt;</a><br>
                ---<br>
                &nbsp;include/uapi/linux/kfd_ioctl.h | 3 ++-<br>
                &nbsp;1 file changed, 2 insertions(+), 1 deletion(-)<br>
                <br>
                diff --git a/include/uapi/linux/kfd_ioctl.h
                b/include/uapi/linux/kfd_ioctl.h<br>
                index 7a423855a86e..afd8ff29c74f 100644<br>
                --- a/include/uapi/linux/kfd_ioctl.h<br>
                +++ b/include/uapi/linux/kfd_ioctl.h<br>
                @@ -36,9 +36,10 @@<br>
                &nbsp; * - 1.8 - CRIU - Support for SDMA transfers with GTT
                BOs<br>
                &nbsp; * - 1.9 - Add available memory ioctl<br>
                &nbsp; * - 1.10 - Add SMI profiler event log<br>
                + * - 1.11 - Add unified memory for ctx save/restore
                area<br>
                &nbsp; */<br>
                &nbsp;#define KFD_IOCTL_MAJOR_VERSION 1<br>
                -#define KFD_IOCTL_MINOR_VERSION 10<br>
                +#define KFD_IOCTL_MINOR_VERSION 11<br>
                &nbsp;<br>
                &nbsp;struct kfd_ioctl_get_version_args {<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 major_version;&nbsp;&nbsp;&nbsp; /* from KFD */<br>
                -- <br>
                2.25.1<br>
                <br>
              </div>
            </span></font></div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------m8GTuIEFi28df0GRpf31Nllc--
