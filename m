Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A473C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jan 2022 10:38:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3630910E2C5;
	Mon, 17 Jan 2022 10:38:10 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E80310E2C5
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jan 2022 10:38:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N90fHT58xpT+bymG3tF4IZgUxDAb7aDDk58A1AxnQd5d2kpxsHsI1RgDZt4Em/itBrBX8AJo8cLzsCGHgf5FIu/LbuJqaqg9kvTGyNzWEVQ24LzNbPIkYltC6egpzsHCrMlbzFnKhDFCZA2NiCoPxejAb0bozO9S1S89r8T8bAerpO+r4iIr0WGZfovSxE+ctAHVKcPniArEm5IAO7BqttguFvMt/W8gZ2PdK3bd7uHCMkgsC70gmiOZ9C05UXhU8k+A+kUSXvwqWAgLAOztpZryaY7rPwA3emMcgeCWyYcTwoH3UvV9bjCNO2vLHyWYIZ1CizK6AZ+oddCy3ig8fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFQLwO+mSI3dF9yQv5031HywnnvhP3SJ9yc9RdCV9Rw=;
 b=newUUMZh86K6Kf40/MiZhxTYyKMb+I7ufhhixpjyRAp5nulagjyzlqM6gIafyEYuFKREEpzQ5r9sbGAWpoRQctMbAAvT6KhGpc2IhdS/pxG7OlnelF4i/RU+Nu5vMrIlCBGJWGyAvC1TpN8tYAovyqY6JXTY5O2Oge146NkLaS6res/Ycyr2ZnC8MPeAS0QoCfm9QUhmO3qD7w0+dXYHi46O1fiLN5fhjzZgPJ3Q47syZrWAgdoAe3lg81qSej649C6pyjc5ryabh2irsfFsi8mNT+jnHQSXLzTryeTP6juVvfkjxrcCHO18qLvggckY22z4H9p410QF0Jol+15lNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFQLwO+mSI3dF9yQv5031HywnnvhP3SJ9yc9RdCV9Rw=;
 b=qlmN/ZiboAFskMFr0l4eHwO4HRla6wwZ0xb8yqY0CPHRT2v9q+YWAXI5nuLEmlKiTLdcSgmukElEcuiP73mTY8D3SeWZCBH15luTpq0OInGHwFnIhUlrlASFXtF8P7f49m0bV/qsqcga+SWLmXkUHKSu3Dzd3niPApdvbTNhbNg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by BY5PR12MB3748.namprd12.prod.outlook.com
 (2603:10b6:a03:1ad::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Mon, 17 Jan
 2022 10:38:05 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::b4d6:f148:3798:6246]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::b4d6:f148:3798:6246%7]) with mapi id 15.20.4888.014; Mon, 17 Jan 2022
 10:38:05 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: add AMDGPURESET uevent on AMD GPU reset
To: "Somalapuram, Amaranath" <asomalap@amd.com>,
 "Somalapuram, Amaranath" <Amaranath.Somalapuram@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220117063343.27896-1-Amaranath.Somalapuram@amd.com>
 <12d7152f-3274-a250-e25e-6144cc9cc1e2@amd.com>
 <DM6PR12MB3897D77C82314BBBDBE8AF93F8579@DM6PR12MB3897.namprd12.prod.outlook.com>
 <5568c4e1-7bc5-cd7f-d6d7-92a4f920c40c@amd.com>
 <DM6PR12MB3897D33226DBA88264B5BBF8F8579@DM6PR12MB3897.namprd12.prod.outlook.com>
 <62372e77-31c8-211f-0d9c-01a0f880badf@amd.com>
 <779d4778-6b85-2769-f169-f5f9e956a671@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <10fe91c4-9078-8937-5dac-0625d38c2ea3@amd.com>
Date: Mon, 17 Jan 2022 11:37:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <779d4778-6b85-2769-f169-f5f9e956a671@amd.com>
Content-Type: multipart/alternative;
 boundary="------------A59A11150ECD45E706590ED3"
Content-Language: en-US
X-ClientProxiedBy: AM4PR05CA0021.eurprd05.prod.outlook.com (2603:10a6:205::34)
 To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 271f8c64-368c-4e52-6fef-08d9d9a571c7
