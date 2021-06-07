Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49581C47094
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 18:37:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05D3A61073
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 18:37:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05D3A61073
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B28856E544;
	Mon,  7 Jun 2021 18:37:15 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF4776E544
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 18:37:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZF0eAA8/oBRNVYZfCYBLtDZg3N4Uw+1SnMC7BYmy7UnWvokAVbmX1xBg4qBBg03gexToaMLI2M5lfQI887r/vX6MaA7h/WcuEgddWlqYl1UrtowyBTV83csCIPOihEsFApCpXj10fdT5u6SouG5UqR/gNoyDfUI9wckBcUK+Y/EaH/5HA46EWqIM4HhkXQzJOt7idJ5R0yCV3zA/im59PLTDi45g58DFlsYzEesn7PZoQ+fn+uQJ76oxEfqESE5ivpLL5ovZ2KrTf8q8syPes33mz0w6DVLYGNR/9LX/C9wwT2IkASISV6suWoXtE4TP+9kw2V/RV/AJaDfuy+X6XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+dceLo6RM65fx+mwqjIhzL8K3qu1b0M0rBpX2LJIG4s=;
 b=QCUa8T3afl1iJZ7KgaRHevxSjkybGZsBkoJTAhnW37vSmfaADATqOoxnYgrJZk6kdeXgU1v3SsG9D6iddoXaGN/0JYt9qHvsmyXYlNqw+Z3PG3f2pKbkFtJx6/ei4RLkZ+bW1YmhV1whZ3OdkNWDQ6ZMxY0zGs9W2eCtQDbXVPnrNovuB97zHun1eWtq3VYODAOuLFLvwCe0Rka392/sypksh4++kixDUda4EjQnXVsvxJDyK5Emvp1Jhc2wTHlXj3WcO2t03wYhZQt9AYQLsPqed7alqBQNGPaso02uwZkG8CrSKs3/6E7QiBeOrBNPccJBNZrk+OH0xG/GXukrIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+dceLo6RM65fx+mwqjIhzL8K3qu1b0M0rBpX2LJIG4s=;
 b=vLiQ3VlbUxYfJTw/OUw/Fr9WWGgMrTrTmEKNYTmdm0TORTpJNWw3TchPUBr6FL6yABmPXp8JLQJPMXz5xpsj3nDVolLy+1FqtR/7kt9d0db81nbHtkp75DSG8Wrv/ey9VVLkQwYKu37JNZVTjFD61nYkwJSnGqH6fKj51VjBsEE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5443.namprd12.prod.outlook.com (2603:10b6:303:13a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Mon, 7 Jun
 2021 18:37:12 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::f455:b0b4:439:2753]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::f455:b0b4:439:2753%3]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 18:37:12 +0000
Subject: Re: [PATCH] drm/amd/display: Fix overlay validation by considering
 cursors
To: Sean Paul <seanpaul@google.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
References: <20210514114734.687096-1-Rodrigo.Siqueira@amd.com>
 <857025a9-2ac0-ed37-bc9e-a2be9e1780a9@amd.com>
 <CAC0gqY77ztqBfi3g_JYPVEqmahXVJ+bGePMK40WaPmgm4m6gVw@mail.gmail.com>
 <CAJUqKUrM6jrUrZkcfF=R7vNeoj4KvwymwM4tMVy09ndsPci-9Q@mail.gmail.com>
 <20210518185806.gsrzfcxcwo6o47kc@outlook.office365.com>
 <CAOw6vbLBTW03h1-amysV0rAn3YiT6z0C6jds5vPMz1rAEcDGow@mail.gmail.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <517b3280-f7aa-eab3-472e-5e23ad5dc243@amd.com>
Date: Mon, 7 Jun 2021 14:37:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <CAOw6vbLBTW03h1-amysV0rAn3YiT6z0C6jds5vPMz1rAEcDGow@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [198.200.67.154]
X-ClientProxiedBy: YQBPR01CA0136.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::36) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.50.3] (198.200.67.154) by
 YQBPR01CA0136.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:1::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.27 via Frontend Transport; Mon, 7 Jun 2021 18:37:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ea35a19-5950-4822-4f13-08d929e3439c
