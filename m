Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A9F3EB64D9
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jun 2023 20:16:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B447610E0B6;
	Mon, 19 Jun 2023 20:16:20 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDACA10E0B6
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jun 2023 20:16:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5lLihC1qjbAruvB+VQnNTDJj7b8wXupOP/odEUQ2QWq0ZDxSi1ewuBKtU5eljiep3ktpBHRCgTOE2NF+CbZuyFQO7ll9ZO3Ar83DmeKiyTrFvllkwWl+FlTTPiAinCUcztdApuJlvkXLqfwR7bpajTaqJQjJjmuKVvFtxwNAYWZqVWxdAu04daE+rMd4yYrvMmKcJxzriTw8loXsZZ5hfER67oOkRlda91YEvLcVCVI2GI/sBdjwpH1KW1UrfAYJ6EVQpTO7DxyFi2Re781XUfPz+t9n5bjcJIZN0yMki6L2mpBZccIyT6GdzWpo3c6iT++wgu3WkRKZ0jpNYHAiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bolwKHofiiz9K6FoM5cGfK6M47H0iv/3lY/VaA5Htzc=;
 b=oDqaEy1o/0qKbzFCac0D4Xrk0Ex1fTa2J+zRrMwId53TGg/t9cfqvt/nf3Og5i1WdEdDyaVCR+50a1CtlObLABDSbnTpCw90ymFEqyCVHnQskYLMYEMOQXrM8u7OPV22qFGQoipvhgKvDDrifHRmvuGgCKA9k6Pjnmltdh7icLKxwhwaFb1okRfI91MjTI3AN4lxX34Dmua6tB9uAv9QyW8+TPdOLYSjmpm05HZSi5geFZpk1RbM3Eq9y0X8ozhG/8luJHKu0KPHJOzpM9wLSz/tVqDLF3m97jOa42pjjKmEm+vp1w1rqh29nszPNe55CNr2J65aWOb86tSe1qNhyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bolwKHofiiz9K6FoM5cGfK6M47H0iv/3lY/VaA5Htzc=;
 b=wD0SQVp0Ck5s54BgvStiJqFws/AgPgTmYWhNiniBzopmE8egw2rEdn/beyvqPlxnZoCyuZxZk26MnYDZOrQh6BbIZtYXNmJcyC1zgl76KnGnWN8LAlif5n8/ZsPAl6FXMnQWstpeyTc6fxZaj0PnEC47TMs7SAAvtqeioWL6koU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 DM6PR12MB4284.namprd12.prod.outlook.com (2603:10b6:5:21a::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.36; Mon, 19 Jun 2023 20:16:15 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::fe53:2742:10f9:b8f1]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::fe53:2742:10f9:b8f1%7]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 20:16:15 +0000
