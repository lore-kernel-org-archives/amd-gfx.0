Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BDD5C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jan 2022 16:26:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAD6B10F00B;
	Wed, 12 Jan 2022 16:26:03 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4A6C10EECA
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jan 2022 16:26:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XverqRmn/YOdpG4Bt/oy0K2E8uiQDRFxcA8YwlIdSlbmfh7+H6oqrPViu07Asnv9iM9xClTLwPkM09bsL1NqhLWueLUxyIeWB9pr/v3MoeEakkUklg251325hLZn2bAKhNSNM/pJ7XB+JVq9n7/nWSdpg1V6QOdGL98+fCWwZuvkg6lPeezmFjV5rMbtiVsIX/dfh3G47WY4LpMo48IoelcEErBUc+4P2sjWL1SJ2+UTFHeXINKYn+6TOZq3d19MXTRDc3KGuz5W5L4T9KeyxWNwdaK7bjmNG9yStgkYHBzzZ6Qrr+kpSxp7eECe0FwZiAWaxs6cfJELfktfIMOcKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FRXP8xOkFR0aGO7zpzt68z3cgCyekY7VpD4nPmU3ps=;
 b=PpO6/YaULKVN2QDZbb2JYildqc6vlbiY8RdQy6BG1kfFBaPCdxHlKY7t9xTAGxU5MrY2yRsbAVmdHls9r1oFzw+sAWVs76EAImOYcosthrkqWXamMoRhvGvRPrmcjmgJHXjlmlVil/A0LVK+A+YdGh1wCS9oDTUoGx35UyhGg5O43HeKYSI7mF356tzJ3xtKBiwk5uw2z/rFAGSc9lW5uu2Zn3xIlDlWlknYt7ddBT9VUT0kI6QuTWjMNbeyvjJIDcRhfxO+T0ubgSsy4ggei7y9GBO5O/g5b/fVqFZaejT+GWO/Tm3Kcg4HEYYmVDN3hYBIXYcgTAnNT9trPoq8hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FRXP8xOkFR0aGO7zpzt68z3cgCyekY7VpD4nPmU3ps=;
 b=FCSLJ2JHJW/HCToxbdeIuPogHdM0wLrImvj90Arzf/iFV7GtkSqNL5VDnOKkQgqQvF+Ec1PNiP5/SiKpN3EfvCBgwOxv0nxnqhb9vC+DAiQQPpISnN29IMlFF+KiJbkraOtdHeliWmu67sNHpNvgMRnrfzma/Ert+p8solENb5w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by BN8PR12MB3010.namprd12.prod.outlook.com (2603:10b6:408:63::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Wed, 12 Jan
 2022 16:25:59 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::dd4b:b67b:1688:b52]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::dd4b:b67b:1688:b52%9]) with mapi id 15.20.4888.010; Wed, 12 Jan 2022
 16:25:59 +0000
Message-ID: <282c1e7a-cf5f-f7cc-dbcc-9971a0f1b451@amd.com>
Date: Wed, 12 Jan 2022 11:25:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] drm/amd/display: Fix for otg synchronization logic
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20220112142727.16295-1-harry.wentland@amd.com>
 <20220112142727.16295-3-harry.wentland@amd.com>
 <CADnq5_MVeUXy1R=N5W92afEQujNffPuaFWcGPH1YD9gfiu=RBw@mail.gmail.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <CADnq5_MVeUXy1R=N5W92afEQujNffPuaFWcGPH1YD9gfiu=RBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0020.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::33) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fdcdc959-c8bf-4f05-d3f4-08d9d5e83799
