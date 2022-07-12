Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DAF6C43334
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 16:23:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BD9E10FA2C;
	Tue, 12 Jul 2022 16:23:46 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBAF510E4C8
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 16:23:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXFBbaIg+kufR7yAFGUaqIhSwbtcKYzhZMlQu0yvlfR6+v480Io6/tdRfsHaI4HwFQzoccybIu8NMcLbNv0/PRkUqXfD5qmWWL1Hd+Z9VTPGoJOiH55b2mWOeVNhMW+iBRsk/gX+GgY+MQwJvJVFdKPUWY5yKr5/PVoZosOfukHNga1u8FXt0/hbxtE3TFTES275z1WTfmW4fB6kivkaLPiy/BHi2C7XO7hblRr4MG08ciyq47/BeeUvJpE0tTX2fnTTLvcZgV+oid1BPg4meidQOIfDbsGAmcpf/ZbDXdX/R4dFcG2ft2NJvridUfxeNPwAvx9ln+SHMYAKOXNltQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0JjZwWMgYCOohDvD0tHq+db18ajZAubxTw17DLFE5I=;
 b=UbMGuaac8zCn4CrGip3mdlSlZOCR87DTnz7oRqaUhH27yj7WHfj7sLuBF/P3mrVZBzN6+kYAw4QKPDPRFB6SeiphdghR0f4m/dWT+ZULfWbUZVaqhiYaSt59YKR6ppzyTqs0bjYlMUzibGDB9+ZBa1O4j+qc0glmEH6kWbcGFWfqS9WeGu340yq03LY3xoRcC70CidHV2zZ3dzCnIQB5uItZblOe76T5Jm4Txc87EdaNKqvpBsA0pWn70/Q1iIBqdN9rP9IvGnzW1BDBHSLHqx5eKkexqYQlKXpLM/Mv3BdlM41JP9wykdxi1UTnv8txJIEoienu7Olw3gC7ojaB4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V0JjZwWMgYCOohDvD0tHq+db18ajZAubxTw17DLFE5I=;
 b=AU5fgBWo9+gh51dsvT7Hi0uQ5LdyMVj4dTGqjy2al19XXMwZLxuV+1D60wWIFcN/2XHTQMSMaRcoFcgKx9TJ7ODPyOKGkGsjOSQbv0ZbJUO12tuLrsjj/wcvIBDWxTgaHN0eyx5PXUviW/AjZoBCUSLUmU205T1rlRm9LBCquD4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by MN0PR12MB6125.namprd12.prod.outlook.com (2603:10b6:208:3c7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Tue, 12 Jul
 2022 16:23:43 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::d122:1dae:8445:2e43]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::d122:1dae:8445:2e43%7]) with mapi id 15.20.5417.016; Tue, 12 Jul 2022
 16:23:43 +0000
Message-ID: <54063997-bae5-7bea-92c1-577a0c6ecf29@amd.com>
Date: Tue, 12 Jul 2022 12:23:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amd/display: Add a proper DMI match for Precision
 devices
Content-Language: en-US
To: "Limonciello, Mario" <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220712155936.1700339-1-Rodrigo.Siqueira@amd.com>
 <94af9dab-951d-d426-b8cb-7f313189448f@amd.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <94af9dab-951d-d426-b8cb-7f313189448f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR15CA0009.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::22) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17ff087b-ba89-447e-0196-08da6422e330
