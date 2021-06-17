Return-Path: <SRS0=/AY/=LL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_RED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10811C2B9F4
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 19:33:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3CB5610EA
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 19:33:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3CB5610EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E9A96E220;
	Thu, 17 Jun 2021 19:33:26 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 362A36E220
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Jun 2021 19:33:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZihaH4WQP7cKFiTfhjc70HTVzlrwHToU4KRTgYLKArhhZEmzAgjxE0NDChE3YNzB5rE1Nl2a8i+YddUdZVnMzHTyCwoCLDdAvPnhMpkT9FhcinfYM3Edi7r2FG4gFvy3VqWVoBheNjNJwxy82YrZNNf4eMxdGwWXhq30eJX480vX3tPEEegrU50ujy44K8m187TV4ukSP4CtJYhZMu48E0pg4E3J1cebpn/OGxlsd1BMCQNdMAdln7qnN6olJcjdCqtTxnK2c69KlBEpFHGg8RQpOqvWepyw1OSYfXXAYzW4vpWJF+sIenCM2rIVqYbDFy2X4zXJfPgNWxMJRfAbsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBHVwA0oZ+H4QLAUjsra64/8CVK6zEmVWTAUwF3pfAA=;
 b=Kh4DAXT17aqUDqQ4X7WsziFl9p7tAFh3m+rj7a5igxVo5i/FkHqJZptphxP8YKTGxAQeF06PxTUoK2FAh6dbNaly123Ofdevc2E2B9qQBx48lXWSStZzuqeUsDnxr4vLMwzbsXbj4a/RB1UP6nTIqX9PuWuyFxpbPg7ko0snuE0eq3Gmkjv6GawwhR7I4CuHGwaqJEKqiWjVlSqwqWBJW+17+gGiamvd0FUMqd412+nfSc17x3ViC799bVPsra2gUrv5P9Ow1mwEVgRGQwWS2V1UOsFhG/t6Ezlu1WH1E3rDrImZXUW4P8cTxiyk9Pqcbb0jWzZICz1eE/N31iwShg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBHVwA0oZ+H4QLAUjsra64/8CVK6zEmVWTAUwF3pfAA=;
 b=JvCBju/zroQFVGwoF+rFrRxvuZfHAJ8DRIm5PUX3Uups+MOz8mYVHkZUVoOUMWTtevoPUFcl11Eey0nmfrq9T465epLCdxfwABnB+F/rSmxW2xDpdJaISKreST2+PJxGdf5lhlP6x01CVscf5kvTxfENVplC+ahvIxQqcqA2dWI=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5396.namprd12.prod.outlook.com (2603:10b6:303:139::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 19:33:23 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::401d:c7a2:6495:650b]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::401d:c7a2:6495:650b%3]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 19:33:23 +0000
Subject: Re: [PATCH] Revert "drm/amd/display: Fix overlay validation by
 considering cursors"
To: Sean Paul <seanpaul@chromium.org>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
References: <20210616162130.1430187-1-Rodrigo.Siqueira@amd.com>
 <CAOw6vb+xwpVci60zp3QtALAqxBjZEUGx6V=5XvPpY-td2Lx97Q@mail.gmail.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <08a910d2-ba76-ca43-dec6-75291baa9498@amd.com>
Date: Thu, 17 Jun 2021 15:33:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <CAOw6vb+xwpVci60zp3QtALAqxBjZEUGx6V=5XvPpY-td2Lx97Q@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [198.200.67.154]
X-ClientProxiedBy: YQBPR01CA0125.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::25) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.50.3] (198.200.67.154) by
 YQBPR01CA0125.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:1::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.16 via Frontend Transport; Thu, 17 Jun 2021 19:33:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cfad633-0ef3-4b3e-8e9e-08d931c6c52a
