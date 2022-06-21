Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19616C43334
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jun 2022 15:18:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A844710F5B5;
	Tue, 21 Jun 2022 15:18:18 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2040.outbound.protection.outlook.com [40.107.100.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF82E10F5B5
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jun 2022 15:18:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D9cQ1/4O7JA3yC6rSFnI+PE/YnlK7dPDrvrQSpzO7bewdjJ7pAZVswV/xiIfbES81dpuoeqOteXr/yVSibcWs85YQ4uOjG4kAQKytjsyG0+X0qMDqRkdJeV0ItMIi+hcXLGMErLwGcoah9HlySia7+lLz6Mjo3EkB1NevWHC0FJ4GNz7vt7Ff3fr3vDNzPXCpL/reAi3FcC7/KU+Sxbk5UoQcNojf6kTZzON2lbWkfpAKpQkeIEf075cYf3LBAf9PvDMyQT0csnHnSYbKmKoEEEsg4jLxUwtuQ8V0kCjd3ZJSY3z/kC1zENuy+jX1Ptnax7BrC/DJT18ird93D4Zbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mbAzHXu76MCDtLEvkglkb9Pk0tIVDWn0Y1utFh1zitc=;
 b=VVzsg63AItAsQXDRUGRXf9ZfK10cmzTf/udJWZndE5ahq5kW5UtXX8bD9OSQWkTg5MNTqKMxpiuNvtkfDhG7H8ML/bfvJHRIyIesD8cB8+Q4BwH0aaIjefV2bLUjG8KceDkZ+vleWxwuRzTHptWkENQW+tiTJ5JOoyPH9dG/eBu6naYcabP41+jv+ZPGCNyxnBQY9+6fjmEJE4zuKD+nBKfzWBVNb1IpfFz7gjJJHkqMHBsIgcVDWIxqACBvqYVk0IINNFq9TKnxIsFrxB0FuyNxEOA696SaFRdRC6PMBjeN14X+3Ke1plrDMeE1V5FvGIaZabTMPEWsnf++jk3t9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mbAzHXu76MCDtLEvkglkb9Pk0tIVDWn0Y1utFh1zitc=;
 b=3vP5zZ/P69ZFkMZS1Gc3FL10YK6Q5w958EqfzeH4nn9OX7t4BX4HpnUnkh8sh27C3aLUNpWvgwOwfuSf3nf7AbaoEs0HcThW8CaZGfDoyyPLODEBJOWVUDJfgLNC5PrjgbwHXNaG4S10YgZGCTB4l6Qo1QeNG8BX7xG1k5AJ9Nk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by BY5PR12MB3860.namprd12.prod.outlook.com (2603:10b6:a03:1ac::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Tue, 21 Jun
 2022 15:18:11 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 15:18:10 +0000
Message-ID: <72b212ef-1100-6d04-8afc-d1f196e24158@amd.com>
Date: Tue, 21 Jun 2022 11:18:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] amd/display/dc: Fix COLOR_ENCODING and COLOR_RANGE doing
 nothing for DCN20+
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 "VURDIGERENATARAJ, CHANDAN" <CHANDAN.VURDIGERENATARAJ@amd.com>
References: <20220616012127.793375-1-joshua@froggi.es>
 <CADnq5_NdAmAJ93A8ADVYzvYN=-hdWACxJyeBAfgmxc6_-RUq-Q@mail.gmail.com>
 <MW4PR12MB5668626C2F2357142755239896B39@MW4PR12MB5668.namprd12.prod.outlook.com>
 <CADnq5_NGcwG0QP4tL5Wtr_9+acUjHZUarK6-ubuiqnapuPzLoA@mail.gmail.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <CADnq5_NGcwG0QP4tL5Wtr_9+acUjHZUarK6-ubuiqnapuPzLoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0111.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::11) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 667d8316-1b3b-4df8-880b-08da53994090