Message-ID: <3f9c7860-4fd4-282a-e593-c25437060b5c@amd.com>
Date: Mon, 19 Jun 2023 16:16:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] drm/amd: Disable PSR-SU on Parade 0803 TCON
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230619201321.18882-1-mario.limonciello@amd.com>
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20230619201321.18882-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0311.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::14) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|DM6PR12MB4284:EE_
X-MS-Office365-Filtering-Correlation-Id: a0b39171-a65b-4ccc-ee25-08db710208d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VKbMvl25HJdMX7XfJ7lfpozPwXNyvJ+tYoxwmrKTHsBSp9PmJUlUvRF4N63DwqLFNwhsU60TJsZM0f6kJEfop6FL5Q7S+r+HdE8RkP9mrlhQwAyh630imwHIx8DYTI/oOxXDmDqI5h/Of/GxhBxDy0R7VkhTUJpj5WtbJ85OL5C/QLZPnFXu6VCjZkLPVH3p6Pg62caY9zXJnDEZWU553Fb9FScIf8ltNTJCv0Bz0scognGKxRZd2LBOpU4wC5V/IvJRioQSaBqTTRYBeKhk41Vp7sKlQU43Tbz+4L/Qv6O2FFPrjoNwRMHhEjccmED64KDn7ex49uzNurUI8yQfK4ymCZ2Xdzq+wY45MvP9SE4xz9k8sd0ghB/pp8eVdpHLUqjiEuEM32yzgAO6lyUhT2OUlFIZbK4AZ9ujnZhTN4Mulo+NaD8i2Vh1Zw5gA1rj1uqt71x/HTsJbIrjpyTAdHR6ywuLZzYgosoNYoeFcbIsVpG0jWVDuV1CJYxNmB+mdlPrwGWYK0LZvokzKbUynfpRPVIDrYi1R4Ei/8t50sg1QgjhtVXJlePOup6/9rT1jcvjIRa9oGV618lrhZdHYvA99ZSMqS2Ct1mSeooJ/64X8TievD/TscMTAwR/pe2wP8lqkz6+dttxoLRaFqOJvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6280.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199021)(6666004)(36756003)(53546011)(6486002)(478600001)(8936002)(2906002)(966005)(6506007)(31686004)(26005)(6512007)(44832011)(8676002)(41300700001)(186003)(86362001)(38100700002)(31696002)(54906003)(316002)(5660300002)(2616005)(66476007)(66946007)(66556008)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFpkZExrYkNRV0dBYkdDUHVtM2dkeWd2WlFvZ2E5ekpHMHUvbmw3RjcyNitr?=
 =?utf-8?B?dWdYWXFlTWFyQkI0K29TeDhMZUdhOVY4WXcvRERmNWduYkY4bTBJcTFTSVR4?=
 =?utf-8?B?VEUxQVJhVyt0QXdEM3VoazJZdnB1dXNid1FJTUxCSzlHSi9uSTZwRzExdDZ5?=
 =?utf-8?B?SmkvblFjOWVXYkRSMzlmVnRRcWVONzhkYno5eTNXYVJTY1JSeTFmTlY3K0wz?=
 =?utf-8?B?VXJBeUM3NWgyY3BSVFhLMW9kTzhzVUk1dVZ6RDA4ZzVaMGVDU3E3ZFk3enVS?=
 =?utf-8?B?dlpweXZzQUUvZWFQbytYbzJtTERxSzNhSE5kMDFGeWpJWGowUFlVSWlUdjdp?=
 =?utf-8?B?dWczMVFQdFd6eE9FSHZFTmVQYm4wd1pSdEhmRzRoWkV0QWRBeEJhYVNrZm1U?=
 =?utf-8?B?dEJ3NUkzRURoSGJ5OVJ3WE8wTCtXeksxcDdMVVFGQnA5T0dUejBZQjBmeVlF?=
 =?utf-8?B?YUwwS1I5NVRmNXlvQ3grTkZNUXN6V3VibTNqTG5rL3QwTWRhcDd0dWw3MGRo?=
 =?utf-8?B?ZGovWVBadThHMjRGQ2JhdFBtMEd3R2JBN01EQjYzeW96cTJPRGVMNzc5ZTJ4?=
 =?utf-8?B?RTVQZUhWSi9mK0ZOamxJN0NkR1JpV1NIdm12Wml4bGxaWm5teGxTVWJRZnBj?=
 =?utf-8?B?R2YvdWlMQk1NdC85Y2hNL1hmWFNxRVZGZ0FjMDV6cGZldlJvRW92TTlTaGV4?=
 =?utf-8?B?OHhVQVZhNTRsNHNVRXo2aGlBUkhFeSthczZySmw0TWJsYk9kanQ2WldPeXhy?=
 =?utf-8?B?bUlUdnRWZzNRN250TU5NSmNIVVgwYVU1OC8ySVJwaGRyWlM0NWs0ZlBkMWt6?=
 =?utf-8?B?NlkzS3piZXE1UVRrK1ZWUUlRTWo5RnIzL3V6dGl6ZCtvcFo3czNHbk9BZ0M5?=
 =?utf-8?B?cXZsYktKLzlaUTg2SDg1U0tLZEw5WXhWMHpyRlhIYUo2Y3lHeXlreEw3Qnp5?=
 =?utf-8?B?cEhCL2tlN3JVWEpHZERnbm14WTRXMys2MnQyR21GV1R0SHdWTGtBTllId2g2?=
 =?utf-8?B?b29BUFhkTkpTUmI0Njdlb3NCb3liczV5ZXFPQ091a3dNSXJSc3FnVUh1Z3VZ?=
 =?utf-8?B?aWtrd0JvbTZNcUI0emFBNUVWNE83VVY5UjloQ095aDJ2L0pTcithVGxKSVlt?=
 =?utf-8?B?Y2pndzdON1Bla0NGNUZBRkN6M1oyRWRRbVBMUVlEd0NaODBaSlJFNTUxSldG?=
 =?utf-8?B?VzBWdVhLcENIQ2V6a0FLdm9mRTNVcW8xaWJnYXpTSVB1RWpwbitOelVDcFQr?=
 =?utf-8?B?dHR6TFl5OWhpZzlHdnJacnJ3Qy9nM211RldQMEFHU3ZSVlJMYldycWdvRy9V?=
 =?utf-8?B?K21jNVhsR1cyd3RvWjVBbzNTbi9xZjE5dEU2ZGQ5ZlFmczdMNFRRbGFEUnBt?=
 =?utf-8?B?dm4xSlowYXl5ejZGZ2ZrQk1ZaENaYk51TTRjUHJSejNaV1QvZUV1bWE5Z0tG?=
 =?utf-8?B?Yk5OeGFhdWd1NnFIQzJLWWlQRTk5VzhqWXYxdjJvYm5tM25ZLzZVMUVQT2tH?=
 =?utf-8?B?RkllbWxXdDFTa3RmOUJ1WW1xWTdQMloyVWJuRXhKMnpHdUpySkZNMnA4QXIw?=
 =?utf-8?B?OVdwL01xeEJSeVh3djJpdFpWK1ZYRm1IclA1VlJDemV0dGNtNFlkY2RBWWJj?=
 =?utf-8?B?bGVTNHlYT2lUaEhKTUN2N3d5bk1PQUt5VHNqRmxVcDRmL2NOa2lvaWpTWjlC?=
 =?utf-8?B?NG1kVkU2Nm42OERIcmdUZXBuVUlmZWdVUXRwK2lXcExBRXFEbHEyeUQ2QlVy?=
 =?utf-8?B?Nk1aZGpuNi9hN3FCVVBqK2VINTVKT01qd3h6TkV2VmthSnh4MENiaXJvMjd4?=
 =?utf-8?B?bm4wbnFZRVIvajZYcWJHeHd4bkwwSVJvcmh1ZHl0VlFTMm4vMHVoTk5VNzVW?=
 =?utf-8?B?VEdKU3BkYk9BTUtqMDl5bzRtbGdaSzBKbWkzNkhoS0RWWjA1c1JHV2J0VjQ3?=
 =?utf-8?B?WklDZWs1T1ErUWhvY2dFMkpFY3l5MHcreFRJSTIxR1R0dFRwUExTa0FYQ3RY?=
 =?utf-8?B?OHNmTUxDVFZ0T1JDM09DRFlGNTlXWHNmK0N3NVBNR0pWWlk4cmlsNG1Rc0Z6?=
 =?utf-8?B?R2QwVDQvY2ZRZmR6TDRRR3dxRUc1NXowTTdta3pQQVlrVksrbm9tN2NkTTZa?=
 =?utf-8?Q?s2P9vU6uTAdVmv3gzzfcJgTlq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b39171-a65b-4ccc-ee25-08db710208d8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 20:16:15.7165 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZfTpDH3KMIz7UrGPwl/g+F8JcIMzapt86Fs9KXz1k2WHz5vzp8rwyncsmV6dfVbWB/iv+ONg3Y09Pb5tPO2qwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4284
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
Cc: Marc Rossi <Marc.Rossi@amd.com>, Sean Wang <sean.ns.wang@amd.com>,
 Tsung-hua Lin <Tsung-hua.Lin@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 6/19/23 16:13, Mario Limonciello wrote:
> A number of users have reported that there are random hangs occurring
> caused by PSR-SU specifically on panels that contain the parade 0803
> TCON.  Users have been able to work around the issue by disabling PSR
> entirely.
> 
> To avoid these hangs, disable PSR-SU when this TCON is found.
> 
> Cc: Sean Wang <sean.ns.wang@amd.com>
> Cc: Marc Rossi <Marc.Rossi@amd.com>
> Cc: Hamza Mahfooz <Hamza.Mahfooz@amd.com>
> Suggested-by: Tsung-hua (Ryan) Lin <Tsung-hua.Lin@amd.com>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2443
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

> ---
>   drivers/gpu/drm/amd/display/modules/power/power_helpers.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
> index 30349881a283..b9e78451a3d5 100644
> --- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
> +++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
> @@ -839,6 +839,8 @@ bool is_psr_su_specific_panel(struct dc_link *link)
>   				((dpcd_caps->sink_dev_id_str[1] == 0x08 && dpcd_caps->sink_dev_id_str[0] == 0x08) ||
>   				(dpcd_caps->sink_dev_id_str[1] == 0x08 && dpcd_caps->sink_dev_id_str[0] == 0x07)))
>   				isPSRSUSupported = false;
> +			else if (dpcd_caps->sink_dev_id_str[1] == 0x08 && dpcd_caps->sink_dev_id_str[0] == 0x03)
> +				isPSRSUSupported = false;
>   			else if (dpcd_caps->psr_info.force_psrsu_cap == 0x1)
>   				isPSRSUSupported = true;
>   		}
-- 
Hamza

