Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF6DC43334
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jun 2022 21:35:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20F0310F852;
	Thu, 16 Jun 2022 21:35:52 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 439AC10F852
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jun 2022 21:35:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4MDt7v/yURhDC+NrE7miZWcryqXV16qYR52t3gu45UwzSs4JOKwsCpz6xDvT9AYZ+Ro2VaVUKBW9/YB09h3wh53AhW8M9EWTFxXJxvqCogq+mkXO0LemM2BzBfhkRzGPumQeJXsESx9UZkFszkpaGFOg8tdt1ow5P2iQKZb77eeayQlE9ehvRaRZeYmFq4+72nmhVa55YutCEFga9L7yzZVcMISuz5BOWD+KQEvfaQKzIT31ZeKaQbbzKUbsqdu1Pb6jeOj4BOr5u8LAzdzwAa6TLP5d0Mv0c1sYz50qhYjHCzYMSDj8Sdn6HYqvWRMzQU4Ui1Sdl1btF2g/jG7uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rihA99pQAdVXNYzGghqAyjg/0NaWcXAFXmjk1jgMq9Q=;
 b=iuq3nd1+Gd5SiMAzglLQqh3hewiejyWdRKmYq4UiZWIxa4wD6HeL5Avkf9YEwyjWFwrw7+z8y0qnxsfb4bq527vk75POFCkyghkR5glxoTIMYWMNN723mnsiD8Vpzk8N2jmV3kE3Fxrls6w4A+DXUVvPA7TOfKU/vTJkIAEoS4rXofXG4KkLR3BUx35bArqZnTdcaIeTAarqLUNGfz4WPJj+D5thtgSGU8KkBmREV5vG/n4hP3YonguwRP5vQJLo0LBpmnHqTX2wcR608xLz2czhPJ4MT/1QCIxSDGXryJZkzckpo9xhzXIBXJVbV38MBeqz5GBvi4c2KhmuFKuSJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rihA99pQAdVXNYzGghqAyjg/0NaWcXAFXmjk1jgMq9Q=;
 b=mhFVRZJpKD1GIOzNhsf4Xud+oUdZNvrHWEBs2iOvM43kWqm8d/chQ9Y/6GqGv/CaogUElTEQeb96au1jPxt/Hms5UfvvOgyS66jeGgmU7iLxGwHSbWPPYRX/tVZvli0CTeC4pE1wt+fiYLmjgBy23KvISZ9q8QSs2ZNGliKI2EE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by DM6PR12MB4483.namprd12.prod.outlook.com (2603:10b6:5:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Thu, 16 Jun
 2022 21:35:46 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::85a:3075:1744:8317]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::85a:3075:1744:8317%7]) with mapi id 15.20.5353.015; Thu, 16 Jun 2022
 21:35:46 +0000
