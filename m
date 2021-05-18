Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16FFC433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 20:57:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97F526112F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 20:57:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97F526112F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 481E66ECA4;
	Tue, 18 May 2021 20:57:06 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81AEC6ECA4;
 Tue, 18 May 2021 20:57:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nmOOaVyStRjgsbWAEP4OLurfFfi1RqbXqSSTI+qarBCgfUl+Qoxq5xGc0wBtTLEbK4ZhUlIX2ItT1c+7GjNVFOZtUD5DQP/OGNmCyrElN7CMTMGL+YvCDR8CCk8wkwsdiW+Dgzme7W1kvWZo0GGmcRXsGamt7uAChPMaedozo0x6G7HelzizpmIPXcVldWZOcICcDZjsiRfFvFF/J8n+kD0hh/1Zfl+Qnqd5A1TnN8ZTWJCXfcBA6mD9etHBPONiveSHXc8dqkI+74lcAqQgKRQ9bO1KDJZt7c/DKpZiOOR+vil+fzxT2IMlaaV6OywlPpRy7qKXlcRI0R3X6rG2Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0YCUEf/hTVguz0P47XqN+jGJ1xn+YWNRwzKzpsFk4A=;
 b=MBDadl04QWACE+S2zufzolmFT1lpB1H+Rd8MZXuipZPrAjeS7HEvqdQUlELGAABm8rLzfeNYdFgzx5qpqoqxWPCRC6ZbOpbG5ygENDq30BoMUk7YXA24UPxaG5tGWgwUpHTNVI6saMOw3hzMxuu9n9aco/QuXmEoboYqBVE6TyWRElkN8iVA9qlU/8MlIQ6f+F+oZo5NJfVB/VaiBKfWc9EroG4O2vyHaKoGm2/1NvbcS5zW6A2x74mZGZWmUQ28VooSqzUb6E54JpwMwKeygqUuEXK+rNEg7CpwIcOh5aikHAozziQksr7tyl0uDcamomWRuuBgIHh+INlHa6XeBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0YCUEf/hTVguz0P47XqN+jGJ1xn+YWNRwzKzpsFk4A=;
 b=VfR8z/stRlF1r+MzFFlakrTEDPiw3tP6dKq4QhddAHqObfgWrd5XcDUOxvwkosLY084daXgg7y3XbwfPbH6BoOJiLFF7ieSsY6r4NBuTlsb5AdQFYbctfxQH5ES53cn1zileBFNGRCqASBYpto5oRBRIjpyYNaQJ9WHgXnG2gzs=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4447.namprd12.prod.outlook.com (2603:10b6:806:9b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Tue, 18 May
 2021 20:57:00 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c%7]) with mapi id 15.20.4129.031; Tue, 18 May 2021
 20:56:59 +0000
Subject: Re: [PATCH v7 13/16] drm/scheduler: Fix hang when sched_entity
 released
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-pci@vger.kernel.org, ckoenig.leichtzumerken@gmail.com,
 daniel.vetter@ffwll.ch, Harry.Wentland@amd.com
References: <20210512142648.666476-1-andrey.grodzovsky@amd.com>
 <20210512142648.666476-14-andrey.grodzovsky@amd.com>
 <9e1270bf-ab62-5d76-b1de-e6cd49dc4841@amd.com>
 <f0c5dea7-af35-9ea5-028e-6286e57a469a@amd.com>
 <34d4e4a8-c577-dfe6-3190-28a5c63a2d23@amd.com>
 <da1f9706-d918-cff8-2807-25da0c01fcde@amd.com>
 <8228ea6b-4faf-bb7e-aaf4-8949932e869a@amd.com>
 <ec157a35-85fb-11e5-226a-c25d699102c6@amd.com>
 <53f281cc-e4c0-ea5d-9415-4413c85a6a16@amd.com>
 <0b49fc7b-ca0b-58c4-3f76-c4a5fab97bdc@amd.com>
 <31febf08-e9c9-77fa-932d-a50505866ec4@amd.com>
 <cd6bbe33-cbc5-43cb-80f7-1cb82a81e65d@amd.com>
Message-ID: <df863907-f731-19a6-f5f3-29fa5d9bd084@amd.com>
Date: Tue, 18 May 2021 16:56:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <cd6bbe33-cbc5-43cb-80f7-1cb82a81e65d@amd.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:1069:60ba:d67c:3ab3]
X-ClientProxiedBy: YT1PR01CA0107.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::16) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:1069:60ba:d67c:3ab3]
 (2607:fea8:3edf:49b0:1069:60ba:d67c:3ab3) by
 YT1PR01CA0107.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Tue, 18 May 2021 20:56:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b513b5e5-51e7-48e3-4970-08d91a3f7a90