X-MS-TrafficTypeDiagnostic: CO6PR12MB5443:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB5443859260FB013CE7FB2CA68C389@CO6PR12MB5443.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5YXHiYhlbnFbHAyc9itWDy7YYbrY8J5JuODR+hloHJur64hFD7PhZ6SpTw3kOJAE35WuQ7TZJNDB+qNnNhqmwzm9+N0YEOyMEodnP50SKejZfADW7gBtHldf1rIwC/T9dyJg595t8j07qCulJTH+b3JJ03XIstLG6v7iqRLX886ULX2l50gZOqU8HQpnrdau1GtVXoemOsj/qXb2nwXXn9SJaHq4DueRvMIhpdy8XjaHfypBhdwO3UxP5ilyXKokpoYtywlOfSoFKWQDIN6gHDEiWi8r6yfAHe1icb8QEi/S2oEnfeQeLjsqQYQYSYv9tqtVahVoLAQwqOU408WF2pVGmhYTN56R8hjk6jtsIO1/NGHgSJKFtOz7jb47+AHGFZYh+2byhS1FnS74iTT02gqakrKEX6Xau7R4gWTL/p/s67hQGRAnYPhdRgL3IByI++xOC/HeICPm95eH9PXQDBEIU60T3rXSnDXQOa4wBA/GxqgFez4q+lnPhfkb1SafwRaEviTgzAYsJhlZFBQHLuLv3oO+JZ/+Ll5p0BrnFHZL/YfVa7CUKsJFI+6BB1Pij3AU5b31rZMeDrVjXFTmfvCyotbpTBeNhpcv6TpuobAE7h3ZUaTX+xEBjqeFT2t8PyIlLH5GBHCLUu6YwpiR97NWfbLdmRKk5xs1L5RT3sW7kvaNCQinEb6siL7rYBSMiJsFsb+GBx3r5d1FGX1NeMg6BL96Jz5pvmLUEqtCNiAVwoOuk2h7itob6yKoTACZtEzvpm5uaXgGewjEB1lyfVut4FnTqNWCArftAP7x5i8Op8EgSaAhr6hAxfPHYEbq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(31686004)(66476007)(186003)(5660300002)(316002)(26005)(36756003)(31696002)(16576012)(86362001)(38100700002)(2616005)(2906002)(956004)(110136005)(66946007)(54906003)(53546011)(6666004)(478600001)(966005)(44832011)(83380400001)(6636002)(8676002)(8936002)(6486002)(4326008)(66556008)(16526019)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?a2dWQnduaUVvZTRVbTNCZkhjZFdzQjB3SW1xT3dJa2srRVpQbk5wSUdQeGRq?=
 =?utf-8?B?b05qbkZ4cnlPWllJM1c3aHU1ZHpZaEFUMVlXMWIzZGhLU2lFemRTVzIxMjVY?=
 =?utf-8?B?ZERnakp5ZGduVHFRL1hTRUhKNWNDOHZhWUdYTWg4NFlvMDhtUjhDM3BzNnRF?=
 =?utf-8?B?QVJ6eTlybGlmWXhhaGx0bmJHTHhLS2s4d0cwUHFKd0JSUzA3QmoxRmxzNWFO?=
 =?utf-8?B?VlNUWDJPTVUxVFhDWnFOeWdmRDBBRU9jMVRpaXYydE1aWjJDdzZIR05POWlm?=
 =?utf-8?B?TzZZSWdEVHQvQ3BhZ1BpdkQvc05GQys5RVkvdkhySks1Nm9Vc0RHeG5rQnMr?=
 =?utf-8?B?QWdwQS9jb3ZLTmNxTHREQjRtS0FDOWszRGJMbnFlQjhmdXNmTmF3U05taU50?=
 =?utf-8?B?OCs3czVaakFmbzcwbDJSTXBIWDZockUxZGtEMk5XQlNTc2J4cGdnYkk0OGUx?=
 =?utf-8?B?czRhUkNhVlI4RTc3MUk4YnRDdnVyQm1ZRFNQN09yM25uYjdkcUVDSi9JVG5P?=
 =?utf-8?B?V21XRDIvelRQMFdwMVA4VzBxVmk0YmZJeU90OUxXL3dRZTBORlRGTDBhR3kz?=
 =?utf-8?B?eVN2SFJUZDZNK1ZTT2RkbHhjRWJzQUdQYXY4SUVHRktJR2xxa3FScnBuNzRF?=
 =?utf-8?B?aS9iUjhWTFVpNUpJZDBqei9wZHdTM0MvTGFaMXF5VnUrV21FY1VnelRjRWYw?=
 =?utf-8?B?YUJCTHdvNmZZTHJUbXpGWkYwdUk3c08zNXU0ZEFTSVA5VEZ1KzNacFJENlc2?=
 =?utf-8?B?Uzd5WkJDMk1GNEozT0g5T3o0elFxdmxaN3JrV09MWTlPN2Q2OGI1TXdpNkdq?=
 =?utf-8?B?SHZUYkpSaXEzWG05alExTjRhUWpoY2QrOXF3TkppOXk1aUdYYkxSaDNCeE5s?=
 =?utf-8?B?bFNsR216WHNxRGN3OG1HN1FDbFF3YnBGdW8walpTdXZja3ZseG12THh1dVAr?=
 =?utf-8?B?TmVoMDVWaHhhY01KTlljYVJETFFmSER4SW8xSldKd3d6SmJJR044MllUbFlx?=
 =?utf-8?B?cHJBVG96cDJRbXFmUWlWSUVaT0tmWXFmNHlDNGJZa2ladjcwY0xOMFNxcmxa?=
 =?utf-8?B?Tmt3THgwQjhLS0RQOUx3eUk3d3VZbUI5eVNzRXhzalZqa0YyYUxGbGdoL0pm?=
 =?utf-8?B?VFZmQXM3ck03U0RTT2tSTENod3RpQzltZmZtSjZ1TG80M3BnMWhyV05MR2cv?=
 =?utf-8?B?QjVNR25NUlZMVitvVjM5THFpd3VlNmlqU1dESTZiSktnRGNkTkZiZzFrZndo?=
 =?utf-8?B?SjdYcEc5M0RjakdpS1BscUFQYjhjZzV5QUZ4WlAybTBhMXh5TVZydjVmTXlt?=
 =?utf-8?B?YncrRlNQSVZ2VnR5NUw2R3pGUVRCN3RLVFZ6dG9zclFRaHpwNEZVUWo0U2hX?=
 =?utf-8?B?T3BrRHRNWWtjWkpsOUhzbERxQWpDSVIxSS81UlN4NEtvdzFaQnRkMjkwbkVZ?=
 =?utf-8?B?Z0NvV0JYN0NJOUM4T3J1aEdSTnUva3VvejFsRytycjNEcElqNldpOEdqZE5P?=
 =?utf-8?B?UjNhTFpzVE1GV09uaHB0anpFVndIbzV3MWFvdUhmVXRWeXpOYkZzcHVFckVX?=
 =?utf-8?B?Y3I3VzJTTGlIM05JMWhiTjhYZytxTkIyRmUzRzlkL1M4QXBqYnVjdlVOR3Br?=
 =?utf-8?B?YTFxbmJBa1dtbVA2MkJZU05laUc0b1IvYmJ5bzlZa25zemJOSjNlZ1ExTnlj?=
 =?utf-8?B?akNVRlN1eHRPYmd5TXhrdC82OHVKSHc0VHdyMzhka0FqdW5QVnBQaDhZUGFv?=
 =?utf-8?Q?F+PHPXjkZHV/5N57jo3OtS2Oo5i7+b9ne236q2F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea35a19-5950-4822-4f13-08d929e3439c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 18:37:12.0060 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IsfWFI87VwtIETPQl/CRsw7ZD5yyo/SLZ9e6pYFemMOHdBhOkaik0JQODliVwNqskifxFMs+LIeq+yfqJpg4yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5443
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
Cc: Mark Yacoub <markyacoub@chromium.org>, "Tianci . Yin" <tianci.yin@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Daniel Wheeler <daniel.wheeler@amd.com>, Nicholas Choi <nicholas.choi@amd.com>,
 Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 Mark Yacoub <markyacoub@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-06-07 2:19 p.m., Sean Paul wrote:
> On Tue, May 18, 2021 at 2:58 PM Rodrigo Siqueira
> <Rodrigo.Siqueira@amd.com> wrote:
>>
>> On 05/14, Mark Yacoub wrote:
>>> On Fri, May 14, 2021 at 12:31 PM Mark Yacoub <markyacoub@google.com> wrote:
>>>>
>>>> On Fri, May 14, 2021 at 11:28 AM Harry Wentland <harry.wentland@amd.com> wrote:
>>>>>
>>>>> On 2021-05-14 7:47 a.m., Rodrigo Siqueira wrote:
>>>>>> A few weeks ago, we saw a two cursor issue in a ChromeOS system. We
>>>>>> fixed it in the commit:
>>>>>>
>>>>>>  drm/amd/display: Fix two cursor duplication when using overlay
>>>>>>  (read the commit message for more details)
>>>>>>
>>>>>> After this change, we noticed that some IGT subtests related to
>>>>>> kms_plane and kms_plane_scaling started to fail. After investigating
>>>>>> this issue, we noticed that all subtests that fail have a primary plane
>>>>>> covering the overlay plane, which is currently rejected by amdgpu dm.
>>>>>> Fail those IGT tests highlight that our verification was too broad and
>>>>>> compromises the overlay usage in our drive. This patch fixes this issue
>>> nit: s/drive/driver?
>>>>>> by ensuring that we only reject commits where the primary plane is not
>>>>>> fully covered by the overlay when the cursor hardware is enabled. With
>>>>>> this fix, all IGT tests start to pass again, which means our overlay
>>>>>> support works as expected.
>>>>>>
>>>>>> Cc: Tianci.Yin <tianci.yin@amd.com>
>>>>>> Cc: Harry Wentland <harry.wentland@amd.com>
>>>>>> Cc: Nicholas Choi <nicholas.choi@amd.com>
>>>>>> Cc: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
>>>>>> Cc: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
>>>>>> Cc: Mark Yacoub <markyacoub@google.com>
>>>>>> Cc: Daniel Wheeler <daniel.wheeler@amd.com>
>>>>>>
>>>>>> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>>>>>> ---
>>>>>>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 +++++++++-
>>>>>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>>>> index ccd67003b120..9c2537a17a7b 100644
>>>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>>>> @@ -10067,7 +10067,7 @@ static int validate_overlay(struct drm_atomic_state *state)
>>>>>>       int i;
>>>>>>       struct drm_plane *plane;
>>>>>>       struct drm_plane_state *old_plane_state, *new_plane_state;
>>>>>> -     struct drm_plane_state *primary_state, *overlay_state = NULL;
>>>>>> +     struct drm_plane_state *primary_state, *cursor_state, *overlay_state = NULL;
>>>>>>
>>>>>>       /* Check if primary plane is contained inside overlay */
>>>>>>       for_each_oldnew_plane_in_state_reverse(state, plane, old_plane_state, new_plane_state, i) {
>>>>>> @@ -10097,6 +10097,14 @@ static int validate_overlay(struct drm_atomic_state *state)
>>>>>>       if (!primary_state->crtc)
>>>>>>               return 0;
>>>>>>
>>>>>> +     /* check if cursor plane is enabled */
>>>>>> +     cursor_state = drm_atomic_get_plane_state(state, overlay_state->crtc->cursor);
>>>>>> +     if (IS_ERR(cursor_state))
>>>>>> +             return PTR_ERR(cursor_state);
>>>>>> +
>>>>>> +     if (drm_atomic_plane_disabling(plane->state, cursor_state))
>>>>>> +             return 0;
>>>>>> +
>>>>>
>>>>> I thought this breaks Chrome's compositor since it can't handle an atomic commit rejection
>>>>> based solely on whether a cursor is enabled or not.
>>> For context: To use overlays (the old/current async way), Chrome tests
>>> if an overlay strategy will work by doing an atomic commit with a TEST
>>> flag to check if the combination would work. If it works, it flags
>>> this planes configuration as valid. As it's valid, it performs an
>>> atomic page flip (which could also include the cursor).
>>> So to Harry's point, you would pass an atomic test but fail on an
>>> atomic page flip with the exact same configuration that's been flagged
>>> as valid. Failing a pageflip causes Chrome to crash (Reset the GPU
>>> process cause something went horribly wrong when it shouldn't).
>>
>> Hi Mark and Sean,
>>
>> I don't know if I fully comprehended the scenario which in my patch
>> might cause a ChromeOS crash, but this is what I understood:
>>
> 
> Chrome compositor only does an atomic test when the layout geometry
> changes (ie: plane is added/removed/resized/moved). This does not take
> into consideration the cursor. Once the atomic test has been validated
> for a given layout geometry (set of planes/fbs along with their sizes
> and locations), Chrome assumes this will continue to be valid.
> 
> So the situation I'm envisioning is if the cursor is hidden, an
> overlay-based strategy will pass in the kernel. If at any time the
> cursor becomes visible, the kernel will start failing commits which
> causes Chrome's GPU process to crash.
> 
> In general I'm uneasy with using the cursor in the atomic check since
> it feels like it could be racy independent of the issue above. I
> haven't dove into the helper code enough to prove it, just a
> spidey-sense.
> 

Isn't the cursor supposed to be just another plane? If so, shouldn't
adding/removing the cursor trigger an atomic test?

Is Chrome's compositor doing cursor update through legacy IOCTLs or
through the ATOMIC IOCTL?

Thanks,
Harry

> Sean
> 
>> There is a chance that we pass the atomic check
>> (DRM_MODE_ATOMIC_TEST_ONLY - TEST) but fails in the atomic page flip
>> because, after use TEST, the compositor might slightly change the commit
>> config by adding the cursor. The reason behind that came from the
>> assumption that adds the cursor in the atomic commit config after the
>> test is harmless. Is my understand correct? Please, correct me if I'm
>> wrong.
>>
>> If the above reasoning is correct, I think the compositor should not
>> assume anything extra from what it got from the atomic check.
>>
>> Best Regards,
>> Siqueira
>>
>>>>>
>>>>> Harry
>>>>>
>>>>>>       /* Perform the bounds check to ensure the overlay plane covers the primary */
>>>>>>       if (primary_state->crtc_x < overlay_state->crtc_x ||
>>>>>>           primary_state->crtc_y < overlay_state->crtc_y ||
>>>>>>
>>>>>
>>
>> --
>> Rodrigo Siqueira
>> https://siqueira.tech/>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