Message-ID: <629ce27f-2e51-0ef5-8965-06655bd1cacc@amd.com>
Date: Thu, 16 Jun 2022 17:35:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/3] Documentation/gpu: Add info table for ASICs
Content-Language: en-US
To: Yann Dirson <ydirson@free.fr>
References: <697640373.608902230.1655303693136.JavaMail.root@zimbra39-e7>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <697640373.608902230.1655303693136.JavaMail.root@zimbra39-e7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0132.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::17) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3da9f509-0c08-4bb5-16d9-08da4fe02c53
X-MS-TrafficTypeDiagnostic: DM6PR12MB4483:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB448371E738C4DF05A664ABF998AC9@DM6PR12MB4483.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CubRWH1fY2gJtvXTx27jGwzLD6O2dR9DbclOo4rMBBtfw0mF0mW7yniY4PhzeKSyZrU3paDaibF27N0TTNbGastnEFL4lcPysWXMvWfWR7RHH9hRpQV9Lwc7goiA9Tx0iF7kKnXvdkLO6e4P+58+2HEqjNkxjfQ+Px81RG3FxOugdlIa8N5aPL4EnNiwfLZfuf8nGDfWYE04V+HruwF7Zn7RNSioTb2H3tQEUoKmv/Ice21COcxP2eh1RFf4fIv9x04KPyWTjTmvXQtR4xAfhFMu/WGwKKSy6Hq8z1DqLBEbZzwQ4wCoc6S0pybPfXhYXl0/c9BKfkQqx865KvjP2F1XpV+xu8k2+C2CKvagg2fJOBevX9r7hIAwFrodv+ACkRtGMZjHw4xz9EIzRaKQyd9vs30Ra7Ks8gy61YV3tJfjqyTxNYSNVftXoFVgprp7SIUfMHHVY4Mepo/i4Q55kddY75yOD6dlzUkYiSQLEUB+UIKbgo9CLHMNbRduSeOmPtAC75AWnZx6JCUGCE0W0tkPjBM3uXPvmWOEaSEhfiWFRUi4xAEwYwao/SpaiIjNQIJPeKDAJQpTGmGeAmRjCRMv6Ol1D9GNSRf0UTjBvLq5DbrPZbSKq0Pw+QPswazAndONuVs60QhT7I3PAR8/maGwoQ0XBbC5SKESQ1oPZy1N1Etud4dVRY5VxKQUbhhNwRKFfOupHniQuq8FPcFvI8Fac9ib8mrd2SO/MlngSpMENSbfBRk0Av3e0ec9Ki7/bqXHpURhtb6Qoov8cQT95Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(6486002)(26005)(8936002)(7416002)(508600001)(6512007)(5660300002)(53546011)(6506007)(4744005)(86362001)(66476007)(2616005)(2906002)(186003)(38100700002)(31696002)(8676002)(4326008)(36756003)(54906003)(6916009)(66946007)(66556008)(31686004)(316002)(41080700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlE5elIwZE9WNXIzWXlLTjVTdSsrSU9LdVNhUG14Qk5mY3hlL2hLUFZtSVZ4?=
 =?utf-8?B?M3kwUGRja0pBcTJtem5BZEpteDdMYXFkVUkyN1hodFRkN2xhd0MzZHE2ZkFn?=
 =?utf-8?B?V1UyWXhCU1dmcDBSdm94VUZEU1VUWFkrNnhRSi9YUUVIZEZzeERlTkZkREVF?=
 =?utf-8?B?MThvTmpGSjViWDNuV3R0OEpRcHZXQW1ObEhRbmhodWVjUEtlNjJqVEJCekIr?=
 =?utf-8?B?OHBmTUlzM01OUEt3ME5VT3E2Y3RtMnlrUGI0RTFjK1NQR2plaVY2NDJEVlJq?=
 =?utf-8?B?Nk84MlludzZ3VnRXeGhaRy9zakVHa1dXNFFYK3VYaEI4eXF3dWpHUkFGQ3Nz?=
 =?utf-8?B?SHdPcDdvWlhHVFQvUHZnVTlYVkdTMno3NDk1NVFBR1R6SGY0cC9WY1d3QWp6?=
 =?utf-8?B?cnNsQXp3SGNDRHRtZHFHUkRkSU1rblo0VW9XdmxvaVFWb3l1eS85ZjNxV1Rj?=
 =?utf-8?B?SWNMNFVpV1NzTEE2Y1Rrb0ZkUnc0N0lhb09MWkd2YVROS3FDOWlBOW9oQlF0?=
 =?utf-8?B?Qy9CKzdISE96RTd3cU9qVEo4YTRlQm9OMCt5dEtzcUtxWlg2SHFZaEtmY1lR?=
 =?utf-8?B?QnpnZTlYWkt2UUFpbDlCb25uZWtGSDl5LzJzd1FKdmRtbHVNaE5MRk5pWlZn?=
 =?utf-8?B?WG1IVVZ5TW9rak9iL3lkOWI3MStVN2RTcUF4a2tEUTR2MnR0K2l6QWFDdHBH?=
 =?utf-8?B?NXYxS0dkTFhUMEFzb3I1YnplSGFRazlFMnZoR2xQOU5iN01JMXMzbm9PaUJI?=
 =?utf-8?B?ODJoV3VSamZscUlCemk0NzM1QS92MzBkRloybkJ0cENWSDBta2t5R1RVV0ZP?=
 =?utf-8?B?MGkxc3RJNUxIOG5xMGwwVE9DM0NGekJQd2dzdTZEdGRhRVF5Q0NpRUI1bmVH?=
 =?utf-8?B?WmlDRzBwV05FQlFGUUlTZmkzOWlMVDhTSE91eEZWU3ZLRVFiWXJRckQzRzVX?=
 =?utf-8?B?N2FZa3ROQVJKZHF5MUpnL2hJUGVPcGtTbHhWU0FhQXBuczhMbVNVdWtieVln?=
 =?utf-8?B?aDZYdTRSK0Q0QkRXZCsxZmxZSTNXUldPdTZtb2xjWlcwdmdVWkV4MS83Zjlr?=
 =?utf-8?B?d25tTHRYa0sxWHZzRENqTjU4RGtVSTdYdE1OckJ5S0pmV1NlYklwZnNHWkFJ?=
 =?utf-8?B?N3IxS0VZMXpMWlg5dWNFQklUSDkxcUNlOUpJZEpyM0h1bE5pbVpUQkY1cUc2?=
 =?utf-8?B?akN1ZGtCWitBT3dLcEFBT1gzbWZSdkd4TDFOQm9yY2ZaSSt0KzNMTXdRVGRI?=
 =?utf-8?B?WlJYT2lVY1dHQS9HNm1tQU12U2xvaU43YmpubkZIRS9OVVVYdVVkQ254SFMv?=
 =?utf-8?B?cGh3ckpjYkNMMVdacXJqZktrMkYvRDFRNklqVWZJY3pkMUpQTlVOWGN4ZUcw?=
 =?utf-8?B?REN4WXozaUZqbkRPS1hOOE85YzhkbXdJdTNVeXdwRUtPNXBpR2lEc0EvQzdu?=
 =?utf-8?B?cGIvNXhyVkRxVkNiYlVsTmZVMG0rWWZleGpwbnRPSVZSeTl4dDBKNzd5RC9u?=
 =?utf-8?B?Y1c5U0lHNjQ0K0wzai9ncVViOSt0Rmd3VnZ0cTJUSnRoekhBZUVwZ04yeGVs?=
 =?utf-8?B?cHpQTlVDUlVJbjZIekt3blNjUTAxVnkydnpUR0lITndTRW5tdDZUOXhraDBs?=
 =?utf-8?B?WUZTQnVWK3RLRDl1ZVhkemYvQU13NGdyVFk0K2NYY1lSUlpmeUt2YkN4YSsr?=
 =?utf-8?B?eGx6WVdYK3krTERzNmZHSmlpMGo0VUFYZ001WW1hbURKZWR1NWpiWGxxNTVq?=
 =?utf-8?B?Nm03d0pPakFUSnNxOVVnNG5abjdvWGk5MmZOd2NXTit1NWwzQlIxWG5NQ09x?=
 =?utf-8?B?ZlRNRk5PNDcxdmU5d0RYVC9uTjI5bDdteENPRlExRDBrM05Pd2N2VVVCZVRM?=
 =?utf-8?B?YmZZVUVBc2ZBZmdvSEhzS3k1UG9BdnNpWWN0WVR1YXp1K2x4UlFlVUtEbWFl?=
 =?utf-8?B?OEdiNms3YURFTkN4djQ1OGd2UkMxK0JUNU02Q3BmWlBkR0ZEQ1B3RXp5QjQ2?=
 =?utf-8?B?RS9pUWtNSkJqNGQ1K29ZUmh4QXJzYjJSMmwrN3FkY29RZ3JVN3didXErTG9n?=
 =?utf-8?B?V0NPQnhaNlNVekN2U01EOEF5QmdieHVlMUsxektzV0I5dFE1WisvUEtFS0Q1?=
 =?utf-8?B?TU5LdTUrTFkrR3ZJL3l1VXpvN2kxbjN0dlBUN2pYK2FCSmE5YzZkMEtVQUd5?=
 =?utf-8?B?TVhLYnJLSjZIem51VzZPZGw2aCs5L3pubEZQU2I4clBkYUhrYVVsZnVaTWhw?=
 =?utf-8?B?bDQ3MndNUjdFa2dUZkNmaDlLR1R2K0ZrZlpIYnNHVitHcWRUeE5ZOXd1dFZl?=
 =?utf-8?B?MjN1WTNkckF5L082emh4VFcxaFNvMm1odEQrL3lZS0Ywd0VDdHZNQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3da9f509-0c08-4bb5-16d9-08da4fe02c53
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 21:35:46.2664 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pWjuaxn2bo3EecmbEVNK1dEgrtlGVGjk/txRjZjBgrNns6MjFAtf4IIgPTbPCu1wfR4npEcFXwCeVMNSA2HHQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4483
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
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>,
 Alex Hung <alex.hung@amd.com>, Simon Ser <contact@emersion.fr>,
 tales aparecida <tales.aparecida@gmail.com>, amd-gfx@lists.freedesktop.org,
 maira canal <maira.canal@usp.br>, mwen@igalia.com, Leo Li <sunpeng.li@amd.com>,
 Hersen Wu <hersenxs.wu@amd.com>, Mark Yacoub <markyacoub@chromium.org>,
 Sean Paul <seanpaul@chromium.org>, isabbasso@riseup.net,
 andrealmeid@riseup.net, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 Pierre-Loup <pgriffais@valvesoftware.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-06-15 10:34, Yann Dirson wrote:
> Nice!
> 
>> diff --git a/Documentation/gpu/amdgpu/apu-asic-info-table.csv
>> b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
> ...
>> +Ryzen 3000 series / AMD Ryzen Embedded V1*/R1* with Radeon Vega Gfx,
>> RAVEN/PICASSO, DCN 1.0, 9.1.0, VCN 1.0, 4.1.0
> ...
>> +Ryzen 3000 series / AMD Ryzen Embedded V1*/R1* with Radeon Vega Gfx,
>> RAVEN2, DCN 1.0, 9.2.2, VCN 1.0.1, 4.1.1
> 
> Those similar-but-not-quite lines tend to confuse me :)

I guess it will be easier to visualize this data after build the kernel 
doc since the csv file will became an html table.

Thanks
Siqueira

> Best regards,