X-MS-TrafficTypeDiagnostic: SA0PR12MB4447:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4447F1733F7C4960158E576EEA2C9@SA0PR12MB4447.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CkFFBG5X54l/S8iCa1s1JfAgynJXaljN2RxJMhAbKyLM/mZyE2BoRLq89nKe9GwSG1UVVypycu4wWw/a7ton89IKl/xO+mqsKqQu/ud6FyjOrotmzx4Dd2zCuR5FDgqiHDReyJGfGT1kGuORlnIP7MMYzmIjyYkqNn9LF4axjDl4JejcHpM469Y0QqjB1bifRobhfHy/m/ElbAURgdw3uR3EJvpp53gK7UsOy4NWp7ugnVs2CxvUzttXsj2964rrWMQWODEPR6Cx9PWQat/u1bB28ONWaO3KrxCtujp4gWNQMO5L05Dxoq98snM598bM5EV8QBC+HPTxhMZPtOmrIz+uxy7/DCaZ0d5bhS1ycfr/yGg/y+dbQc4ROjQPa4uYow2xVCHEVUPApOrdqeExKPNdGqnfSexEKYPNmNkicYPNxNOXIDYPPeu9SUJMAL3syJmpqBEZJRwix0JASy4L3AAp9f4z6n2Ct3y5dsoB9ZY/9DQ2C3/rKyCH8euUopDdD9Uoqj4swxY1ri7vIa3EbqGfuhJuMnMGx9uA01KZULNMY8U+mvxREPExD0kbAgTwko/ugQOA/aVID3WMYhr3W1EFVkj75H2qIBqkjG/0KMfpg438Uq5Mle+PZLaDvOiV1pY/7nm1nzMP91QvNX2z/njO5kERbnyK3xeAVQ/5QF6/db8KhLben85apmZk88ps
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(66556008)(66476007)(4326008)(31686004)(83380400001)(44832011)(30864003)(52116002)(38100700002)(66574015)(6486002)(5660300002)(53546011)(8936002)(86362001)(316002)(2616005)(2906002)(186003)(8676002)(16526019)(66946007)(6636002)(478600001)(31696002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?S0Z0MHRuVk04UzUycUFKcEhXM04wby9tYUhKRzJWSXFSckVyVjI3ZGREamtz?=
 =?utf-8?B?SkFpWWJLeGZDNXR4M0tScXNTYjd4aXVqanFVWUd5MDZ4bmNnN3FqS0JZcFVM?=
 =?utf-8?B?Y3lTUHBaMkZMdklPQmJTNm1lQkNvTVljZ3kzckw4alUrYjBCbmVMZXcyUFVS?=
 =?utf-8?B?aEhseUR5WGk3NTYza1Vsei96SWRxQURwTWQzSTR3c1F1eWZjbldXUlhUZENo?=
 =?utf-8?B?Y0hvNFNKSzhrQzdVR1NOREh4K0gvd1l4NnpobG5ueTltaUM1YkRmVVF4YVh6?=
 =?utf-8?B?S0wxMGxYZDlUSXVwOWFhV1FOZnJlbENRUmROa1BFM05vcmFwMnAwWmx5UFk2?=
 =?utf-8?B?d0dOMUlyWUx0SnNudERUVlRybkZQKzBrVzB4TEtFOWFHVmFOZzJYRGltUHQ1?=
 =?utf-8?B?TnRRWmNra1NCWlJOaEZTTnFDT0V2cW1BMmRwWFEzd2cvYktzdkxEZmJ6NnVz?=
 =?utf-8?B?NCtoMWRITW1vSjVGREd5dUJVcWZBK3lib2FhUDliSHM0UmFVNU1QYW5uOEp2?=
 =?utf-8?B?L1NIb211dEx5eENVcnU0cmo1UVE1VTQ5UHBVNzVNelFKZkdBL2xvcnVyaUx2?=
 =?utf-8?B?L0thU2VoQWdvSG9DcEx6UzE5dGxUWFJSYkVOS2psSmdCVktPRzlTZFZXNEJi?=
 =?utf-8?B?bjRmTG85cTZvejFHTGRyMHl4VjZrdE1WKyt3dnZSVXBSalVuV2liTmNETnhY?=
 =?utf-8?B?Z3lXK2NPckF5d294RDVKb1BnbXlJeVdJdlI1UlExcnZwQWo4c1k3dS96YzEr?=
 =?utf-8?B?bHhzeGw5bXRGM3BsbFNITEhKdnBjb0VJcTZkZFUwYnQzbTF2OWQreE15SDJT?=
 =?utf-8?B?WENsOXBEWHhFeWt0NDYwUEI4NlFDL1dmZ3JNc0RNOXpJM3gveFUvTHpZMkM0?=
 =?utf-8?B?SDFoRGY5T2gzWkJDNk1JZHVqUHV6MFZLaUNITnM5RHk1dG5jdDd5K1EvTEhl?=
 =?utf-8?B?aEkwdUxkVGVlREsxVGw3RWdQczBCSzFGTUNXZE5EcFEwa2VnQWttN2UySEFB?=
 =?utf-8?B?OTk1R2VUa0I5RHQzdXpVdUZrNjVIRUh3VGpzeXlKVXlOR3NDRkFEK1VnWjM0?=
 =?utf-8?B?Y25iL3Qxc3ZvZWpWa0oxSzB0Mkx0WG1KNkErQzZrUU1BMjRLOGNQSjhKZGd3?=
 =?utf-8?B?bkJlRUVma1Z2N1BReGZIdXAyenJ0ekpRcmtHV0t6dXg4UzhLSFNETDZBNFBW?=
 =?utf-8?B?bGsyT1BNUHEwRXFPeWx0YXNXa0oyWkFXYm5WZ0xteVp3bHpaYWgvdWJKSkN6?=
 =?utf-8?B?RTdscFc3RTd1Z0tWcEthV3FRb3orSFcwdFBPcU9BQmVXUEU5VUx4bTZrdzh6?=
 =?utf-8?B?TS84YkZlUmZ5RXNlSTBoNFBLOGtpUVN4UkFENGp0Yks4NTBsUHlucjR6eGNt?=
 =?utf-8?B?M0ZZdDlUQWNrTnJrZW5WeEZNYU1JeGZRUHlsSmtZQ3dZT3g5SU4yUXMrTkdS?=
 =?utf-8?B?RDNTRkpKSXQvckUwV2JFWWpXaU9icW1Bci8renVJaHFnM1lRZmFmaC9pSTBF?=
 =?utf-8?B?Y0FRZmhiVkNPRFdxSlhsbnFvVlk0Z0pCSHUxN2puL3VvTlZpNkwyR0NFVTQw?=
 =?utf-8?B?dGpuZHFKTU5oT2twUjFtV3ZpaFJ1RkIxUGdoSzBPVDZ3RnZEd3ZRaGViNUVn?=
 =?utf-8?B?aFQveS9ucUJ5bFRETkZjWEJpWUdMcEw5ZWx1YmhteFRJaFQ2UVJMb2pZb09P?=
 =?utf-8?B?eUQ2c2RnNmd1RjVNaXpKUXNzTThhdkEwOExlalgwRDZROU9jQndVV1ZjRXhr?=
 =?utf-8?B?dW1CM24wTFIvbStVNWpkN3EwRU9jbEY5UjNWVkpoZ2hockZHTjhCdGZtRHp0?=
 =?utf-8?B?bG9oNURMRkVyMDkxQkQvcVRMUXdSY1E0QzIrV2RvY2VEREh5Q0kwSERpamRQ?=
 =?utf-8?Q?is0pYU+YggZ36?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b513b5e5-51e7-48e3-4970-08d91a3f7a90
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 20:56:59.7050 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B6tz2HWXj5K+0ty65EKM1/wrAOXjwmMuoISD3FUqlV1Yy7t+6bXIqET70mNIG/5sh02lw5uo0y1/4FhUr9HVBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4447
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
Cc: Alexander.Deucher@amd.com, gregkh@linuxfoundation.org,
 Felix.Kuehling@amd.com, helgaas@kernel.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpPbiAyMDIxLTA1LTE4IDI6NDggcC5tLiwgQW5kcmV5IEdyb2R6b3Zza3kgd3JvdGU6Cj4gCj4g
Cj4gT24gMjAyMS0wNS0xOCAyOjEzIHAubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+Cj4+
IEFtIDE4LjA1LjIxIHVtIDIwOjA5IHNjaHJpZWIgQW5kcmV5IEdyb2R6b3Zza3k6Cj4+PiBPbiAy
MDIxLTA1LTE4IDI6MDIgcC5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+PiBBbSAxOC4w
NS4yMSB1bSAxOTo0MyBzY2hyaWViIEFuZHJleSBHcm9kem92c2t5Ogo+Pj4+PiBPbiAyMDIxLTA1
LTE4IDEyOjMzIHAubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+Pj4+PiBBbSAxOC4wNS4y
MSB1bSAxODoxNyBzY2hyaWViIEFuZHJleSBHcm9kem92c2t5Ogo+Pj4+Pj4+Cj4+Pj4+Pj4KPj4+
Pj4+PiBPbiAyMDIxLTA1LTE4IDExOjE1IGEubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+
Pj4+Pj4+IEFtIDE4LjA1LjIxIHVtIDE3OjAzIHNjaHJpZWIgQW5kcmV5IEdyb2R6b3Zza3k6Cj4+
Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gT24gMjAyMS0wNS0xOCAxMDowNyBhLm0uLCBDaHJpc3RpYW4gS8O2
bmlnIHdyb3RlOgo+Pj4+Pj4+Pj4+IEluIGEgc2VwYXJhdGUgZGlzY3Vzc2lvbiB3aXRoIERhbmll
bCB3ZSBvbmNlIG1vcmUgaXRlcmF0ZWQgCj4+Pj4+Pj4+Pj4gb3ZlciB0aGUgZG1hX3Jlc3YgcmVx
dWlyZW1lbnRzIGFuZCBJIGNhbWUgdG8gdGhlIGNvbmNsdXNpb24gCj4+Pj4+Pj4+Pj4gdGhhdCB0
aGlzIGFwcHJvYWNoIGhlcmUgd29uJ3Qgd29yayByZWxpYWJsZS4KPj4+Pj4+Pj4+Pgo+Pj4+Pj4+
Pj4+IFRoZSBwcm9ibGVtIGlzIGFzIGZvbGxvd2luZzoKPj4+Pj4+Pj4+PiAxLiBkZXZpY2UgQSBz
Y2hlZHVsZXMgc29tZSByZW5kZXJpbmcgd2l0aCBpbnRvIGEgYnVmZmVyIGFuZCAKPj4+Pj4+Pj4+
PiBleHBvcnRzIGl0IGFzIERNQS1idWYuCj4+Pj4+Pj4+Pj4gMi4gZGV2aWNlIEIgaW1wb3J0cyB0
aGUgRE1BLWJ1ZiBhbmQgd2FudHMgdG8gY29uc3VtZSB0aGUgCj4+Pj4+Pj4+Pj4gcmVuZGVyaW5n
LCBmb3IgdGhlIHRoZSBmZW5jZSBvZiBkZXZpY2UgQSBpcyByZXBsYWNlZCB3aXRoIGEgCj4+Pj4+
Pj4+Pj4gbmV3IG9wZXJhdGlvbi4KPj4+Pj4+Pj4+PiAzLiBkZXZpY2UgQiBpcyBob3QgcGx1Z2dl
ZCBhbmQgdGhlIG5ldyBvcGVyYXRpb24gCj4+Pj4+Pj4+Pj4gY2FuY2VsZWQvbmV3ZXIgc2NoZWR1
bGVkLgo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4gVGhlIHByb2JsZW0gaXMgbm93IHRoYXQgd2UgY2Fu
J3QgZG8gdGhpcyBzaW5jZSB0aGUgb3BlcmF0aW9uIAo+Pj4+Pj4+Pj4+IG9mIGRldmljZSBBIGlz
IHN0aWxsIHJ1bm5pbmcgYW5kIGJ5IHNpZ25hbGluZyBvdXIgZmVuY2VzIHdlIAo+Pj4+Pj4+Pj4+
IHJ1biBpbnRvIHRoZSBwcm9ibGVtIG9mIHBvdGVudGlhbCBtZW1vcnkgY29ycnVwdGlvbi4KPj4+
Pj4+Pgo+Pj4+Pj4+IEJ5IHNpZ25hbGluZyBzX2ZlbmNlLT5maW5pc2hlZCBvZiB0aGUgY2FuY2Vs
ZWQgb3BlcmF0aW9uIGZyb20gdGhlCj4+Pj4+Pj4gcmVtb3ZlZCBkZXZpY2UgQiB3ZSBpbiBmYWN0
IGNhdXNlIG1lbW9yeSBjb3JydXB0aW9uIGZvciB0aGUgCj4+Pj4+Pj4gdW5jb21wbGV0ZWQKPj4+
Pj4+PiBqb2Igc3RpbGwgcnVubmluZyBvbiBkZXZpY2UgQSA/IEJlY2F1c2UgdGhlcmUgaXMgc29t
ZW9uZSB3YWl0aW5nIHRvCj4+Pj4+Pj4gcmVhZCB3cml0ZSBmcm9tIHRoZSBpbXBvcnRlZCBidWZm
ZXIgb24gZGV2aWNlIEIgYW5kIGhlIG9ubHkgd2FpdHMgCj4+Pj4+Pj4gZm9yCj4+Pj4+Pj4gdGhl
IHNfZmVuY2UtPmZpbmlzaGVkIG9mIGRldmljZSBCIHdlIHNpZ25hbGVkCj4+Pj4+Pj4gaW4gZHJt
X3NjaGVkX2VudGl0eV9raWxsX2pvYnMgPwo+Pj4+Pj4KPj4+Pj4+IEV4YWN0bHkgdGhhdCwgeWVz
Lgo+Pj4+Pj4KPj4+Pj4+IEluIG90aGVyIHdvcmRzIHdoZW4geW91IGhhdmUgYSBkZXBlbmRlbmN5
IGNoYWluIGxpa2UgQS0+Qi0+QyB0aGVuIAo+Pj4+Pj4gbWVtb3J5IG1hbmFnZW1lbnQgb25seSB3
YWl0cyBmb3IgQyBiZWZvcmUgZnJlZWluZyB1cCB0aGUgbWVtb3J5IAo+Pj4+Pj4gZm9yIGV4YW1w
bGUuCj4+Pj4+Pgo+Pj4+Pj4gV2hlbiBDIG5vdyBzaWduYWxlZCBiZWNhdXNlIHRoZSBkZXZpY2Ug
aXMgaG90LXBsdWdnZWQgYmVmb3JlIEEgb3IgCj4+Pj4+PiBCIGFyZSBmaW5pc2hlZCB0aGV5IGFy
ZSBlc3NlbnRpYWxseSBhY2Nlc3NpbmcgZnJlZWQgdXAgbWVtb3J5Lgo+Pj4+Pgo+Pj4+PiBCdXQg
ZGlkbid0IEMgaW1wb3J0ZWQgdGhlIEJPIGZvcm0gQiBvciBBIGluIHRoaXMgY2FzZSA/IFdoeSB3
b3VsZCAKPj4+Pj4gaGUgYmUKPj4+Pj4gdGhlIG9uZSByZWxlYXNpbmcgdGhhdCBtZW1vcnkgPyBI
ZSB3b3VsZCBiZSBqdXN0IGRyb3BwaW5nIGhpcyAKPj4+Pj4gcmVmZXJlbmNlCj4+Pj4+IHRvIHRo
ZSBCTywgbm8gPwo+Pj4+Cj4+Pj4gV2VsbCBmcmVlaW5nIHRoZSBtZW1vcnkgd2FzIGp1c3QgYW4g
ZXhhbXBsZS4gVGhlIEJPIGNvdWxkIGFsc28gbW92ZSAKPj4+PiBiYWNrIHRvIFZSQU0gYmVjYXVz
ZSBvZiB0aGUgZHJvcHBlZCByZWZlcmVuY2UuCj4+Pj4KPj4+Pj4gQWxzbyBpbiB0aGUgZ2VuZXJh
bCBjYXNlLAo+Pj4+PiBkcm1fc2NoZWRfZW50aXR5X2ZpbmktPmRybV9zY2hlZF9lbnRpdHlfa2ls
bF9qb2JzIHdoaWNoIGlzCj4+Pj4+IHRoZSBvbmUgd2hvIHNpZ25hbHMgdGhlICdDJyBmZW5jZSB3
aXRoIGVycm9yIGNvZGUgYXJlIGFzIGZhcgo+Pj4+PiBhcyBJIGxvb2tlZCBjYWxsZWQgZnJvbSB3
aGVuIHRoZSB1c2VyIG9mIHRoYXQgQk8gaXMgc3RvcHBpbmcKPj4+Pj4gdGhlIHVzYWdlIGFueXdh
eSAoZS5nLiBkcm1fZHJpdmVyLnBvc3RjbG9zZSBjYWxsYmFjayBmb3Igd2hlbiB1c2UKPj4+Pj4g
cHJvY2VzcyBjbG9zZXMgaGlzIGRldmljZSBmaWxlKSB3aG8gd291bGQgdGhlbiBhY2Nlc3MgYW5k
IGNvcnJ1cHQKPj4+Pj4gdGhlIGV4cG9ydGVkIG1lbW9yeSBvbiBkZXZpY2UgQSB3aGVyZSB0aGUg
am9iIGhhc24ndCBjb21wbGV0ZWQgeWV0ID8KPj4+Pgo+Pj4+IEtleSBwb2ludCBpcyB0aGF0IG1l
bW9yeSBtYW5hZ2VtZW50IG9ubHkgd2FpdHMgZm9yIHRoZSBsYXN0IGFkZGVkIAo+Pj4+IGZlbmNl
LCB0aGF0IGlzIHRoZSBkZXNpZ24gb2YgdGhlIGRtYV9yZXN2IG9iamVjdC4gSG93IHRoYXQgaGFw
cGVucyAKPj4+PiBpcyBpcnJlbGV2YW50Lgo+Pj4+Cj4+Pj4gQmVjYXVzZSBvZiB0aGlzIHdlIGF0
IGxlYXN0IG5lZWQgdG8gd2FpdCBmb3IgYWxsIGRlcGVuZGVuY2llcyBvZiB0aGUgCj4+Pj4gam9i
IGJlZm9yZSBzaWduYWxpbmcgdGhlIGZlbmNlLCBldmVuIGlmIHdlIGNhbmNlbCB0aGUgam9iIGZv
ciBzb21lIAo+Pj4+IHJlYXNvbi4KPj4+Pgo+Pj4+IENocmlzdGlhbi4KPj4+Cj4+PiBXb3VsZCB0
aGlzIGJlIHRoZSByaWdodCB3YXkgdG8gZG8gaXQgPwo+Pgo+PiBZZXMsIGl0IGlzIGF0IGxlYXN0
IGEgc3RhcnQuIFF1ZXN0aW9uIGlzIGlmIHdlIGNhbiB3YWl0IGJsb2NraW5nIGhlcmUgCj4+IG9y
IG5vdC4KPj4KPj4gV2UgaW5zdGFsbCBhIGNhbGxiYWNrIGEgYml0IGxvd2VyIHRvIGF2b2lkIGJs
b2NraW5nLCBzbyBJJ20gcHJldHR5IAo+PiBzdXJlIHRoYXQgd29uJ3Qgd29yayBhcyBleHBlY3Rl
ZC4KPj4KPj4gQ2hyaXN0aWFuLgo+IAo+IEkgY2FuJ3Qgc2VlIHdoeSB0aGlzIHdvdWxkIGNyZWF0
ZSBwcm9ibGVtcywgYXMgbG9uZyBhcyB0aGUgZGVwZW5kZW5jaWVzCj4gY29tcGxldGUgb3IgZm9y
Y2UgY29tcGV0ZWQgaWYgdGhleSBhcmUgZnJvbSBzYW1lIGRldmljZSAoZXh0cmFjdGVkKSBidXQK
PiBvbiBhIGRpZmZlcmVudCByaW5nIHRoZW4gbG9va3MgdG8gbWUgaXQgc2hvdWxkIHdvcmsuIEkg
d2lsbCBnaXZlIGl0Cj4gYSB0cnkuCj4gCj4gQW5kcmV5CgpXZWxsLCBpIGdhdmUgaXQgYSB0cnkg
d2l0aCBteSB1c3VhbCB0ZXN0cyBsaWtlIElHVCBob3QgdW5wbHVnIHdoaWxlCnJhcGlkIGNvbW1h
bmQgc3VibWlzc2lvbnMgYW5kIHVucGx1ZyB0aGUgY2FyZCB3aGlsZSBnbHhnZWFycyBydW5zCndp
dGggRFJJX1BSSU1FPTEgYW5kIGhhdmVuJ3Qgc2VlbiBpc3N1ZXMuCgpBbmRyZXkKCj4gCj4+Cj4+
Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfZW50aXR5
LmMgCj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfZW50aXR5LmMKPj4+IGlu
ZGV4IDJlOTNlODgxYjY1Zi4uMTBmNzg0ODc0YjYzIDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYwo+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYwo+Pj4gQEAgLTIyMywxMCArMjIzLDE0IEBAIHN0YXRp
YyB2b2lkIGRybV9zY2hlZF9lbnRpdHlfa2lsbF9qb2JzKHN0cnVjdCAKPj4+IGRybV9zY2hlZF9l
bnRpdHkgKmVudGl0eSkKPj4+IMKgewo+Pj4gwqDCoMKgwqDCoMKgwqAgc3RydWN0IGRybV9zY2hl
ZF9qb2IgKmpvYjsKPj4+IMKgwqDCoMKgwqDCoMKgIGludCByOwo+Pj4gK8KgwqDCoMKgwqDCoCBz
dHJ1Y3QgZG1hX2ZlbmNlICpmOwo+Pj4KPj4+IMKgwqDCoMKgwqDCoMKgIHdoaWxlICgoam9iID0g
Cj4+PiB0b19kcm1fc2NoZWRfam9iKHNwc2NfcXVldWVfcG9wKCZlbnRpdHktPmpvYl9xdWV1ZSkp
KSkgewo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBkcm1fc2NoZWRf
ZmVuY2UgKnNfZmVuY2UgPSBqb2ItPnNfZmVuY2U7Cj4+Pgo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgd2hpbGUgKGYgPSBzY2hlZC0+b3BzLT5kZXBlbmRlbmN5KHNjaGVkX2pvYiwg
ZW50aXR5KSkKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBkbWFfZmVuY2Vfd2FpdChmKTsKPj4+ICsKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBkcm1fc2NoZWRfZmVuY2Vfc2NoZWR1bGVkKHNfZmVuY2UpOwo+Pj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGRtYV9mZW5jZV9zZXRfZXJyb3IoJnNfZmVuY2UtPmZpbmlzaGVk
LCAtRVNSQ0gpOwo+Pj4KPj4+IEFuZHJleQo+Pj4KPj4+Cj4+Pgo+Pj4+Cj4+Pj4+Cj4+Pj4+IEFu
ZHJleQo+Pj4+Pgo+Pj4+Pj4KPj4+Pj4+IENocmlzdGlhbi4KPj4+Pj4+Cj4+Pj4+Pj4KPj4+Pj4+
PiBBbmRyZXkKPj4+Pj4+Pgo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiBJIGFtIG5vdCBz
dXJlIHRoaXMgcHJvYmxlbSB5b3UgZGVzY3JpYmUgYWJvdmUgaXMgcmVsYXRlZCB0byAKPj4+Pj4+
Pj4+IHRoaXMgcGF0Y2guCj4+Pj4+Pj4+Cj4+Pj4+Pj4+IFdlbGwgaXQgaXMga2luZCBvZiByZWxh
dGVkLgo+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gSGVyZSB3ZSBwdXJlbHkgZXhwYW5kIHRoZSBjcml0ZXJp
YSBmb3Igd2hlbiBzY2hlZF9lbnRpdHkgaXMKPj4+Pj4+Pj4+IGNvbnNpZGVyZWQgaWRsZSBpbiBv
cmRlciB0byBwcmV2ZW50IGEgaGFuZyBvbiBkZXZpY2UgcmVtb3ZlLgo+Pj4+Pj4+Pgo+Pj4+Pj4+
PiBBbmQgZXhhY3RseSB0aGF0IGlzIHByb2JsZW1hdGljLiBTZWUgdGhlIGpvYnMgb24gdGhlIGVu
dGl0eSBuZWVkIAo+Pj4+Pj4+PiB0byBjbGVhbmx5IHdhaXQgZm9yIHRoZWlyIGRlcGVuZGVuY2ll
cyBiZWZvcmUgdGhleSBjYW4gYmUgCj4+Pj4+Pj4+IGNvbXBsZXRlZC4KPj4+Pj4+Pj4KPj4+Pj4+
Pj4gZHJtX3NjaGVkX2VudGl0eV9raWxsX2pvYnMoKSBpcyBhbHNvIG5vdCBoYW5kbGluZyB0aGF0
IGNvcnJlY3RseSAKPj4+Pj4+Pj4gYXQgdGhlIG1vbWVudCwgd2Ugb25seSB3YWl0IGZvciB0aGUg
bGFzdCBzY2hlZHVsZWQgZmVuY2UgYnV0IG5vdCAKPj4+Pj4+Pj4gZm9yIHRoZSBkZXBlbmRlbmNp
ZXMgb2YgdGhlIGpvYi4KPj4+Pj4+Pj4KPj4+Pj4+Pj4+IFdlcmUgeW91IGFkZHJlc3NpbmcgdGhl
IHBhdGNoIGZyb20geWVzdGVyZGF5IGluIHdoaWNoIHlvdSAKPj4+Pj4+Pj4+IGNvbW1lbnRlZAo+
Pj4+Pj4+Pj4gdGhhdCB5b3UgZm91bmQgYSBwcm9ibGVtIHdpdGggaG93IHdlIGZpbmlzaCBmZW5j
ZXMgPyBJdCB3YXMKPj4+Pj4+Pj4+ICdbUEFUQ0ggdjcgMTIvMTZdIGRybS9hbWRncHU6IEZpeCBo
YW5nIG9uIGRldmljZSByZW1vdmFsLicKPj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiBBbHNvLCBpbiB0aGUg
cGF0Y2ggc2VyaWVzIGFzIGl0IGlzIG5vdyB3ZSBvbmx5IHNpZ25hbCBIVyBmZW5jZXMgCj4+Pj4+
Pj4+PiBmb3IgdGhlCj4+Pj4+Pj4+PiBleHRyYWN0ZWQgZGV2aWNlIEIsIHdlIGFyZSBub3QgdG91
Y2hpbmcgYW55IG90aGVyIGZlbmNlcy4gSW4gCj4+Pj4+Pj4+PiBmYWN0IGFzIHlvdQo+Pj4+Pj4+
Pj4gbWF5IHJlbWVtYmVyLCBJIGRyb3BwZWQgYWxsIG5ldyBsb2dpYyB0byBmb3JjaW5nIGZlbmNl
IAo+Pj4+Pj4+Pj4gY29tcGxldGlvbiBpbgo+Pj4+Pj4+Pj4gdGhpcyBwYXRjaCBzZXJpZXMgYW5k
IG9ubHkgY2FsbCAKPj4+Pj4+Pj4+IGFtZGdwdV9mZW5jZV9kcml2ZXJfZm9yY2VfY29tcGxldGlv
bgo+Pj4+Pj4+Pj4gZm9yIHRoZSBIVyBmZW5jZXMgb2YgdGhlIGV4dHJhY3RlZCBkZXZpY2UgYXMg
aXQncyBkb25lIHRvZGF5IAo+Pj4+Pj4+Pj4gYW55d2F5Lgo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBTaWdu
YWxpbmcgaGFyZHdhcmUgZmVuY2VzIGlzIHVucHJvYmxlbWF0aWMgc2luY2UgdGhleSBhcmUgCj4+
Pj4+Pj4+IGVtaXR0ZWQgd2hlbiB0aGUgc29mdHdhcmUgc2NoZWR1bGluZyBpcyBhbHJlYWR5IGNv
bXBsZXRlZC4KPj4+Pj4+Pj4KPj4+Pj4+Pj4gQ2hyaXN0aWFuLgo+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4K
Pj4+Pj4+Pj4+IEFuZHJleQo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+IE5vdCBzdXJl
IGhvdyB0byBoYW5kbGUgdGhhdCBjYXNlLiBPbmUgcG9zc2liaWxpdHkgd291bGQgYmUgdG8gCj4+
Pj4+Pj4+Pj4gd2FpdCBmb3IgYWxsIGRlcGVuZGVuY2llcyBvZiB1bnNjaGVkdWxlZCBqb2JzIGJl
Zm9yZSBzaWduYWxpbmcgCj4+Pj4+Pj4+Pj4gdGhlaXIgZmVuY2VzIGFzIGNhbmNlbGVkLgo+Pj4+
Pj4+Pj4+Cj4+Pj4+Pj4+Pj4gQ2hyaXN0aWFuLgo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4gQW0gMTIu
MDUuMjEgdW0gMTY6MjYgc2NocmllYiBBbmRyZXkgR3JvZHpvdnNreToKPj4+Pj4+Pj4+Pj4gUHJv
YmxlbTogSWYgc2NoZWR1bGVyIGlzIGFscmVhZHkgc3RvcHBlZCBieSB0aGUgdGltZSAKPj4+Pj4+
Pj4+Pj4gc2NoZWRfZW50aXR5Cj4+Pj4+Pj4+Pj4+IGlzIHJlbGVhc2VkIGFuZCBlbnRpdHkncyBq
b2JfcXVldWUgbm90IGVtcHR5IEkgZW5jb3VudHJlZAo+Pj4+Pj4+Pj4+PiBhIGhhbmcgaW4gZHJt
X3NjaGVkX2VudGl0eV9mbHVzaC4gVGhpcyBpcyBiZWNhdXNlIAo+Pj4+Pj4+Pj4+PiBkcm1fc2No
ZWRfZW50aXR5X2lzX2lkbGUKPj4+Pj4+Pj4+Pj4gbmV2ZXIgYmVjb21lcyBmYWxzZS4KPj4+Pj4+
Pj4+Pj4KPj4+Pj4+Pj4+Pj4gRml4OiBJbiBkcm1fc2NoZWRfZmluaSBkZXRhY2ggYWxsIHNjaGVk
X2VudGl0aWVzIGZyb20gdGhlCj4+Pj4+Pj4+Pj4+IHNjaGVkdWxlcidzIHJ1biBxdWV1ZXMuIFRo
aXMgd2lsbCBzYXRpc2Z5IAo+Pj4+Pj4+Pj4+PiBkcm1fc2NoZWRfZW50aXR5X2lzX2lkbGUuCj4+
Pj4+Pj4+Pj4+IEFsc28gd2FrZXVwIGFsbCB0aG9zZSBwcm9jZXNzZXMgc3R1Y2sgaW4gc2NoZWRf
ZW50aXR5IGZsdXNoaW5nCj4+Pj4+Pj4+Pj4+IGFzIHRoZSBzY2hlZHVsZXIgbWFpbiB0aHJlYWQg
d2hpY2ggd2FrZXMgdGhlbSB1cCBpcyBzdG9wcGVkIAo+Pj4+Pj4+Pj4+PiBieSBub3cuCj4+Pj4+
Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+IHYyOgo+Pj4+Pj4+Pj4+PiBSZXZlcnNlIG9yZGVyIG9mIGRybV9z
Y2hlZF9ycV9yZW1vdmVfZW50aXR5IGFuZCBtYXJraW5nCj4+Pj4+Pj4+Pj4+IHNfZW50aXR5IGFz
IHN0b3BwZWQgdG8gcHJldmVudCByZWluc2VyaW9uIGJhY2sgdG8gcnEgZHVlCj4+Pj4+Pj4+Pj4+
IHRvIHJhY2UuCj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+IHYzOgo+Pj4+Pj4+Pj4+PiBEcm9wIGRy
bV9zY2hlZF9ycV9yZW1vdmVfZW50aXR5LCBvbmx5IG1vZGlmeSBlbnRpdHktPnN0b3BwZWQKPj4+
Pj4+Pj4+Pj4gYW5kIGNoZWNrIGZvciBpdCBpbiBkcm1fc2NoZWRfZW50aXR5X2lzX2lkbGUKPj4+
Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogQW5kcmV5IEdyb2R6b3Zza3kgPGFu
ZHJleS5ncm9kem92c2t5QGFtZC5jb20+Cj4+Pj4+Pj4+Pj4+IFJldmlld2VkLWJ5OiBDaHJpc3Rp
YW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4+Pj4+Pj4+Pj4+IC0tLQo+Pj4+
Pj4+Pj4+PiDCoCBkcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX2VudGl0eS5jIHzCoCAz
ICsrLQo+Pj4+Pj4+Pj4+PiDCoCBkcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX21haW4u
Y8KgwqAgfCAyNCAKPj4+Pj4+Pj4+Pj4gKysrKysrKysrKysrKysrKysrKysrKysrCj4+Pj4+Pj4+
Pj4+IMKgIDIgZmlsZXMgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+
Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3NjaGVk
dWxlci9zY2hlZF9lbnRpdHkuYyAKPj4+Pj4+Pj4+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1
bGVyL3NjaGVkX2VudGl0eS5jCj4+Pj4+Pj4+Pj4+IGluZGV4IDAyNDljNzQ1MDE4OC4uMmU5M2U4
ODFiNjVmIDEwMDY0NAo+Pj4+Pj4+Pj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVy
L3NjaGVkX2VudGl0eS5jCj4+Pj4+Pj4+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVs
ZXIvc2NoZWRfZW50aXR5LmMKPj4+Pj4+Pj4+Pj4gQEAgLTExNiw3ICsxMTYsOCBAQCBzdGF0aWMg
Ym9vbCAKPj4+Pj4+Pj4+Pj4gZHJtX3NjaGVkX2VudGl0eV9pc19pZGxlKHN0cnVjdCBkcm1fc2No
ZWRfZW50aXR5ICplbnRpdHkpCj4+Pj4+Pj4+Pj4+IMKgwqDCoMKgwqAgcm1iKCk7IC8qIGZvciBs
aXN0X2VtcHR5IHRvIHdvcmsgd2l0aG91dCBsb2NrICovCj4+Pj4+Pj4+Pj4+IMKgwqDCoMKgwqAg
aWYgKGxpc3RfZW1wdHkoJmVudGl0eS0+bGlzdCkgfHwKPj4+Pj4+Pj4+Pj4gLSBzcHNjX3F1ZXVl
X2NvdW50KCZlbnRpdHktPmpvYl9xdWV1ZSkgPT0gMCkKPj4+Pj4+Pj4+Pj4gKyBzcHNjX3F1ZXVl
X2NvdW50KCZlbnRpdHktPmpvYl9xdWV1ZSkgPT0gMCB8fAo+Pj4+Pj4+Pj4+PiArwqDCoMKgwqDC
oMKgwqAgZW50aXR5LT5zdG9wcGVkKQo+Pj4+Pj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0
dXJuIHRydWU7Cj4+Pj4+Pj4+Pj4+IMKgwqDCoMKgwqAgcmV0dXJuIGZhbHNlOwo+Pj4+Pj4+Pj4+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluLmMgCj4+
Pj4+Pj4+Pj4+IGIvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluLmMKPj4+Pj4+
Pj4+Pj4gaW5kZXggOGQxMjExZTg3MTAxLi5hMmE5NTM2OTNiNDUgMTAwNjQ0Cj4+Pj4+Pj4+Pj4+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jCj4+Pj4+Pj4+Pj4+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jCj4+Pj4+Pj4+Pj4+
IEBAIC04OTgsOSArODk4LDMzIEBAIEVYUE9SVF9TWU1CT0woZHJtX3NjaGVkX2luaXQpOwo+Pj4+
Pj4+Pj4+PiDCoMKgICovCj4+Pj4+Pj4+Pj4+IMKgIHZvaWQgZHJtX3NjaGVkX2Zpbmkoc3RydWN0
IGRybV9ncHVfc2NoZWR1bGVyICpzY2hlZCkKPj4+Pj4+Pj4+Pj4gwqAgewo+Pj4+Pj4+Pj4+PiAr
wqDCoMKgIHN0cnVjdCBkcm1fc2NoZWRfZW50aXR5ICpzX2VudGl0eTsKPj4+Pj4+Pj4+Pj4gK8Kg
wqDCoCBpbnQgaTsKPj4+Pj4+Pj4+Pj4gKwo+Pj4+Pj4+Pj4+PiDCoMKgwqDCoMKgIGlmIChzY2hl
ZC0+dGhyZWFkKQo+Pj4+Pj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAga3RocmVhZF9zdG9wKHNj
aGVkLT50aHJlYWQpOwo+Pj4+Pj4+Pj4+PiArwqDCoMKgIGZvciAoaSA9IERSTV9TQ0hFRF9QUklP
UklUWV9DT1VOVCAtIDE7IGkgPj0gCj4+Pj4+Pj4+Pj4+IERSTV9TQ0hFRF9QUklPUklUWV9NSU47
IGktLSkgewo+Pj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgc3RydWN0IGRybV9zY2hlZF9ycSAq
cnEgPSAmc2NoZWQtPnNjaGVkX3JxW2ldOwo+Pj4+Pj4+Pj4+PiArCj4+Pj4+Pj4+Pj4+ICvCoMKg
wqDCoMKgwqDCoCBpZiAoIXJxKQo+Pj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBj
b250aW51ZTsKPj4+Pj4+Pj4+Pj4gKwo+Pj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgc3Bpbl9s
b2NrKCZycS0+bG9jayk7Cj4+Pj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBsaXN0X2Zvcl9lYWNo
X2VudHJ5KHNfZW50aXR5LCAmcnEtPmVudGl0aWVzLCBsaXN0KQo+Pj4+Pj4+Pj4+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAvKgo+Pj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICogUHJldmVudHMgcmVpbnNlcnRpb24gYW5kIG1hcmtzIGpvYl9xdWV1ZSBhcyAKPj4+Pj4+Pj4+
Pj4gaWRsZSwKPj4+Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIGl0IHdpbGwg
cmVtb3ZlZCBmcm9tIHJxIGluIGRybV9zY2hlZF9lbnRpdHlfZmluaQo+Pj4+Pj4+Pj4+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgICogZXZlbnR1YWxseQo+Pj4+Pj4+Pj4+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICovCj4+Pj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNf
ZW50aXR5LT5zdG9wcGVkID0gdHJ1ZTsKPj4+Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHNwaW5f
dW5sb2NrKCZycS0+bG9jayk7Cj4+Pj4+Pj4+Pj4+ICsKPj4+Pj4+Pj4+Pj4gK8KgwqDCoCB9Cj4+
Pj4+Pj4+Pj4+ICsKPj4+Pj4+Pj4+Pj4gK8KgwqDCoCAvKiBXYWtldXAgZXZlcnlvbmUgc3R1Y2sg
aW4gZHJtX3NjaGVkX2VudGl0eV9mbHVzaCBmb3IgCj4+Pj4+Pj4+Pj4+IHRoaXMgc2NoZWR1bGVy
ICovCj4+Pj4+Pj4+Pj4+ICvCoMKgwqAgd2FrZV91cF9hbGwoJnNjaGVkLT5qb2Jfc2NoZWR1bGVk
KTsKPj4+Pj4+Pj4+Pj4gKwo+Pj4+Pj4+Pj4+PiDCoMKgwqDCoMKgIC8qIENvbmZpcm0gbm8gd29y
ayBsZWZ0IGJlaGluZCBhY2Nlc3NpbmcgZGV2aWNlIAo+Pj4+Pj4+Pj4+PiBzdHJ1Y3R1cmVzICov
Cj4+Pj4+Pj4+Pj4+IGNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygmc2NoZWQtPndvcmtfdGRyKTsK
Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pgo+Pj4+Pj4KPj4+Pgo+PgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
