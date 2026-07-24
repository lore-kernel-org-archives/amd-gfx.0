Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B3ECC531FA
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2026 15:44:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E528C10E047;
	Fri, 24 Jul 2026 15:44:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z/ysw4pC";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011054.outbound.protection.outlook.com
 [40.93.194.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 530EE10E047
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2026 15:44:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kGKPtV73ONQ3T2BgFmVgVzMUgvUnOePV3kPG5k7qZVUYIVQXJfvUJ2xZr1KWqRyPObpywcdTd1amWPwqWJuPFSyfv+AXBi/3AAYTbyAQcE+2zNf6ESlzrmNhsZ+QEYFuma9lquEivQs5R7/VZR8iHCvdnC3rGfqOrjzncnfjXqlt8jeJxYhMmuklqs/IVtKJYUOh/MJNpHuSmlTfgMmAFwSVWZQIShl5E8fYqRM6tEaXJ4nO++wa9wpQHSBdzhLP76bOuovoR9SFf1YiB4f/GjKKbWrESjNQZ5B2VGCLQyRJV284pre/kqX3L1P2v/2PCzYR4Y77BHn9Xv11bDF8MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVbtQzbMjU+DM2sm/f7YclcUWreYpnqlWbL9Bh82NVA=;
 b=ajWy2sRLqR0jUehDKHb2w+3TL3SnKjEn6khMIBSb9puB1wQ5Oes9k0+zbN7ny9AcF3LgmIxjGLtCrll7NfYBuTouXcniS0oBVjsYlY5C3AYfhe7BBq0h975YORrEIs8Wjz8k3KXPGUDC1anNEFaeIhBD7MRSC/4YU/18sy9VZFRiVGVE7YM9YG/+pMyMIrRXU7liQIAb+WNjgixnvl82MK6z7hEzUgtrdD5ZFSeAETrmyA8T7xEkVzTEh+u4oaP3frEi75qeIX1clP7oPiGPsZ25QExfaGwH5ivp/jsvuoWUFLy0YK65zhXQPnOJyYfgWBJ7O4Pp7rwNeRihBwVWsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVbtQzbMjU+DM2sm/f7YclcUWreYpnqlWbL9Bh82NVA=;
 b=Z/ysw4pCyEZNmpQUmcpqRzgNmd3kVXgfZa/vnRW3LvwHH748EnSfICpiHj3iy/IRqK1SMXfw3V6QYMRTUKYeseLmacLZm7/evQkLg5suZ8W7DXPLXHzAM5f2PvAzesZhPddmeNemCAP4vh1pb2uIPzsnsrc2C1bN7k7PpHh+Rp0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 by BL3PR12MB6379.namprd12.prod.outlook.com (2603:10b6:208:3b2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 15:43:55 +0000
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a]) by SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a%5]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 15:43:55 +0000
Message-ID: <3d1309dc-4358-412a-ab33-3531fe5c8243@amd.com>
Date: Fri, 24 Jul 2026 11:43:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/32] drm/amd/display: Add Support for HDMI Compliance
 Automation
To: Krzysztof Kozlowski <krzk@kernel.org>,
 "Chen, Chen-Yu" <Chen-Yu.Chen@amd.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Zuo, Jerry" <Jerry.Zuo@amd.com>, Alex Hung <alex.hung@amd.com>