X-MS-TrafficTypeDiagnostic: BY5PR12MB3748:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB37481D3118BA20519AA5945483579@BY5PR12MB3748.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rpKwf376TYZWiIKbeuRLGwKj06cmIIkiWC695A4e2+iOfA2C6512uCaLRLhyzgAFHdV0Ird197R3fLG2f9a7bpbRi0mdA6kzBwT89vB/UH5SoJLFUpJg33XH0WC73P9dHpu/Q8yAvUpKhsDXboXBZCk9MzHCSUsLVS99K/3ABACWtNvbZt+E5moT0RFFj5rmVbmLymA2zmBsf8+T4ssIbWSW/56MCK2SRGIoJkuipJmGf0GWA9YJR5KK9codO/X848UYRlCJHX2t1V1FIZtywlbRe/EjJYamyjXZwcbgbIast+LucloUslYy8iw5ybZYszlYZoTzAjLNIuuKdhxoA4xrDFx+oBBoGJ1mYRhsFE4/GepekjGyGgbMXa85Zba48WxTdNHjGD0vp2NEHQrDoX0NlFIyS5OA74c58Kp4HjS+/rVkGJ+XUtx8J8ftBI4SnsfYStPxl7ej3nYfvefcHufNLukElR2PtsK3yqDjCJvBZKfxOk5IF7lGuIg7VC/SX3AZRAfuarKO4iD4AC6p6WFmIjE+UVwg030EX2JCq0vjE5gydGzo14776+ZujRnMmB4BTobQ4KPEA9bVIAmvXdYuMHJpZaKsvAq/Lyu93umXN6xWpJXmEV3l1HN6nO8bUdVSYV6xXVL8+a7nORbIJXgFD3DwI+ewpAxG9rmKDEkcDStLeUKWJoahm9MPFemckafOBLjmJuY+QfNVPDmX3J7+b0Z0xNyV0ekepvaeHa9BcbmryaQvU8ypiSxwfW6L
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(6666004)(31696002)(508600001)(83380400001)(8936002)(8676002)(33964004)(6506007)(66556008)(66476007)(5660300002)(31686004)(66946007)(86362001)(2616005)(186003)(4326008)(54906003)(316002)(6486002)(6512007)(110136005)(36756003)(2906002)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXdwVGhXdXppeHpwT1dqT25Fck9CekhTdVRDL1FUWUNlMTVrWjNDT2ZKVlJV?=
 =?utf-8?B?b1hEM2c3WkVxOHhpWExxeUFNcVZKSmlLRXlmcTFEYXdiMjkrNW9ZYTRXdFZ5?=
 =?utf-8?B?MmhBY1BBNUdhVGU1dUpIRHBPN0FsSGJ6SmMxbnFweDhkVkpiVkN4emIrNTlE?=
 =?utf-8?B?UnBtRkpCODZtdzVRYmxILzFqMlpJMXhKLzRYUEJsL1I5VG5PZXJqQVQvOG9y?=
 =?utf-8?B?UFc0ekxDMUkxSXJNVkQraTFkZTQrYzRSY2lVb2d0cU05M0p4NFlrdm1vWGxm?=
 =?utf-8?B?VTF1dWZFV3JuYVN2UVRPeEwzQjFMVG9qS0poRDVOdnQ2K0VLaURIZlFrdDE1?=
 =?utf-8?B?WitqUzZGMTl3MlNFL1NGcmR2L21EWkJHMnVHbWl5ZzBBUTZxczhMMlJzWTFy?=
 =?utf-8?B?R0Qra0R3Y1dWdzZDVzEvenRZdVlid2o0a29IVksyaURYRlUxMzJrRTlKVC9X?=
 =?utf-8?B?eTJTR3VkZytTM1VUYkFOODhHVWpmSHpvckRYcVpkYVhlbVgvQ0puUUlpU0RY?=
 =?utf-8?B?TGNEb0lteVJWbDJ2NmlMeER2TkdrYVJYZkVrR3JncWVTelJyNGJIbnpFQlda?=
 =?utf-8?B?ZnFiWGZrNjhGZHZsQUxLWThuSUM4UWlZa0xtUWpZM3lmQnFGeHJtczdrUitr?=
 =?utf-8?B?cDR1NDJJRDhRWDdlY3RKNm1rVTB0YXBYT216OE1tMjgrSWxJT3ZHOUN2SVVN?=
 =?utf-8?B?WG9Dd3YwMnVkc08ydi9tbmVXeEtNOXZySTFTMEErVjNtL3RkVW9YM2FpWnlD?=
 =?utf-8?B?cCtteU5NaW9aSWp4bUlXUVBTN2N2QWZ0VSs3dVFaeGEwNTh4dHh2UnVtWitQ?=
 =?utf-8?B?YlNkb0hmb3J2ZTE4U2dpelBRSGc4ZjhTemx5K2piRitDRjVnSmQ2a0laRnlM?=
 =?utf-8?B?ZGJnL1Zad2JnejdhVmdPSjd5QVAxSEpkUXd5dkdKSTYxQ1R5MzdBZnIvVEVG?=
 =?utf-8?B?QnFJTHNhRm53bC9hb3dFaWgxTndUMG8vdHJpQVA1Zkg0MTkxai95dHIwMXhq?=
 =?utf-8?B?VUh0eklGZUF1cUcyWUo2RUR1M2twMDBRK0F5V2VhOXhyT0g5RHk0UHVFa3VM?=
 =?utf-8?B?S1hqUzNvUlFlUXpLNjQ3dnFucTE3U3NsWklEbHFsMTVHTXNJSWRnRXdWNGFm?=
 =?utf-8?B?V001b1RMdmRMSFFuWUJLUTdrZ213MXBpcGhRN2dsNjgyOEZ1dktrbjVxUm1w?=
 =?utf-8?B?alk2OE5sWHlTWTVWV1Ztemw1eEt0enVRNDNKd091Y0NrUkdxZzI1Q0t5emUz?=
 =?utf-8?B?aDdQVFVlUU91ekczMk8zTXJVS2FsNjM5TzlBalE3eVBWSkNQQU1mYUlRSTI1?=
 =?utf-8?B?YnFqT2hWdS9pSWJ1anBPQXRKcVVLUVlIbXl6YVBrOGlwdXJLQ2JvNFllNXdE?=
 =?utf-8?B?T29iUndYUUloQUdHZTlnaTV6ZDh1S3RLVVNZYjJKOGZHTndDS2g3dTJPbmlW?=
 =?utf-8?B?OFE4K2VGUkZadlhtZjBsZHBHZnYwS01UZWNxMHhCQi9DZ3hlZ1lGUHFURXBI?=
 =?utf-8?B?WVpNZFRUUmIrWkllaWZjOXZSWUJBSDluU09OTThGM01pU3AxVnhpdjdKOW1Z?=
 =?utf-8?B?MmZwSk9Rem9oQnRKTHFiekd2VHJaTXNhWTFFTzdpRXcxYzA3UmZVTkxXUGtz?=
 =?utf-8?B?cHFsNTNFemtjbCtHeDN6Z0Q3QXhGVHBKRVl5WFJoSDQwT05uU1NGUlJyQWdh?=
 =?utf-8?B?V0tnRnYwQWtJamttaGV6RGFySjZlSGZON0JOZWVwb2VKWVNpekdEYjBIT0NT?=
 =?utf-8?B?aG5HeERaZzAxTzkwd3NPYkFwTTJnTjZZRktESWp0MVh5Smltazlsbk9vcVo0?=
 =?utf-8?B?czRzWXpuL2gza1FKUkNjOVo2RWtoTDNGandmb3JSUVdwUTlNd0VNSWhRWUtP?=
 =?utf-8?B?MWI2dTBvMi8yRWkvVUNaeFdFYUF1RUhUcE1lT1k4WFpxeGZjclh1MnQwOGZu?=
 =?utf-8?B?ZzBhYXRFckRyb1JkbS90N2dldFBsMWVWYmdyRkZRKzhmUCtOYWxqZ0JpbU55?=
 =?utf-8?B?UTJHc3V0K0ozL0pJemZtUXd6VFhTY25aWDFuTmRVOXkxWHl6bmdXeC9DclMx?=
 =?utf-8?B?azNrV0tqYXVkaklMS21FTFViVDZYY1R6U3lVK25jL3FBMzg5NDRyMW5TSkNK?=
 =?utf-8?Q?Nc7k=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 271f8c64-368c-4e52-6fef-08d9d9a571c7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 10:38:05.3550 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QNmS8wj6Wu0ADluxLlMt89Jy0Ew9jeUbZx0D/XRQ0cAULPKh5EF3Iz0QWsq6VljF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3748
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Sharma,
 Shashank" <Shashank.Sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------A59A11150ECD45E706590ED3
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 17.01.22 um 11:34 schrieb Somalapuram, Amaranath:
> [SNIP]
> Any suggestion how we can notify user space during this situation. 

