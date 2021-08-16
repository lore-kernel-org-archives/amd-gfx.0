Return-Path: <SRS0=yGBf=NH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8287FC4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Aug 2021 20:25:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F56860F35
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Aug 2021 20:25:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4F56860F35
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EB476E04B;
	Mon, 16 Aug 2021 20:25:20 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57E0E6E04B
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Aug 2021 20:25:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5kpkGqc4yg05inqmyx313IrZZR0YzKU4UdNM2VBLIoaewaKdQnmBnQDTDN8AVtG3u/5af+8CuUFW/o8AskM8bjyEs7KEaWogBu3Fs+8+/N4VuM2FBjl32bmASZJ2dVc3ro15seiGC5yMOItFs6qsmGD3h5uqPIVbp9wdWJTmv4aHlhkI7Wj8V9kx0cjq02yR+q/aODF8gFzxsZLRJWVHUhQYDJ/539kCYx/DhJ6bRG81BKpH/t0l2TP87OCmLQ1uInttQSCJbUq2M5FFHdnD548eK/zFdYV+DFOzCxz+dRFJdalcuwWCWxCyQd5zC4L0SexE87ApS8So3NHhdJRqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b66rczbBA9Lo1JYULF6mQ4Syv2AD/+6+xc1VYc7+bts=;
 b=RMYFQPnoqffiN2EdCRZwoIbyN06uzX709stlGfjMfmWGx4/S8Og+e8Dsm9QRfUqa9egTN8l23DoZzIxGKuL+IgAPDaVsLfDXSCjxbT2KxL/sS47rNMGLQY7Kn7uZM9yuEWtQTs1kjDyeIWD+yEwxqAXcahAAthVspCZTqKeJQgr8nO3qFdKDqXj9WXvg3g5gX5yJGiPZI4QWi4KZjq+Z/1ZtZCtPI9e1GgHAHsMuWNcWqX7mOIyQvWgcZRJNFNSRZxoKgvA05NulmBIdKDf8X7SWVpVUu0xiBgP6+Ih/eGY2QYVF/afw4UVvtt6vv7q+JAsFBNugUflv4Wvrxx8tKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b66rczbBA9Lo1JYULF6mQ4Syv2AD/+6+xc1VYc7+bts=;
 b=0ExNnXncZt55B4r2ZgPIzcTpUgrB/JqwX/Q5SQSp7jXevHXPAR7bew0ikqp1A42AL2GjeWEGxqpozhqy2iB/O5s5FIlmykwB/0R10cLa+pR7wqBkJg9izvSE2Wq979aRtOWU0Fu+ctbeJ8PBwwfDdO2BzLRVZB6UPYOlD2lFZzU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5304.namprd12.prod.outlook.com (2603:10b6:208:314::13)
 by BL1PR12MB5288.namprd12.prod.outlook.com (2603:10b6:208:314::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Mon, 16 Aug
 2021 20:25:17 +0000
Received: from BL1PR12MB5304.namprd12.prod.outlook.com
 ([fe80::b906:69af:a1f0:ed2c]) by BL1PR12MB5304.namprd12.prod.outlook.com
 ([fe80::b906:69af:a1f0:ed2c%9]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 20:25:17 +0000
Subject: Re: [PATCH] drm/amd/display: Use DCN30 watermark calc for DCN301
From: Leo Li <sunpeng.li@amd.com>
To: "Liu, Zhan" <Zhan.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Cornij, Nikola" <Nikola.Cornij@amd.com>,
 "Logush, Oliver" <Oliver.Logush@amd.com>
References: <DM4PR12MB52146EC560946C5875B085FE9EFA9@DM4PR12MB5214.namprd12.prod.outlook.com>
 <9c1f29ee-a1d4-c745-f87e-52bb4b896b90@amd.com>
Message-ID: <4d9fbe82-22ea-5ff2-3c01-a168783bfc35@amd.com>
Date: Mon, 16 Aug 2021 16:25:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <9c1f29ee-a1d4-c745-f87e-52bb4b896b90@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN6PR13CA0021.namprd13.prod.outlook.com
 (2603:10b6:404:10a::31) To BL1PR12MB5304.namprd12.prod.outlook.com
 (2603:10b6:208:314::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.254.40.27] (165.204.84.11) by
 BN6PR13CA0021.namprd13.prod.outlook.com (2603:10b6:404:10a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.9 via Frontend
 Transport; Mon, 16 Aug 2021 20:25:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c34a1aa-e1fd-4511-7dd5-08d960f3f619
X-MS-TrafficTypeDiagnostic: BL1PR12MB5288:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5288F35CFD96ED7310F81E2282FD9@BL1PR12MB5288.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:81;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /L2kluGICwUt40R2SQLfGCOGU3MzsIgEKg56aeXqPhHj2v0w5hSXJzj0lHh/BEyVYlaeiSx+L77qwJ/zN4Qvy4B90zXLaqyNasoezE+IMHBHNhJKJrK29ZjwCyy5/e+k3NgOJTtqcGFbfh6DSLC24MKzmvfkywtxOiXUrK1h40gAUXhHliSyJX/Wd5aDFHyApSdJa4AxBWayLKeDhnOPAjJBdk7UN1GoteQOmQ80RjOHQhHHKxALRt3d7GezyL9dX9+CBymlIQlsIBz/ch417qbERaVZDkh/k1NhaeM54XvfAlP+kZnZf0ndO/ysQ9E9V1WA0yfrqPDrAz1sU8ai0QTCNtwR0Ue5RBkb+Q7wRpbltVUIKDpE1dsJlKArPAVy55Eey0PwT6bmQsTJis+ZXmKjocWSwDDpORI6YCpXLAR7CzVymKQzQV6rruif7bdzpg+hK3PqDPeu1O1kb4j9cCp3RkOM/uMcJZnKx6QobFxfhJxZTlJu4MK7GcHFxix1uxrf8I6RajSIr4E9BmtDSglH59487BaCiPqQNkZzBzByIKuXdaTc4BI526wQsSHtd3DWLAyuwSW4gfx6g6zFUmOZifmo9u1tuqLHHX1qNHpUVaVHENystKqu1uoE5F/W2iXo78eFDHTM3MoXLU6ySX0zilNeuvq70sQYLZCED1X5YL4Pjq8aWDQB5+yW903rOCC3Kvzs9DFE/Ue5xdTrj4sxfR0UcDKsItiD+EE5vYg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5304.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(110136005)(31696002)(16576012)(2616005)(956004)(5660300002)(38100700002)(54906003)(316002)(83380400001)(31686004)(36756003)(186003)(4326008)(66946007)(6486002)(2906002)(45080400002)(8936002)(8676002)(26005)(86362001)(53546011)(478600001)(66476007)(66556008)(966005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEFXOXRhOHVkWDNwcXM0TWxHWk5PU0FrSHlZRjJjM0pTeTBCV0Ewc0FoLzlh?=
 =?utf-8?B?TmVWQ3BDS0d4cE9OVSt5WDlUWFJtakRFalBMd0pCcGJSemhqUE5SNkMrN1Z0?=
 =?utf-8?B?b1FtL3QxS3ZPSG1UckVMclVJcHYxaFFqZktRcGNKSHdLcDVQYktqc0oyZlYx?=
 =?utf-8?B?Zll2RVlPRG5PUUFuMFFvemcyUU5Rcmd4enN4dUtJTVo0d2xZdVVCeXh3bUhm?=
 =?utf-8?B?ODhsa2JmM3ZqS0VWcUVaOWx3OGNVSjFIelJFOUZtSkZyd1c2M3dmMTZRZURa?=
 =?utf-8?B?L0pmOUQzNU4wK0g3NVU3TG10UTJmc1plTjBMdktNenI4ai9KYy9TUHBvYjhz?=
 =?utf-8?B?eExNc29MdVBlS2RGVGV4VGNuRlhEbXU1MmZmOWE3Q2V1dEpmaUhFVlREei91?=
 =?utf-8?B?ZzBFc01SZkhrRGM2dTNXMHVRUlVkL2hSbDFOZjBwdG9QYTh4NURqdHRFT29J?=
 =?utf-8?B?dGJmQ0cvRXpFVHo4TVZyWUZIL3p4QlczS2oyUUhUWlZPd2RSLzJjcDB0N3pC?=
 =?utf-8?B?aVZWQUhLcnhycFUvRXRGbm04STJOYzRpcDFTdGNHdnI1WE1DdDB2dTdHaXZC?=
 =?utf-8?B?dGFNNHAyL3NkUGVxZHRHUHdtS2ZvV2d5cHB5clZWRkFrWlJ4Yi8xRXNyM2lv?=
 =?utf-8?B?VDFTS05DZkVmY0hvalV6RDM5Szg2VjB4TFFLN2dHTGhGb1JZVFNhSzFoZkps?=
 =?utf-8?B?czdYcTJaU2l6QlhHUFhTYkNYRnlRSWlFa3dYWlVCSVIvTkFsYlNnY1dsd1Jk?=
 =?utf-8?B?bUR1dDA1SUIrVmxSTmZGdU04Ny9RL21JQkdRQXliWUJBL1R2NlI5eG5mc2JQ?=
 =?utf-8?B?bEpMVk55eTFBd21nRDl0bFpSOTZKQ2JyRFhhV3loU1Y5OU03VVg3aW9DRyt4?=
 =?utf-8?B?U1hWNzYxcERXa0J5dkFjd3owRVFYaGRRaXRSejFWUHloVWpYWVE1Snl5S2Uz?=
 =?utf-8?B?ZEhJYXExa2tqNmd4SzJOTWZ5OU9Nck9vaUk2ZzJIcnJCRU9ZWURpUzRyWDBk?=
 =?utf-8?B?R3Ayc2VtU1l4WllPeVJNMXNnL3h4NEQ2MjVQcmF6VnVtUm14bG0rR2Yvdm5i?=
 =?utf-8?B?Qm95RExJM0pTc0VQRGJ0R0FBVUE3QTVkRFJLM1JSclpncXRyK0I5SUp2UTRt?=
 =?utf-8?B?dDNYSFBPZ2U5a1FvNitSOE9XUjhsNkF6cU1UZ29BQ0pnUHZoZTdoNEtYZEhB?=
 =?utf-8?B?Y0Y2QmYxVElSUjhodGdxUjFrOHB4c3BFNDVWNWMzZmsxaTF3dzBrNkZmTzk5?=
 =?utf-8?B?dDRvc0tlNmc1UmdyV3dOb2xrdnRXYWt6S0Jmb2JwcDhiS3ZJM0c4b2FaYnRv?=
 =?utf-8?B?eWZHemdiTS9yRUIvOFljTmhOVTNnTkJTYnVDbS9HaStjemJQbWpzV2R5NWZs?=
 =?utf-8?B?UmZ6ZUEwSzZOTTV0UEN3RFg1NGl6WFZkMmxXc013cUMwOXFUcnFRZFlVSG5V?=
 =?utf-8?B?Y2c1eEYxWW0zQytESkRUMjArdGNwMnc3VUNBV2lYWEJ3MTJWdTJuREZnVG9x?=
 =?utf-8?B?ZlhwbnFESDdFeEJncFFycmpZTldnWVpZdWJuYTFWOEYzNzZPLzVFRWtPeXhK?=
 =?utf-8?B?WHpPUmVsVGNGRFZxQVI4T0dqckpHT0FCQk96WUtTSU5BTUkzSGo4SUFuajdp?=
 =?utf-8?B?Q0luSXRIMEd0djlXc1BvSXFJYmxPTGFFY0k2VDkxbG1MblBERmNmV2NGTnZV?=
 =?utf-8?B?RnRRY2U4TGxJeGJpYk1iMWZlU0hSdE10blR1Y1dsN3k3L010N2FOd1RLTndH?=
 =?utf-8?Q?AKNoHsGJ4Ghyzx8cmxC7housJ4rY9qpXmswe6tM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c34a1aa-e1fd-4511-7dd5-08d960f3f619
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5304.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2021 20:25:17.2856 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wNn/xOGjJx18tiUQblrtLwS7w4Kl4538TGk72olxvjf9Gsb9hSM9WdEvc++alUqP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5288
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



On 2021-08-16 9:59 a.m., Leo Li wrote:
> 
> 
> 
> On 2021-08-13 3:21 p.m., Liu, Zhan wrote:
>> [AMD Official Use Only]
>>
>> [AMD Official Use Only]
>>
>> [why]
>> dcn301_calculate_wm_and_dl() causes flickering when external monitor is
>> connected.
>>
>> This issue has been fixed before by commit 0e4c0ae59d7e
>> ("drm/amdgpu/display: drop dcn301_calculate_wm_and_dl for now"), however
>> part of the fix was gone after commit 2cbcb78c9ee5 ("Merge tag
>> 'amd-drm-next-5.13-2021-03-23' of
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fagd5f%2Flinux&amp;data=04%7C01%7Csunpeng.li%40amd.com%7C723f9131e57b4bd99db508d960be2441%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637647192045690562%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=f2gL9TVAvdXlCbsZCDa2prF1J4l2ZDbpY8L2f6vK7as%3D&amp;reserved=0 
>> into drm-next").
>>
>> [how]
>> Use dcn30_calculate_wm_and_dlg() instead as in the original fix.
>>
>> Fixes: 2cbcb78c9ee5 ("Merge tag 'amd-drm-next-5.13-2021-03-23' of 
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fagd5f%2Flinux&amp;data=04%7C01%7Csunpeng.li%40amd.com%7C723f9131e57b4bd99db508d960be2441%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637647192045690562%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=f2gL9TVAvdXlCbsZCDa2prF1J4l2ZDbpY8L2f6vK7as%3D&amp;reserved=0 
>> into drm-next")
>> Signed-off-by: Nikola Cornij mailto:nikola.cornij@amd.com
>> ---
>>   .../amd/display/dc/dcn301/dcn301_resource.c   | 96 +------------------
>>   1 file changed, 1 insertion(+), 95 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c 
>> b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
>> index 9776d1737818..912285fdce18 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
>> @@ -1622,106 +1622,12 @@ static void 
>> dcn301_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *b
>>          dml_init_instance(&dc->dml, &dcn3_01_soc, &dcn3_01_ip, 
>> DML_PROJECT_DCN30);
>>   }
>>
>> -static void calculate_wm_set_for_vlevel(
>> -               int vlevel,
>> -               struct wm_range_table_entry *table_entry,
>> -               struct dcn_watermarks *wm_set,
>> -               struct display_mode_lib *dml,
>> -               display_e2e_pipe_params_st *pipes,
>> -               int pipe_cnt)
>> -{
>> -       double dram_clock_change_latency_cached = 
>> dml->soc.dram_clock_change_latency_us;
>> -
>> -       ASSERT(vlevel < dml->soc.num_states);
>> -       /* only pipe 0 is read for voltage and dcf/soc clocks */
>> -       pipes[0].clks_cfg.voltage = vlevel;
>> -       pipes[0].clks_cfg.dcfclk_mhz = 
>> dml->soc.clock_limits[vlevel].dcfclk_mhz;
>> -       pipes[0].clks_cfg.socclk_mhz = 
>> dml->soc.clock_limits[vlevel].socclk_mhz;
>> -
>> -       dml->soc.dram_clock_change_latency_us = 
>> table_entry->pstate_latency_us;
>> -       dml->soc.sr_exit_time_us = table_entry->sr_exit_time_us;
>> -       dml->soc.sr_enter_plus_exit_time_us = 
>> table_entry->sr_enter_plus_exit_time_us;
>> -
>> -       wm_set->urgent_ns = get_wm_urgent(dml, pipes, pipe_cnt) * 1000;
>> -       wm_set->cstate_pstate.cstate_enter_plus_exit_ns = 
>> get_wm_stutter_enter_exit(dml, pipes, pipe_cnt) * 1000;
>> -       wm_set->cstate_pstate.cstate_exit_ns = 
>> get_wm_stutter_exit(dml, pipes, pipe_cnt) * 1000;
>> -       wm_set->cstate_pstate.pstate_change_ns = 
>> get_wm_dram_clock_change(dml, pipes, pipe_cnt) * 1000;
>> -       wm_set->pte_meta_urgent_ns = get_wm_memory_trip(dml, pipes, 
>> pipe_cnt) * 1000;
>> -       wm_set->frac_urg_bw_nom = 
>> get_fraction_of_urgent_bandwidth(dml, pipes, pipe_cnt) * 1000;
>> -       wm_set->frac_urg_bw_flip = 
>> get_fraction_of_urgent_bandwidth_imm_flip(dml, pipes, pipe_cnt) * 1000;
>> -       wm_set->urgent_latency_ns = get_urgent_latency(dml, pipes, 
>> pipe_cnt) * 1000;
>> -       dml->soc.dram_clock_change_latency_us = 
>> dram_clock_change_latency_cached;
>> -
>> -}
>> -
>> -static void dcn301_calculate_wm_and_dlg(
>> -               struct dc *dc, struct dc_state *context,
>> -               display_e2e_pipe_params_st *pipes,
>> -               int pipe_cnt,
>> -               int vlevel_req)
>> -{
>> -       int i, pipe_idx;
>> -       int vlevel, vlevel_max;
>> -       struct wm_range_table_entry *table_entry;
>> -       struct clk_bw_params *bw_params = dc->clk_mgr->bw_params;
>> -
>> -       ASSERT(bw_params);
>> -
>> -       vlevel_max = bw_params->clk_table.num_entries - 1;
>> -
>> -       /* WM Set D */
>> -       table_entry = &bw_params->wm_table.entries[WM_D];
>> -       if (table_entry->wm_type == WM_TYPE_RETRAINING)
>> -               vlevel = 0;
>> -       else
>> -               vlevel = vlevel_max;
>> -       calculate_wm_set_for_vlevel(vlevel, table_entry, 
>> &context->bw_ctx.bw.dcn.watermarks.d,
>> -                                               &context->bw_ctx.dml, 
>> pipes, pipe_cnt);
>> -       /* WM Set C */
>> -       table_entry = &bw_params->wm_table.entries[WM_C];
>> -       vlevel = min(max(vlevel_req, 2), vlevel_max);
>> -       calculate_wm_set_for_vlevel(vlevel, table_entry, 
>> &context->bw_ctx.bw.dcn.watermarks.c,
>> -                                               &context->bw_ctx.dml, 
>> pipes, pipe_cnt);
>> -       /* WM Set B */
>> -       table_entry = &bw_params->wm_table.entries[WM_B];
>> -       vlevel = min(max(vlevel_req, 1), vlevel_max);
>> -       calculate_wm_set_for_vlevel(vlevel, table_entry, 
>> &context->bw_ctx.bw.dcn.watermarks.b,
>> -                                               &context->bw_ctx.dml, 
>> pipes, pipe_cnt);
>> -
>> -       /* WM Set A */
>> -       table_entry = &bw_params->wm_table.entries[WM_A];
>> -       vlevel = min(vlevel_req, vlevel_max);
>> -       calculate_wm_set_for_vlevel(vlevel, table_entry, 
>> &context->bw_ctx.bw.dcn.watermarks.a,
>> -                                               &context->bw_ctx.dml, 
>> pipes, pipe_cnt);
>> -
>> -       for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
>> -               if (!context->res_ctx.pipe_ctx[i].stream)
>> -                       continue;
>> -
>> -               pipes[pipe_idx].clks_cfg.dispclk_mhz = 
>> get_dispclk_calculated(&context->bw_ctx.dml, pipes, pipe_cnt);
>> -               pipes[pipe_idx].clks_cfg.dppclk_mhz = 
>> get_dppclk_calculated(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx);
>> -
>> -               if (dc->config.forced_clocks) {
>> -                       pipes[pipe_idx].clks_cfg.dispclk_mhz = 
>> context->bw_ctx.dml.soc.clock_limits[0].dispclk_mhz;
>> -                       pipes[pipe_idx].clks_cfg.dppclk_mhz = 
>> context->bw_ctx.dml.soc.clock_limits[0].dppclk_mhz;
>> -               }
>> -               if (dc->debug.min_disp_clk_khz > 
>> pipes[pipe_idx].clks_cfg.dispclk_mhz * 1000)
>> -                       pipes[pipe_idx].clks_cfg.dispclk_mhz = 
>> dc->debug.min_disp_clk_khz / 1000.0;
>> -               if (dc->debug.min_dpp_clk_khz > 
>> pipes[pipe_idx].clks_cfg.dppclk_mhz * 1000)
>> -                       pipes[pipe_idx].clks_cfg.dppclk_mhz = 
>> dc->debug.min_dpp_clk_khz / 1000.0;
>> -
>> -               pipe_idx++;
>> -       }
>> -
>> -       dcn20_calculate_dlg_params(dc, context, pipes, pipe_cnt, vlevel);
>> -}
>> -
>>   static struct resource_funcs dcn301_res_pool_funcs = {
>>          .destroy = dcn301_destroy_resource_pool,
>>          .link_enc_create = dcn301_link_encoder_create,
>>          .panel_cntl_create = dcn301_panel_cntl_create,
>>          .validate_bandwidth = dcn30_validate_bandwidth,
>> -       .calculate_wm_and_dlg = dcn301_calculate_wm_and_dlg,
>> +       .calculate_wm_and_dlg = dcn30_calculate_wm_and_dlg,
> 
> Hi Zhan,
> 
> Using dcn30_calculate_wm_and_dlg smells fishy, IIRC watermark
> calculations for DPUG and APU are very different. It's likely that
> you're now picking up corrupted values form the wm_table.
> 
> Take a look at how struct wm_table is populated in vg_clk_mgr.c v.s.
> dcn30_clk_mgr.c. For APU, wm_table.entries are populated, whereas for
> DGPU, wm_table.nv_entries are populated. .entries and .nv_entries are
> under a union, with very different struct definitions.
> 
> Have you taken a look at whether the pstate latency and sr enter/exit
> latency values being used after your change are sensible? It could be
> that you simply needed to raise these watermarks.
> 
> Thanks,
> Leo

After some DMs, it looks like this change is simply restoring an
accidental revert that occurred due to a recent rebase. Given that this
is needed to fix a regression,

Acked-by: Leo Li <sunpeng.li@amd.com>

Nevertheless, this still looks iffy. I'm not sure if the pstate and sr
enter/exit latencies being used here are what you expect.

Thanks,
Leo

> 
>>          .update_soc_for_wm_a = dcn30_update_soc_for_wm_a,
>>          .populate_dml_pipes = dcn30_populate_dml_pipes_from_context,
>>          .acquire_idle_pipe_for_layer = 
>> dcn20_acquire_idle_pipe_for_layer,
>> -- 
>> 2.31.1
>>