References: <20260610094639.1965367-1-chen-yu.chen@amd.com>
 <20260610094639.1965367-17-chen-yu.chen@amd.com>
 <nGLVvJOTS8eSI7IusBrUxw@collabora.com>
 <CY5PR12MB6132D29C644F51CD57A3B3B8D2C22@CY5PR12MB6132.namprd12.prod.outlook.com>
 <3dcc390a-716b-45bd-bd4c-6a7c90a5bd49@amd.com>
 <e9debc91-2a69-496f-9004-f05109072ee8@kernel.org>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <e9debc91-2a69-496f-9004-f05109072ee8@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0352.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::21) To SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7007:EE_|BL3PR12MB6379:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bff647e-2220-47c1-9504-08dee99a5e50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|56012099006|10067099003|18002099003|22082099003|6133799003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: HQmOBHLVYW4CkNvW6VsCzJVi8oTt9dJGcuRODWYIIb5EepaOf5JHp0gLLI9xUrhwTKwucfDkTWqWw7Rb6KA0oKwJOANABMWOaErQ8tJn3JS5cvsQHT597NnAG6GAsRZRYKi5wx4T4EE6XsByZG325cQEzD1EUODGFfQj0djkfHZTdnylXOEMM58mwU/qAezpwgU7FDCC3OyRqE5arILMQo4SLib7FVDWu8UuZd9e61MIi/Alr/6OdN7R0KWbJGzyDhFIL8emZt9OcZZEseW44jDStPpqwMpvqbftoDV2kF9cPv7XvrxJx0Kk/mTns6C0MYzXm9SaevI0HHNbJMgCDow4WIVT9JbrgTjXcQrNuv7gqTfeynIvYj42GWvF4t6W5gwMy73Dgva2atFFH/M5TWQ6sjtkSrdvd3+igm7zPWTl2NXe37ID7Ht9Cqp9ysbW+MWL786ffSwLIP/A7Cn+tnGmp4zkabiqiL6zKWNaEo01sj6DcKiwOcQgnyrQ4CPX1kKAfphUER6ablS02C8iaJ046KR6Gpa4PXDu8VjKn6BFmh4tGIDzAk1CXTBJLTpcpa3bYf+5+Cbe74BoEscLAtnc24Z1hrMRQ+fmgbZr/k2fojWg6FBow7qR9pwTMTlBdDQNt+zn2UfVu2eTlh5B8ybgBMScU1vpgWXhMQdzF7U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7007.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjdpUXJCL01ldlJxVjBFYUpLcFZBeTNxeW43R2k1Rng5WGx1cjdxblUyaUhZ?=
 =?utf-8?B?WHI0VE9EM0lVbHlPWnhKM2d3dHY0dURIa21UYnNjVVp0dW42aE1vbUlsYmIz?=
 =?utf-8?B?amN3eXRTV2pOVWhmMzlLdk5LYk41QkprR010QTBDY3ltQ3U1Mmx0MU9helBy?=
 =?utf-8?B?M2RVcjFZQW0wbWxJeVR3YkRmZUZMMHNhbG96VHpuQW5EZndpWUQ2Q0EzcHRB?=
 =?utf-8?B?b1JzNlg1OWM3TW43TmgyK2hmUkVsSGhqQmpoNlJsN0N2cjczUEcxZXZBcVQ0?=
 =?utf-8?B?aTlCdmlvK3RaeldFWkVLQXRIS2ZTZHkyblNvejVHQXNkcTBGR08zbTlxZlNv?=
 =?utf-8?B?ZnhsWjNWWXZndnVjenlpZlc0WkF4NkxYKzUwR0JqYzBmQ1kvaUZwaFlZYWpK?=
 =?utf-8?B?MENlM3MzT0VQcVU5RGtUQ2hKblJEL09NUmJ0YXo4bSsxNC9OeG10dlQ0K2tz?=
 =?utf-8?B?ZWs3K1JCWmZQR3k0aTlDMVhZQXZqeG1COFV4cVZPY3NLVU8vNzRGWmpGVkp0?=
 =?utf-8?B?VkgyZzlnWk8rY1k2QlZqT1FQNHpjbFdQNS9heEFhb0U4QytneGh2Q04yakc4?=
 =?utf-8?B?OXpqQ2llSXdlZkY1TG05ZGwwQi9KZ2dOd3JVQmZISDgrcnhHSjZJcXYwOSs2?=
 =?utf-8?B?Y29jekRBR2hKdW5URmpkODhraGh0cmlZNEZsZU9uOGRWaUdaVUU4NDJhVDNT?=
 =?utf-8?B?b2g3NFVGK0lWdjMxbDNrcWhPY0dPZXhGa2Jsc0RvVzFqa1p4ejNjbjJJeEU2?=
 =?utf-8?B?MGNTZzlnOE9CWGVMbDNrRFJzVGloeXBDaGc5eE5FRkdETjNoK2djK0srdmg1?=
 =?utf-8?B?U0Q1T2NoRjEvRGVmb2VoTDh2V1lsUS9zeFQ0SFhsbDVuSmU1VnhuUDUwVFo4?=
 =?utf-8?B?Zzl2ckZPcERzc3BtcGVqRHoyQlZpamNCcDIwUUFQbVhYRmF1eWs5RlhiRFJO?=
 =?utf-8?B?d3poQzdiQkp6YkZmZzAveUVNUGZ6b2d2bjhQSjBBZnNmSHB1bW95RnluSHBa?=
 =?utf-8?B?TEk5VFV2QmlQaGlkVWJKbW45MG9ncC9ObzNwMHFlRDcyeEpTN0ZlMU93cVZW?=
 =?utf-8?B?d1JhaFBzc0lvREF1cTJTemxiUlNxSU4rVURIeXJ4TUxxZUVFalppS2p2Y0pW?=
 =?utf-8?B?VTZDaDNwakdKN0NYQzlOS3BSNnFjbi9MN2xhNGxxYlpzcVJGSDFYWTRWaW5H?=
 =?utf-8?B?MHIySDIyZDJwREhDQmlPVHZYY1E0NXJ2c1p4SmRqMms5TE1qMENxdlNkblF2?=
 =?utf-8?B?Q1ZPWTJoQ2JBeU5vcklKdFNua1Y3TkxCaTJha2J5dHIyVnR2L0ZpZzFlem8v?=
 =?utf-8?B?eS9WNjRzclcyd2hQNVVyZ2I4Mmt2M2h2ZzJRVUpzL05abGFPKzQzVDlWcVMx?=
 =?utf-8?B?c3BLQWVhSDBwcGQveUV5V3k1RXFka21rY3RPN2xBZDlvd2E4TGRJektjcGs0?=
 =?utf-8?B?QTQzWVlqNzR3ZTA0VkZyTTlWVE16Nk5MaEpyTFNiS3pNOGxvWEsyZURkbnU1?=
 =?utf-8?B?RDNjNTdqWlc3RnIrd28rUzVRUE8vbC9NdE9wT2JaNFRQbFB1WDA2WFVneFJN?=
 =?utf-8?B?N2xsWGdBY3FlaCtIMU41Mk95dUwrbDNxdG1ySTdLNHk5L2M3a3RNTS9IZ0N5?=
 =?utf-8?B?WU9qUDQ5dXFIVStmZjQ5ZGZCS21BQWxCZlNPVWRlK1kydlBQNzB2Q3J4Q3B4?=
 =?utf-8?B?OS9iV3JvVXBMNFp4b3JhSkY1YVA1RU1jQnUvRTk4L2xNTnREOHduelJqcTIw?=
 =?utf-8?B?clZSRG9yMTZ4Ky9paUp4VDBvRlJoTzFoa2NIUTFQbmtQV0hxeHh2Y2tiQ3dI?=
 =?utf-8?B?b2xPM0w3cUMxU05UVUY5N0x4QkZtUDVuNDQyNTlJTGkrazQya1laNVBaNDVE?=
 =?utf-8?B?eTcrb1RIeGErbHI0NUk3TndZTk1rd2VyRXdobVdJN0JuUk5iVUdJWTR4VWxu?=
 =?utf-8?B?TjBYV1N3c1U5WHFXYlpFaHFEbTZldmNSc202OEI0U2d4YXVaQUtnVHh1YWJu?=
 =?utf-8?B?K1lNazN2TGhpcEI3YnBkR1ZDUFNMNWpna01HeEJBY2FZT09kT0FYVXVuS0Rx?=
 =?utf-8?B?UFJWS0ZqTTVlSGs1eVNsSmN3d3h6cmVDY0RRanROMElZaWpiT1BCenpKUUsz?=
 =?utf-8?B?UnA5VG10a0RxaUtKQ1JDNlliNU1oWjFlaGZCQVFoOWhQbGY4QlZRWnQ1TFBw?=
 =?utf-8?B?V0V0UHB2UGkyVm1EN3VIZlhkbW1tQVNyb2U0Rkozd0FmN2lBeG1ZdE5aV1lM?=
 =?utf-8?B?eStrZ2pIZVJHbGpGbkYrNE1EYk1Uc2tmOWhJNm83TVZLVTg1UkNWZ1QwdEJI?=
 =?utf-8?B?ZlVqN1Y5ZmRsWm5uL2MwcDUxNkNWNFZZaWdQenQ0SmVsYTBkc1dLdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bff647e-2220-47c1-9504-08dee99a5e50
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 15:43:55.2053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wFSPH1BejeHphhAKcPhpoB9ipy/LLhGCebv7EhIJdoA3d21mEQqQBNV/aEiYg6J9Z7OSp9Zy+agt49207UQSjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6379
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