Well trace points should work. They use a ring buffer and are specially 
made to work in such situations.

Alternative would be to audit the udev code and allow giving a GFP mask 
to the function to make sure that we don't run into the deadlock.

Another alternative is a debugfs file which just blocks for the next 
reset to happen.

Regards,
Christian.

> Regards,
>
> S.Amarnath
>


--------------A59A11150ECD45E706590ED3
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Am 17.01.22 um 11:34 schrieb Somalapuram, Amaranath:<br>
    <blockquote type="cite" cite="mid:779d4778-6b85-2769-f169-f5f9e956a671@amd.com">
      
      [SNIP]<br>
      Any suggestion how we can notify user space during this situation.
    </blockquote>
    <br>
    Well trace points should work. They use a ring buffer and are
    specially made to work in such situations.<br>
    <br>
    Alternative would be to audit the udev code and allow giving a GFP
    mask to the function to make sure that we don't run into the
    deadlock.<br>
    <br>
    Another alternative is a debugfs file which just blocks for the next
    reset to happen.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite" cite="mid:779d4778-6b85-2769-f169-f5f9e956a671@amd.com">
      <p class="MsoNormal">Regards,</p>
      <p class="MsoNormal">S.Amarnath</p>
    </blockquote>
    <br>
  </body>
</html>

--------------A59A11150ECD45E706590ED3--