X-MS-TrafficTypeDiagnostic: BY5PR12MB3860:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3860C61A3A3AEA84421EBDD58CB39@BY5PR12MB3860.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SJzRHtczDBUxXykP+4cuNuV2TqxIt+MCVduNebVDUGEHPn0FW3M/+Uhe5NMo+8pbSAg2X+wLNn43RcRUBYgCJRJW6geBAQT7nQhavGhbyaA9aL6wuV5hmlaArQsP96xkZwe6viRtP6UvZI4ZUBvCafxQ0kKoPabedpfYcoM2VsE92/AbfoggwLjt7kRpVIujIYcVUdeRUiNqVLzmOL+jd4N7ZbjPyFgLHJID6AMgwRjD3VjxEhGYlWPvqSgS8PnP5cta7J4eff4GDg0G+DZkeVgKh+1HY5lgep2iE+GL7IecmQZjMOKvLKUNpyXoMztqtdJXvbjavglmkYL0c55wfR66CQYlwn+hbnsbH9fTGjNRi1JI04nwHPMNMMOLzjfHAkLU6CjNrZU7WEkYl0R8Zu7Z4a5Qv7W4Pl88GX4XGYLxN9cw2zlKT6vV2Ig4yEN7ZGQMf+w6nInDAuvKg9FM2XbqECv35yI6VyxNdwZ7hWop+y4DhZZRgeQiwKZ9lnYMdd6bDpjODV0CrGzHRs/6aO0bxacpbn2P57JeU8T3HkCIGuTAG0/sNooAUc1IKbcXkMHTLUR0Q61uNrX4DrTEV+33Y0awSQ1ra3x4hAzYCQ8F9AGrXnGicFvccEZ9utzG6/WPeamXE27ZHjNeLDfhTZ4PD4XrkfeY0IKZny/ceQ5o5ggDPpdvZlhVPmuu6RBdGf0MN6LAbEVMk6hv1klrYx+P6x2uYuFDr86t1CWDO0qfy36JzP8CCjGjNke9cyqM51ZYpCNN26Y5XB78iMkaM51wGxG4feKS3sMRxN2zvvHOPaQj0tyDG3O/miYwWug27uMGJp/jnERLEVPYJpw0bw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(396003)(39860400002)(376002)(346002)(366004)(6506007)(6512007)(26005)(5660300002)(53546011)(8936002)(44832011)(478600001)(966005)(6666004)(6486002)(41300700001)(2906002)(83380400001)(2616005)(38100700002)(31696002)(86362001)(186003)(36756003)(110136005)(54906003)(31686004)(316002)(6636002)(4326008)(66476007)(66556008)(8676002)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlNsN0VvRGU1RUJmYjl5Qk80QUwralllV2pYVW43eVRkcUVwa3A1ckZ0ajB3?=
 =?utf-8?B?VmloQ1hobkxWa2dFcHdaMkFURkcwMjlrSlhsR05KU0ErWDBYWWZKb2lNU2E4?=
 =?utf-8?B?ejdOWHJNZmhUTlNaZWJJQ2J2NlRBTEUzQWhONlIzRFlTZE1RQ2RENEIwNERr?=
 =?utf-8?B?N01ydDk5aUx3OExBbWYyMHBvNXNJNXdOOGZFdGZoNVplSnV6MC9Qa2JkMWJF?=
 =?utf-8?B?Zldmd2RGYkx2TktNUEZaVHVBTGRvazdnUnBiRDNERlRhc1hVa0ZYOERCM2lj?=
 =?utf-8?B?dzdYbklCbjJuS2gwRjQ2Q3djMzJkaEVWWm5ISVdrdVFXc1RoNlhhTTZyaGIy?=
 =?utf-8?B?ZXVwR2VjV2R4ZTNJSk9JcEN2VWFzUE1WZFlmRUZHVm1QZHczazg1VDRheUVl?=
 =?utf-8?B?MXY3S1VlY295NngxMGNIVUtJMlc1QVY3VHhBTC83OFNGU3BHU29HSEFvc1JT?=
 =?utf-8?B?WHdGSGJwNkZscTRKS0tCbVFsYVpwdmpDQnA3dldITjRuYWZqSDJtMTV4d1Fs?=
 =?utf-8?B?Nk11OU1Ea1BWb2xUd2MrRGVqeHNFaStYSjFrTnpianU3UGNMcEs5dFQ0NFpF?=
 =?utf-8?B?QXNzYzk5cW5YeVVnRTJLaWt1Y2dYUVVRbU82RGYrR0tiRkhKRW95TytCOG40?=
 =?utf-8?B?czBZdFhtMDdDakNOZW5UdFFXOWlWMlRRcXI2NVlIVmsyMjF0dWNVK1k3RnNa?=
 =?utf-8?B?L05ZNU1NaGljZ3BtZS9YWk5GUjdVbnNrUm9HSVJkN1ZTelc4UnpIcWEwa24v?=
 =?utf-8?B?bmxMdWl3QTlQeEJVdnpVMTEyeHI2MUxBeXVSRm9DandXZjZXRFFtOEZyQ0tT?=
 =?utf-8?B?M2ZEUlJEb1FTUlRVTDJJcHZHL1VNR2lkb3NBN3FTdjJNVm53cXduWlZ3ODla?=
 =?utf-8?B?ZTRLbjg0Z0pHY1pFWnZJSHBHZGZGbnJHaDRBZUhzVzBPc3pvSXhtNjVQcHVF?=
 =?utf-8?B?bG9BVnFIVys4cHlMSmg2NURlYlRSWDFCMGlmZDNGRE4yTWxXRGV1eitXOHZD?=
 =?utf-8?B?Mk9kaGNzM0pKSWhGL29RdlNsTHl0S0dYMyt6ZytrUWZYM2NIdnlaMFhYdFFJ?=
 =?utf-8?B?aTVOVXU2ZjVZeElSeXkyWFV3ZHBYbWdQd21BeW1RNEtWUU9neEhiMmZVeDlx?=
 =?utf-8?B?UzRma3JVbVE5Uk5xdWdCeWwrN0tjbEdDVGFHaW5hWVlDRTBnOUtrZ010K3U5?=
 =?utf-8?B?R3gyb3dOdE1hUkxjbEhJY1V6SlRaVURPOVBpdmlRN2ZrZVhMT2hVblhOUlNj?=
 =?utf-8?B?L1ZLK2NrVnQyUTJOV2tkbCtwQjJlQy9LY2xEVGtLbnpUUkJVano4ZVc5V1ps?=
 =?utf-8?B?Qm5ieHRSSktGeWhaVXhLblV0UHZOSllIOUhRK0tJM3FteHZtK0xPQkltTXJi?=
 =?utf-8?B?dGVzNXRVbExUZG1zWHUwVXY3V0piTGw1S01lYkpkZjd6WE9CTzN3Z09oTjha?=
 =?utf-8?B?bXVsWFVESjNiMC9hWUcyT0JCYndUVk5iY0dBYVVqZCtoc1RNM09YZ1AxMm8v?=
 =?utf-8?B?TDEzOVhqVGY1MWlHa1E5Y2tOeTY0VGtMN2pCM0UzNkdsbDJDV0MrY0ppbWY3?=
 =?utf-8?B?RjBSS25HaTJUT3pIVTBKeWlkbzFKVVUvNTBiUkNidVhyWXpzSjc1dWxxVkJz?=
 =?utf-8?B?YVV5eWdML1A2Z0pPeVJiVEFBUTdzTVlMMnlEVUIwUGZkVFpXYTJGMThJWVBr?=
 =?utf-8?B?S255SUpFSnhqanRFLzVab0cydkxFeTQvaFRmcERUYVNONG9LN0FMWEpkU081?=
 =?utf-8?B?bHMyL1lZNVJKWFZRY1ZZZG91TWdtZWJJbXJyMUZqeEpCZVFQaGFoWkVUOFda?=
 =?utf-8?B?WXBPN1pwNit6Mkdlc1IwK1E5TlNINUt4b0ltVllhM1N3bHFNTmFtSURtbmlR?=
 =?utf-8?B?TDVBcTFMTkVBV1ZRUmlOczNnczl1RzU3QVZReU1YN21pWXNFZkNENnh4Slpa?=
 =?utf-8?B?NTRSQ2RJRnNIUENnWktmYURyR0JIenlSa0ZNekQyQ2VOMDJwQ0JXMFB4WE15?=
 =?utf-8?B?Skd4TGJ6MFZoRWlzSHZPcWlHYTQ3Q1J3Z1NYWWJ0MkpPMjZRdlhZZDBBN2kr?=
 =?utf-8?B?T0syNFo0NEN2WFJLRzk2N2RVa0IydkFFWXlWRjhtWkZtaEE2WnVFOVlsOTVZ?=
 =?utf-8?B?bTRvTzB2am9OZmdvRWNNS2pPUURYRlNFV2VMK3VWbmF1bytPTlBGd0daSjRm?=
 =?utf-8?B?SHRQNWdJMGg2UHFOaHB1UFM1ZEdxeVJWb3dISkdaRVMzYmR3UU9xeU1MZ2FE?=
 =?utf-8?B?QjVlTWVxMlorOUgyYTRuT0FramlQTHVXQmswOW54dlYwbXE1VnBnTUJTcnpu?=
 =?utf-8?B?K01tcWp4bXdsNzJTOGRFcDFBRXp4VkY0THRFWS9sWUZFOXdPKzJRUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 667d8316-1b3b-4df8-880b-08da53994090
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 15:18:10.7942 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W177x/IvHfA+ZQDS4mEc4fR/6B/X17M2i/C4UA1r5Zzrmu0fy1B/HRdqujE3YVlPoP1h8T+ufVgfENAJnXzpJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3860
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
Cc: Joshua Ashton <joshua@froggi.es>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-06-21 09:15, Alex Deucher wrote:
> On Mon, Jun 20, 2022 at 8:46 PM VURDIGERENATARAJ, CHANDAN
> <CHANDAN.VURDIGERENATARAJ@amd.com> wrote:
>>
>> Hi Alex,
>>
>> I think this was pushed earlier by Harry.
>> Not sure why it did not get merged.
>> https://www.spinics.net/lists/stable/msg543116.html has the history.
> 
> I guess it never landed?  I don't see it in the git history.
> 