On 2026-07-23 17:17, Krzysztof Kozlowski wrote:
> On 23/07/2026 05:57, Chen, Chen-Yu wrote:
>> Hi Nicolas,
>>
>> Sorry for the very late reply.
>>
>> I recently discovered that I missed this review comment when promoting the series upstream. That was my mistake, and I apologize for overlooking your feedback.
>>
>> I have since reviewed the comment with the original author. After revisiting the implementation, we do not plan to make further changes to this patch.
> 
> NAK, drop the patches and implement the review.
> 

And what will that accomplish?

Nicolas comments were good. But they're not core to the functionality
of the work and can be easily addressed after. We had a brief chat and
the comment that we don't "plan to make further changes to this patch"
was a miscommunication. I'd like to apologize on behalf of the team for
that.

> You received review, which you completely ignored because you are used
> to develop all this stuff behind closed doors and LKML is just dumping
> ground for you. Dumping of already approved work which you do not even
> bother to discuss.
> 
> Dumping ground of such reviews and multiple Signed off by:
> 
> https://web.git.kernel.org/pub/scm/linux/kernel/git/docs/linux.git/commit/?h=docs-next&id=a8657c82a6dbda34c918e13d93c4005a103eb00b
> 
> Really, what did you review there? This:
> 
> -#define DC_VER "3.2.388"
> +#define DC_VER "3.2.389"
> 
> This is even better:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/docs/linux.git/commit/?h=docs-next&id=312c2729b0130fc1629f19eceebbce60aae5c7eb
> 
> Because you even tested something like this:
> 
> -#define DC_VER "3.2.386"
> +#define DC_VER "3.2.387"
> 

And what's the issue with carrying a version in our driver and update
it regularly? This is code that various people port to various downstream
franken-kernels. Reading the version number lets us and others know quickly
what they're dealing with.

> Of course these fake tests and fake reviews barely matter. What matters
> is how you actually *ignore* public discussion (so your email client is
> not even configured to discuss on LKML and does not wrap replies) and
> then claim "we do not plan to make further changes"...
> 

What fake tests? I can assure you the tests are anything but fake and am
not happy to see you drag Dan's weekly work into the mud.

Harry

> Otherwise this is just bcachefs style of upstream collaboration.
> 
> So please start making a plan and start discussing your work BEFORE you
> merge such patches. That's how upstream development works.
> 
> 
> Best regards,
> Krzysztof