X-MS-TrafficTypeDiagnostic: CO6PR12MB5396:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB53967288794053CCC973052C8C0E9@CO6PR12MB5396.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X0bp406epwtfMSapNNlvRmLfdoiu18CBugMcRA4y+33+Pefw4BzNFr01u1SaxmiOLPE1mhjSb/5hoGqWK6fmDc2QDIWee4ysm+bbPJKvazc88dfAUjknn5la8L+8ntkoIYgOTbzifuLNEYQqFO+lICIdx+7BGRX1dhik0XMevBfvUyxcdoNAAWWAVn4liPsuBLw6ZGs56lXd9dN4PJZc9yZlX/UhYEk1Gpv5Jd7x+QIcKs/805p1kDn1p0E7IaHwuJ/Y3mG15CEZTV73zWjLng74GF2ZnmJ2VyI9iT6m7PuvdbxLrBWJcMdk2Ffox9y8ihAn08MoAIYX2RF3pt6YjBFN3phQqJJ+hAzJIVlRjvE9xzT+kuNn/mGlddQCjhDOiQty9Myr0TTvsGfCostCJACu7096pOMBgAR9sNuJqz28iQFQprKRf8UTVNOvSo6eO1RI9s4OKpd0Y/L55FtHUE9sEYZcKEVLP6ma/5YwlPvHREfm8A1ltyoWTVsYTW3uQFsHlwHo86P6cQvQNmoen1dWxRm0ooy2ncsbpQIcBnE65YcQijTMrb+2LiOLXTaGb250TGbJQQAy5f4yzGKQ6YtSC8rT9PrLDGUomjMEynFLe6DyQihjDe4SIlC4r/M1vBLqi97xMctB35sH8MlCSNv4O9ZnRhCYNJEB8hIcKi6D88wKC+2sMHIlRjFOgeVIEaw4KgtytWYBOvAuuQpev1+NvsC9WFh+Glnp6qhse2M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(966005)(478600001)(6636002)(8936002)(83380400001)(86362001)(31696002)(26005)(36756003)(6666004)(66946007)(31686004)(316002)(66476007)(66556008)(2906002)(38100700002)(4326008)(186003)(16526019)(5660300002)(956004)(54906003)(8676002)(2616005)(44832011)(16576012)(6486002)(110136005)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDVWWW9MVE4veTF4TWFjQjdqc1ZTVnRyelhQVi9FUGFxK0NMcTJjUkdRbFh0?=
 =?utf-8?B?WHRMSkFMOWRMT0txVithSExlSFFNWlRWaDgyQXZlQ0lLbUNSN0FSYXhFZFhP?=
 =?utf-8?B?Q3cwUUZ0UWhJMmxNT1Z6VHpJV1pHWEZnM09pNktKVWgrNG5FOXlNZjg2NDBI?=
 =?utf-8?B?VmFOV3pQV1oxWUo4NVBWdWxlOWRyZ09IVTc4SWdXT0I2SnJ1YjBqUmsyQlg3?=
 =?utf-8?B?VC9ZZVVjRkdGeVdMUDE4bDNaMy9pNklvbzB0UzFSdmFFMFBXV0R3eSsxMVpk?=
 =?utf-8?B?dE0xZlZaOXJXWkM3V1M2aWNPL1J0RXZMcVJwTUJJa29kM3pXa1FNdjkxSnhu?=
 =?utf-8?B?WlBLNmFGR1lJYmJmb0FLMTFsbldoVzB6dTI2NDAwSCtMaGlhcStuN0xvLzAy?=
 =?utf-8?B?VmgvY0FYdG1OYUVaNUZaYjNiWFMwcmc2UFRVYkljb2FhRnBBbmt4Sk5hcFBH?=
 =?utf-8?B?Rk1BMitGTnA0S2lPZHYySGpjamVVMGJ0em44UWtBanFjWXhhcHNINWVqOThk?=
 =?utf-8?B?UlZ6YUw1eVJLZzZGZ1gvRm1hUXdEcE5rbnB2OXBacmVFNUhFd1FyUStqUHZ0?=
 =?utf-8?B?RHFmb2NFSHNmbWxJUFVjVldNSnJDWnBRVnQ3dkpEbTlzK3JmUFprOXVJUmtL?=
 =?utf-8?B?OTlYMlE1dmd0UEJueUpmQ3o1WlQvQjV0TWlhZnhBaVQ0NjJPUUNKM1YzR3Fn?=
 =?utf-8?B?c3FiTDZTVHNKeWhWdTNlMDBna0MzYWs2TzA2TUR0TlhGbE5GYkZiU3UxQlFT?=
 =?utf-8?B?ZzcyMG10UUVKQkhQd2Fvek1FUGEySWtXMVVJUkxXMkoveXBlN3d4NlJRVk9o?=
 =?utf-8?B?T3hKTmVVQVJDQjI0TU95RDRPQ1VUWCs2dlRtYlN6OS96TEJNLzY3M2MxMmdn?=
 =?utf-8?B?dTVwd3BVWmEra2JZNm9ua3pFSzlYazlXb0RBemdsYTJHWHptTWtZcWduMmZ6?=
 =?utf-8?B?TStjaUJoT0pleUhpM2pnWGJpZHNoWnlmUXlWQ25VOTdnRmNOaHVVU1djRkpE?=
 =?utf-8?B?SlVZMHV0OWFwQkk4RVYyckhmRHFtVTgrbXYrOHlpaHB5cmZZcUt3M0lmczRa?=
 =?utf-8?B?OVdnczdxRUNyWDdMekFGbWhCdWVEcXg2T2F4WG9ybEc4VVZxK2Q1bTNMdXJN?=
 =?utf-8?B?dkREcHY3Z0QvV2c3NG9mY3piRWZDN1M0dE1lR2RrZTFkL1pZQVZFME1nNDZE?=
 =?utf-8?B?T1NlWW5PUUZLTHRUOXlxN0xZVW5SU1Q0cVhYNDVBZmUzZUpuRUVVSHlxeU9l?=
 =?utf-8?B?SXMzK0QwcjI3RzFRM0JyRjM0YlJYUjN3b0hEeTExZjNMek1jdmw5b2tnL0pB?=
 =?utf-8?B?em85S2NaRjlVUFNuejVlRm9pV0xwZXJ0QTk1bWhlUlI0WEtJdStwWTVMcG43?=
 =?utf-8?B?bmtvNGJPd1VKUytEZ3BsVUhKa1pkVVdFQmFwSndrMjVwd3gvN2tDWkNOOXpX?=
 =?utf-8?B?NHRSUXY4ZHNJVUpOdi9kdGVISG5NOGQyRzFBeDA5WE5MY0JBeHdLNzY1Mng5?=
 =?utf-8?B?WE1QbXJ1RjI2ellQYkgzY05ETkJQWXFraFFWdGRuRHRTblNjbkpQUGNTWEVE?=
 =?utf-8?B?OUk4QU9NMHJ2aU8yWVlGTmhRNnE3KzE5bnZQUWUxNXROTGtQaUhVVnArSWlD?=
 =?utf-8?B?ME9xbjZrVExwMi80ejJ4NEtFMGVydVJ1RzlCL0RSdWRieTNyVi9EcWYrSXlB?=
 =?utf-8?B?MUllcWowMUJGMTFUaWo5Wk5PY1oxVnBJemxNcEgrVE1KTjNXWks1ckFPYlZn?=
 =?utf-8?Q?DdWx4K5k1UuTQm8AJEFCIv/Xf+eqj4XXjWdifEa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cfad633-0ef3-4b3e-8e9e-08d931c6c52a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 19:33:23.4147 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YAH7r+f7MixqGev98jqTWkLdp4JMJSE0EuD+3Ut9bdBAxXFlCgCU905QhXAoYMMFAdLaS8cK2UZd0sAlc6UfGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5396
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
Cc: Mark Yacoub <markyacoub@chromium.org>, Hersen Wu <hersenxs.wu@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-06-16 1:14 p.m., Sean Paul wrote:
> On Wed, Jun 16, 2021 at 12:21 PM Rodrigo Siqueira
> <Rodrigo.Siqueira@amd.com> wrote:
>>
>> This reverts commit 04cc17a951f73f9a9092ca572b063e6292aeb085.
>>
>> The patch that we are reverting here was originally applied because it
>> fixes multiple IGT issues and flickering in Android. However, after a
>> discussion with Sean Paul and Mark, it looks like that this patch might
>> cause problems on ChromeOS. For this reason, we decided to revert this
>> patch.
> 
> Thanks for sending this, Siqueira!
> 
> To be clear for those unfamiliar, the issue extends beyond ChromeOS
> (we're not just pushing our compositor problems on the rest of the
> community).
> 
> Relying on cursor enable/disable for atomic creates non-deterministic
> behavior which would be very hard for any compositor to reason out
> without knowing the hardware-specific limitations. The case I'm
> worried about is that the compositor has an overlay active without the
> cursor and at some point the compositor enables the cursor which will
> fail because of the overlay.
> 