X-MS-TrafficTypeDiagnostic: BN8PR12MB3010:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB301094F9D4219B48F3C4FD0D8C529@BN8PR12MB3010.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CwsJoktyqtrCBha2tKGxRf1859tbdeS9K25FLf2Dk4wwVQDGLL9UDQhbTKC+8SaD3R3N1so4LFc6HyO/EUwjNA089y9lNezzlvtWEusaZts2cSuZqVHdj8CmfAZeiChKmYxqQdjlw7TfhmWGmWXOnA+wAQRgYehlcNw+eNGuVjplKzcPQG4w8+WpLUvNRQjrtwX96yQV+a/jsASsem8NHR4Ujv2PQ4bhy2dWHGEDnWIf30ORjdA1PFv2zH5grQo8fGKHiebLKgsLvXl8KgiAsBr6+qYirVlSnfs9AhXbL/WCTC/ppha5q1cirRu9VveSgprRnpbaagoCrxMADyH5jT9Ny3gY5H/eA3EtLMCrlGjikOY1EtmJ5LgZ4OLqwyhAsj+iAu72gTaiBKi9pAV+EWLSADNeN7vqjJqgFaRBtcFqq7iLwmkg3N48MgZsaIcF9yLC11nxsihMY+EZ+48er8IxhCMpKW1fYqT9AbiaM/Vn85E2koVHd2ePvhvmrSWEGK8Qd8mueBNzo7UZsF2cOeIaUwAi8WJ8QLDicZX+/FAgr8e/33JtS0vhIacAaoKp5HI++XwmYEteM9M7o2RlN5PFo5PyOhy1CKSktAqZxkUXuNvuSkTUFhdVbZzYhqLr5YEMLNQayZjqhQ3gjQVUOdoq5kjg0D6CYe/r3qDhOGM6FxfGiZgGpTDUNbvdIvUZ+BxjyzjxDvi8kZPJgux50C8LDn23/AFNndALnV91LwGq2Q0XjB90OkFvik32GfaN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(38100700002)(8936002)(4326008)(44832011)(36756003)(31696002)(6486002)(66476007)(86362001)(2616005)(54906003)(66556008)(31686004)(186003)(6916009)(316002)(5660300002)(26005)(66946007)(6506007)(53546011)(6666004)(2906002)(508600001)(6512007)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHl3WDkvNkNITGxIOUdCeDNSM1NGeFJOcDAzNmcweSt6VWs4ZW9SU0NSQmMv?=
 =?utf-8?B?L3Y0cXk3SEYwcjNmaEE3b1gybkxoRDhMNEZSN3Nlb0h5U2Exbk0rVWxNN1hw?=
 =?utf-8?B?d095MllEaXFnUUxYUUpWekVKNDRGVCtXc29yNXJod1R4Z0h5NkVrMTBoM3hB?=
 =?utf-8?B?dlFQb0hkUVErK21wcGxlQUdpamh3aFcrS0QvNSsvbWRxS2xmTHJQYVJCcnVh?=
 =?utf-8?B?U1RUdEw3NkRGOVVGaTE3bnZnUG9nQkwrTFZIOVdxV1lZdGN0dDFMN0poZkFm?=
 =?utf-8?B?Z01Bd2ZENUQwVTJ5YnVidUdvYTZjbmUzL2s1eStCbm5SelNvbEtDZGgzNHhG?=
 =?utf-8?B?eHFlMmQ0b245U1F3cDBJalBrZ0JpZTU0WjUrZDNGc1QyS0VVRzFla0lhaFBN?=
 =?utf-8?B?SlgycEh3ajk1ZXB2aW1vekV5YndRRnNvanE4dFRWOGhuQUo0T0hUaHNtSUF0?=
 =?utf-8?B?M3UwUzl6NzJJS2VybllLMUdHSC9JdHpvOU8ralZiRUxuTzlkNDVCMXBKU3U0?=
 =?utf-8?B?VjNqYTFNdm93cUNkZERKTDg0SlF1ZVdBRTNETHpPVmNCS3h2OUhObSt1VVE2?=
 =?utf-8?B?cmthdlNjS2IxVGFBZUUzMG9uc1d4cXQzU1lETHJlNjYwck1SQ2FnT2lraDYw?=
 =?utf-8?B?MzhYQ1pZZVhIT05zWUpHbmtXMWVSc09kd1JQWU5UNzUzNm9rU2k3OWFObnBn?=
 =?utf-8?B?ZG96bS9VMzN4eUZuNUhUc3JzQnhGcFFWZWQ5YnRyQXZkZEhwcGZWQlk3a1pI?=
 =?utf-8?B?K2ZTcFlYQkZId3g4QzBGWWtuYmpCakZ6VHgyQmFZNnJGUURUUDNqVXJmWWRR?=
 =?utf-8?B?enRhNlZ3bERBeDF6RXRObzBXN2txM0EzaUJISDk3Vy80R29XVTM2cXozV3Qr?=
 =?utf-8?B?Uzh2SnZyVVZrTU03YjFVYjRSbUNnemxvR3FqamZlNFB4MTYzS280MGpEZ0k4?=
 =?utf-8?B?ajV5cFlBemJrMCtsOUVWUDFzK2Z0elFZWk9TenhoVWZZTldrbWV1M0RVMkJB?=
 =?utf-8?B?ZkkwdGJicTErUjNZZXNMZXlhbEtidStPa2ZMaXlBeG9uKzVNMVdkM0NWbHNT?=
 =?utf-8?B?L3VpUExpa2JYQVhWdlRDL2ZRb1Z4VGo2RldYWitCU0F1L2RwR3hjd1RLYmx4?=
 =?utf-8?B?YlI4VzBjYzhqTHFvWXNtdzEyNzI3M3daT2dPdnh3K0lKNDg2RlJ1V05lWUtV?=
 =?utf-8?B?OXlVUGZZdTIvSlo1cE43SEwyU3kzQy9JbDhZeHdPRnRDMkI5UEJHN2UxTnRq?=
 =?utf-8?B?QWZ2c1F4ZTFyZGdHa1NodDdxTUluTzlSUUlDOUsydWh3cDBha3F0UCtnNWl2?=
 =?utf-8?B?OWowa0hBREM5bURkc09ONDA5TlFmdFJJdzNPYkJlKy9iTmFCUnhzbHMzd0o1?=
 =?utf-8?B?S3U0eE9JQ3FlUi8xb3hyVGpoUytqRTdnWmxHZ0hQRU00NjdrM1FjdVZ4Tmh1?=
 =?utf-8?B?dnFQL25FTVdibFBHenp2L0Z2amorNnloclBGRzRpQ1d6SzlzOVBGYklRMDJi?=
 =?utf-8?B?MjFEeDhkV3k5dmdvMlF1dnh4bHNSUkE0ZGJGQldpTW9Tc2tkallJamxpelNF?=
 =?utf-8?B?RStCVXdXK2dRejlRVmNPL1crNjFlUVhWNTFwa09zNHJVLzZubVp6UmdmS0ti?=
 =?utf-8?B?MGVXNVZKTjNVQnV0cE0zaU9EampOUWtlbWVleG9SUUJBZ0RxR2dUcFBFQ0E4?=
 =?utf-8?B?YlR6WjVnQjlDK1ovMjJNRGhXZ3ZVUUNOTThuMmdIUXBzOVB4YUU5cS9kWEtF?=
 =?utf-8?B?QmlpVlZGNlE4V1R3UGFnSU4yWnIrZWpLVDhzVkVrbnlmQTJEcm9KY0htWlJY?=
 =?utf-8?B?S0tCbU43K3lUVXpXWGlyNnpoeU1lWXRRY2dDU2lCSnZ1d0loc3hFV0tqRk5K?=
 =?utf-8?B?ZVd6UTRZdFRqWFlTTW9hckFFSmZia3J6TnRJWGRLR3ROcmtnZ1FyS2JKV3ZU?=
 =?utf-8?B?b2JRSlhEWW9DSFJ3S2tsQm1yaS8rVGVxL09yK2dndDZrcXZWb01OSmFrcFNV?=
 =?utf-8?B?SlZKZkNiWmpmN1hUL1BBODI0ZGtGRHBZeDd2VmErS3BucituSi84cTUxdEhp?=
 =?utf-8?B?N2tYTzdkMFFBTzQ3VzZsa1IzbUUyNTRxMEtiQ1VNSnVIdjdkWW9GR0hIdFcr?=
 =?utf-8?B?TXIyU2N5NWJWU2ZnbEZBVjFVVUdHSEVPK3B4Z0I0WXFQS0NDZkp3RkhOSm9q?=
 =?utf-8?Q?XpH+W9cshbqtQcwzpLnHxRI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdcdc959-c8bf-4f05-d3f4-08d9d5e83799
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 16:25:59.4248 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WGj73xE9wh5TVDkNdIlg8wfOUz/xqHCimNx2jEl0Xi6waLfGet8lsmSlJLju0u11QRuOA1m/hNA5qMGPSaLZGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3010
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Jun Lei <Jun.Lei@amd.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Mustapha Ghaddar <mustapha.ghaddar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-01-12 10:53, Alex Deucher wrote:
> On Wed, Jan 12, 2022 at 9:28 AM Harry Wentland <harry.wentland@amd.com> wrote:
>>
>> From: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
>>
>> [Why]
>> During otg sync trigger, plane states are used to decide whether the otg
>> is already synchronized or not. There are scenarions when otgs are
>> disabled without plane state getting disabled and in such case the otg is
>> excluded from synchronization.
>>
>> [How]
>> Introduced pipe_idx_syncd in pipe_ctx that tracks each otgs master pipe.
>> When a otg is disabled/enabled, pipe_idx_syncd is reset to itself.
>> On sync trigger, pipe_idx_syncd is checked to decide whether a otg is
>> already synchronized and the otg is further included or excluded from
>> synchronization.
>>
>> v2:
>>   Don't drop is_blanked logic
>>
>> Reviewed-by: Jun Lei <Jun.Lei@amd.com>
>> Reviewed-by: Mustapha Ghaddar <mustapha.ghaddar@amd.com>
>> Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
>> Signed-off-by: meenakshikumar somasundaram <meenakshikumar.somasundaram@amd.com>
>> Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
>> Cc: torvalds@linux-foundation.org
> 
> Series is:
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> 

And merged. Thanks.

Harry