My bad, and thanks for the patch, Joshua.

Harry

> Alex
> 
>>
>> BR,
>> Chandan V N
>>
>>> Applied.  Thanks!
>>>
>>> Alex
>>>
>>> On Wed, Jun 15, 2022 at 9:21 PM Joshua Ashton <joshua@froggi.es> wrote:
>>>>
>>>> For DCN20 and above, the code that actually hooks up the provided
>>>> input_color_space got lost at some point.
>>>>
>>>> Fixes COLOR_ENCODING and COLOR_RANGE doing nothing on DCN20+.
>>>> Tested using Steam Remote Play Together + gamescope.
>>>>
>>>> Signed-off-by: Joshua Ashton <joshua@froggi.es>
>>>> ---
>>>>  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c   | 3 +++
>>>>  drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.c | 3 +++
>>>>  drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c   | 3 +++
>>>>  3 files changed, 9 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c
>>>> b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c
>>>> index 970b65efeac1..eaa7032f0f1a 100644
>>>> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c
>>>> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c
>>>> @@ -212,6 +212,9 @@ static void dpp2_cnv_setup (
>>>>                 break;
>>>>         }
>>>>
>>>> +       /* Set default color space based on format if none is given. */
>>>> +       color_space = input_color_space ? input_color_space :
>>>> + color_space;
>>>> +
>>>>         if (is_2bit == 1 && alpha_2bit_lut != NULL) {
>>>>                 REG_UPDATE(ALPHA_2BIT_LUT, ALPHA_2BIT_LUT0, alpha_2bit_lut->lut0);
>>>>                 REG_UPDATE(ALPHA_2BIT_LUT, ALPHA_2BIT_LUT1,
>>>> alpha_2bit_lut->lut1); diff --git
>>>> a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.c
>>>> b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.c
>>>> index 8b6505b7dca8..f50ab961bc17 100644
>>>> --- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.c
>>>> +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.c
>>>> @@ -153,6 +153,9 @@ static void dpp201_cnv_setup(
>>>>                 break;
>>>>         }
>>>>
>>>> +       /* Set default color space based on format if none is given. */
>>>> +       color_space = input_color_space ? input_color_space :
>>>> + color_space;
>>>> +
>>>>         if (is_2bit == 1 && alpha_2bit_lut != NULL) {
>>>>                 REG_UPDATE(ALPHA_2BIT_LUT, ALPHA_2BIT_LUT0, alpha_2bit_lut->lut0);
>>>>                 REG_UPDATE(ALPHA_2BIT_LUT, ALPHA_2BIT_LUT1,
>>>> alpha_2bit_lut->lut1); diff --git
>>>> a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
>>>> b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
>>>> index 9cca59bf2ae0..3c77949b8110 100644
>>>> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
>>>> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
>>>> @@ -294,6 +294,9 @@ void dpp3_cnv_setup (
>>>>                 break;
>>>>         }
>>>>
>>>> +       /* Set default color space based on format if none is given. */
>>>> +       color_space = input_color_space ? input_color_space :
>>>> + color_space;
>>>> +
>>>>         if (is_2bit == 1 && alpha_2bit_lut != NULL) {
>>>>                 REG_UPDATE(ALPHA_2BIT_LUT, ALPHA_2BIT_LUT0, alpha_2bit_lut->lut0);
>>>>                 REG_UPDATE(ALPHA_2BIT_LUT, ALPHA_2BIT_LUT1,
>>>> alpha_2bit_lut->lut1);
>>>> --
>>>> 2.36.1
>>>>