Previous discussion highlighted that the cursor IOCTL should never
fail and that userspace generally is not well equipped to deal with
it if it does.

https://patchwork.freedesktop.org/patch/387230/
https://patchwork.freedesktop.org/patch/389084/

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> Reviewed-by: Sean Paul <seanpaul@chromium.org>
> 
>>
>> Cc: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
>> Cc: Harry Wentland <Harry.Wentland@amd.com>
>> Cc: Hersen Wu <hersenxs.wu@amd.com>
>> Cc: Sean Paul <seanpaul@chromium.org>
>> Cc: Mark Yacoub <markyacoub@chromium.org>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>> ---
>>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 ++----------
>>  1 file changed, 2 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 8358112b5822..3fd41e098c90 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -10200,8 +10200,8 @@ static int validate_overlay(struct drm_atomic_state *state)
>>  {
>>         int i;
>>         struct drm_plane *plane;
>> -       struct drm_plane_state *new_plane_state;
>> -       struct drm_plane_state *primary_state, *cursor_state, *overlay_state = NULL;
>> +       struct drm_plane_state *old_plane_state, *new_plane_state;
>> +       struct drm_plane_state *primary_state, *overlay_state = NULL;
>>
>>         /* Check if primary plane is contained inside overlay */
>>         for_each_new_plane_in_state_reverse(state, plane, new_plane_state, i) {
>> @@ -10231,14 +10231,6 @@ static int validate_overlay(struct drm_atomic_state *state)
>>         if (!primary_state->crtc)
>>                 return 0;
>>
>> -       /* check if cursor plane is enabled */
>> -       cursor_state = drm_atomic_get_plane_state(state, overlay_state->crtc->cursor);
>> -       if (IS_ERR(cursor_state))
>> -               return PTR_ERR(cursor_state);
>> -
>> -       if (drm_atomic_plane_disabling(plane->state, cursor_state))
>> -               return 0;
>> -
>>         /* Perform the bounds check to ensure the overlay plane covers the primary */
>>         if (primary_state->crtc_x < overlay_state->crtc_x ||
>>             primary_state->crtc_y < overlay_state->crtc_y ||
>> --
>> 2.25.1
>>

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