X-MS-TrafficTypeDiagnostic: MN0PR12MB6125:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XHvnBdmNp5Jt+4N8Cj1lYzaqCOyMKaHY2f4O/scx0n91U8L4jKclkJVXuBuxBDcPpAY4o/oN/PEo3bGtA6apQtG3vfWMRDQSF6LkenyYCuTuaEbyXcgKnA6C4THrbjQKgYcc25LN+azP+JmBT2/Wg2ef0Kw0A9xbwFikZhBY30GuhDdfqeuc1FFzXCe1oBdTQn40yDj0KqqTydBqClgYZbozqU0dgSLSY5Vwac7pE7bHHx6j9QgJRHl5scGLsn5rcdU2J0YK7tOEsufZpV7KGaXqFh0SAw6T7j1nHk/CnUCzghBUFGMKE+WA2/9gYhAKrFZHERW1TEK4awBI1dNOCb0mrzk91/vN/2FtAGnUdLP/CNxsW+GlprXv3DZLGfQw6X6nDTAJct4+qIm0EIxX6wb0rInxASG3FN0j99vfTZz6OcZqOAuQqzKGLr3xaSGWWSYbGKdblFMSXOi9llPHvuZBfmlHVvM+u6jeDwg29go7uCM+I0Hs6q+/YhZb8xdg3t9QLpqAM87zbOduxb2SGovhLD2ACe7/OTuEhfUSfaxvB1AateWXDhTDNNGIzEWS/Ex7G29jnAE574skof2L+jGV7C15nsf9+Vfpys3uEQgvRIgH4FCMR5L16K8/JFIC9hGtCxCXBNWA6QjE5WM9jF2hjXzDB7gbRDJJFZ9J3H+m+GlQjyP1TPTAC29DTXc0TlrIzeBajAah02Oldr5tFt6bwnwWiK0DiATjeUTJKJFtllVkzGiHb+QzRDNGYq7Etmdx6QwKvLOllaDAoOEWKPSXvvllx8Tcaz8v2P/6/aiMoJgQk6r/BPjSOc3ne/PaAO00bZjNjTTzRL6BWXi4PjfIgxQyQFNr1d8ckrS/auQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(83380400001)(4326008)(86362001)(66946007)(8676002)(5660300002)(186003)(2616005)(66556008)(66476007)(478600001)(36756003)(31696002)(6486002)(31686004)(8936002)(54906003)(6506007)(53546011)(41300700001)(2906002)(316002)(26005)(6512007)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHdtMTMwbGEzTzRla3MyTi9XVUU2emo1Y2VZMW9vbFl4UHJUY2VMMmxldkdK?=
 =?utf-8?B?WnlENFBSK3ZSMmVpbWtoZEJrOVo4cVl4bjM5T3lvdlBWVmtaY0Z6L0owd3Fy?=
 =?utf-8?B?QmV4RlZaVnV6cm9iNmVoajF1U1RPdFk2WGlxM05KSWpsdjhNVWNFZzlXaGVZ?=
 =?utf-8?B?RXFHZ1VRL0VMNmxTQ2J4aEZlSmtuOEE3YlVhZkxxTFNTcW9jbGpJQXRibHZv?=
 =?utf-8?B?YmNuRW1ZUUlvSHhvS3pvNElWdWV5TDJ0WHRxM1dTOVJTOS96dDZ0M3BIQjR5?=
 =?utf-8?B?czNtWS9NUTZ1WWNzYUd2bXI1bnNSOHVGcUFRZ2xFaWlZNEJBLzBQYm0vV3Jv?=
 =?utf-8?B?WXJXM2RpRnRaZm5NNzZsWFYvTXo2ZWJOTlpXTmZheXVTaHh6V3ZwWDNDZ2dk?=
 =?utf-8?B?YVBFREJjdFR3azVkbzk2Q0lRbXhRVjRiSWtQYlorYjNuYU5yaEN1bE4rTWRW?=
 =?utf-8?B?MFphUUNya1RZTk1DN3lkSmJLZEJWcHliUmFFV1N0V2lFRkhYUS9rQzg5LzlW?=
 =?utf-8?B?ZlorKzJOd3FpZUdQMVpib2JjSFptSjl4OW1VK1NaZFJLWHlkOWpGcUd5OGgx?=
 =?utf-8?B?T3prbkpqOVFmR3ZwUTNDU1VlSFpJaHRtenVhQUlxSURYSDlaN2M2YjZibEN6?=
 =?utf-8?B?SmFDKzR3ZjArRnd5YlVZajlDMmZvK2dLZW00WkVacjV4V2cyaG1qa0ZtL1lo?=
 =?utf-8?B?YTgxK2tkd1k0MmhTN1pmdWlFbmIyQ0l1RDRManQwS05yWThLdkZ2Q0s2T3hv?=
 =?utf-8?B?RGRhOE5CeVBTb3VQM0tyOEZKRitRcWdSeWFjUVVFQXBRNmlUOU8rVmpFa2di?=
 =?utf-8?B?RVBrK0drUU52L0dKZGlobDBoNG8wM1R5SlY2R0RPR2xSdkZESWw3clJzZXAx?=
 =?utf-8?B?NGRoMHZMOFViVkt3QnZOYlJkeWFtOWozZDh5WXkzUnZ3SklGcFFlazdUR21H?=
 =?utf-8?B?Q0NGOVdSUS9QY25IWCtUNW5vMERnRktVZWJRQXN1MGd1cUtjOXF6Z3lBdTBv?=
 =?utf-8?B?Q0JvWXlZK29PUWpoWTFSTjFxRjBWZStGRE1pcmlmQ3FiaWdNM29WNGg5cmNZ?=
 =?utf-8?B?YksxYVVBSmR6VE95UmdFWXhLK1hXZFhacEtCV081VlJYdVRMeGIybzBHaEhF?=
 =?utf-8?B?am0vOU9LdXJJVWhhRytVWFA2SThEZlVGMmpCam5FRTlBOXFQN2pSK2pZVFlW?=
 =?utf-8?B?MlppejlUdnJ5dmZxcGVPMnVqcWhNcVU0ZVZ3cUx2TmgxdWw1NFFOdnJaUFIw?=
 =?utf-8?B?Y1YyWUxIa2sxV0MrbllURHVzUmlGVnNzaXNGbXNWZ1o5SWJ5aFE3aytuWnQ4?=
 =?utf-8?B?LzdKNlUxODV5SWd4TTg3MkhZM2hrUEoxNGNxNWxqZmVtVytRVFFpRGhsb0dz?=
 =?utf-8?B?ZGxtVWVYSVJYcEQ1UW10S1BJajlHV1ZHYVhySHdjMDBvSkpDa0sxUWtwMkhT?=
 =?utf-8?B?RDF3Q2lFN1FNaUlxdjE0Vm15TkpFWktJTCtrQzZZbHlHQk1kdnlkZ2FDWjE4?=
 =?utf-8?B?QVZKb2lUYXpuUmk2SXl1R0RpNEFBeTZMejBXWEhqbytGZGQ2eHlER0ZENTM3?=
 =?utf-8?B?WHpQZmx3OU9RdWVvVVlGTzRrUXAzQUxWdXo3ZWw1bG0rb1JLbm9Wbm1aWlZC?=
 =?utf-8?B?UU1KU0FKdXh0NkFxcXhNZlcvQVdUdzRmVmxZbTRUeEhHVEg4bEhpWGFadEFa?=
 =?utf-8?B?TENVVkRYcmJ1UkZBMDhxSFJpZEFjUnl6bkY2YjhEL0xvNC8rNDZDbkYxalpQ?=
 =?utf-8?B?YVJTTENFMDU3QzY5cnpRZy8rSDBVRHBNVnNyUTBOZGhvN2xHcVBkbWY1ZWVp?=
 =?utf-8?B?dW5tVmdnYlBZeC9KdjZyeCs5VDBiUmhTWTNWYmhoWXhVbXhzMzl6bkI5MU9l?=
 =?utf-8?B?Z0wxOVBTNTZMcXUxS3VuY3JVaWpwRWg3U0xTVEUyNTVtVithN0crazZXbGxj?=
 =?utf-8?B?S2xhWDllbkp2ZVNWd0tKRzJJRnJxVS90VWVZY1RVa1k4d3BCSVNqRHRsQUo4?=
 =?utf-8?B?Y2tXSllqQTZHQVRpSEVhcld5dG44aG9POHkzYTJCcUF6YkoyOC9SRDhQZmhi?=
 =?utf-8?B?M0pHWGNlVnBud25qOE5DazZSaHZsTzhtZ2VRc2hFdlN6OVNTNTNIUzkvNkxK?=
 =?utf-8?Q?2xTbZmrKA1jmZLw9R8uMdC6TH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ff087b-ba89-447e-0196-08da6422e330
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 16:23:43.0680 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IBErtqJuUie2GuJr+SGgjQrpcGomYFQ6gU9Vm68cE3raQfIOikdRkc7INClRLGzCKOeDDQvEmPLzqlFvW8IfpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6125
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
Cc: Qian Fu <Qian.Fu@dell.com>, Alex Deucher <alexander.deucher@amd.com>,
 Jerry Zuo <Jerry.Zuo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 12/07/2022 12:02, Limonciello, Mario wrote:
> On 7/12/2022 10:59, Rodrigo Siqueira wrote:
>> We had an MST fix for some DELL devices that got merged, but we missed
>> other products. This commit adds the other missing Precision devices.
>>
>> Cc: Mario Limonciello <mario.limonciello@amd.com>
>> Cc: Jerry Zuo <Jerry.Zuo@amd.com>
>> Cc: Qian Fu <Qian.Fu@dell.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Fixes: 9fcd8af669d7 ("drm/amd/display: Ignore First MST Sideband 
>> Message Return Error")
>> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>> ---
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c 
>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index e203d75834de..96a0be8508ce 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -1408,6 +1408,18 @@ static const struct dmi_system_id 
>> hpd_disconnect_quirk_table[] = {
>>               DMI_MATCH(DMI_PRODUCT_NAME, "Precision 3660"),
>>           },
>>       },
>> +    {
>> +        .matches = {
>> +            DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>> +            DMI_MATCH(DMI_PRODUCT_NAME, "Precision 3260"),
>> +    },
> 
> Just a nit here, the "}," should be indented one tab to the right.
> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

I made the requested change and merged it into amd-staging-drm-next.

Thanks
Siqueira

>> +    },
>> +    {
>> +        .matches = {
>> +            DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>> +            DMI_MATCH(DMI_PRODUCT_NAME, "Precision 3460"),
>> +        },
>> +    },
>>       {}
>>   };
> 

