Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4753C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jun 2022 12:40:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0805810E143;
	Wed,  1 Jun 2022 12:40:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66BBE10E143
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jun 2022 12:40:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAbxmH4pVuAUuujSo5gdJML4ryZS6u6CCdmv/jUaZCBlIdiMo3gPIRUAiPWhUfEVILb7R2mxZ/kqyzE964RV+YIzJP/MJkR2GB3UH63csrLJGdXq32BhMGmMU8J2jH1pb6Ut7b6r7C1xrrGquWH3i9okvoL2EGM8Qg3VT+rYDYtmTGFcBGe22p6vdPmAAkx9mTSS0FftR/TC0qKeLA9tIEsZPYiu4L1nwLEfTn7F22yBxOLxE88y+eKkJ02tFcTpCmKYWdSnOU07eKGq8vnPMwShLaOx3YINYcvJ+20UeN7eQ9DCcJE6FeunD1e5aoeY/60SU5tJKztUi8LKzNL9wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2TosPUuIK4n71LCeslD1aMmLFmodjlYNkiifKhgprw=;
 b=B+iU08KkXrylXvmvQ1OFMMv5oRvLoWv+cGH0bPRjsUxOAaQ74XdeJu5QhX9oqd7KCS1ezrGZ4+9WTiddnJUmiho5XuzoY0XXsD+4Iwu4nCS/ybb4n5OW3E/OSKt5CMSWTDhj+es0BGuEJJXqZxG8Ua1Sp72gGXcelt2tuWqkkdbh1V0zBbbC3wjy3QULPaVoOEZ9l5mw0bzJnhcEEUZsUoe52nvKoDWx2PTqWb5NMIyaCFf6ABENn4FyerqlIO8GZmdc51kTj8gWrXJmsSgHuGI2LUUPMix9dLr5wg4xoXbYIw2YUGgFpztabXRYSx8Ab5V9rYZhcaCvZe33gJL/Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2TosPUuIK4n71LCeslD1aMmLFmodjlYNkiifKhgprw=;
 b=iC15bd3tcmgFEdWGsmjEWRiUr6u1OsRaRQn9Ua6yhesuTo9Poviemm1UqpPtWOhh8BknV9np6IuxeI6bKs4YBi3b69ctmp1DMEINF40XLhSX0wm1mlM8NGJXcECa2BpPSbsn9eRvXxgggQN+YS1OW7URBM4y+q+qzvbR+J6zRCQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM5PR12MB1130.namprd12.prod.outlook.com (2603:10b6:3:75::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.18; Wed, 1 Jun
 2022 12:40:30 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03%4]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 12:40:29 +0000
Message-ID: <293d9f72-c3e5-913d-08d1-0a8591299c46@amd.com>
Date: Wed, 1 Jun 2022 14:40:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 "Olsak, Marek" <Marek.Olsak@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Subject: Explicit VM updates
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0248.eurprd06.prod.outlook.com
 (2603:10a6:20b:45f::18) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c23e8dd2-3699-4dc8-cfaf-08da43cbe920
X-MS-TrafficTypeDiagnostic: DM5PR12MB1130:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB113063ACF69B0F1F39F4B5F183DF9@DM5PR12MB1130.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vDQuvjONK65pdMkTZ+KNNMCZAUNa1/jAXix2eZDoNuWsfA2M9blrDwocfxDXMJGOZu+FCh9zix78YghDehKHIKduF4sNwdPLHtGr35ajzFWwu1J9Hrm7t4ufHf7PIyaPtzIySnGcdIRxJOYHh4Tfjs6HuAgXjZS+TwY2LVKOU++ZwgkEM7H92l7A2tx4h2Ig7z1B8AsaXol9ysGJ+XzI24IfD28Ev4yuFJ1GeWrvXB+zeK/o62g49phobu0jJwj6CFTjKsOVllXgXWYeQSN+bNmaxMWsjJItSCQxZMSeXiwCLEgzpo8SFHKhOjyDBsmibLKspjWBOYcQqwK5RIoy0amCZAsqe0t+3fy+5bn2ZI0qS5LtLIuvf9u9vGf1sqi7f8esQ8jAndA/iH4v7yF3YOFeuthZoIQzVhv5ccDbNiudfhloVu4V3KTlvKbRUI9c8lV8Oh7gIkj1f7uZv0dFOxqq1hHM5phfjtSvih5BUAv8VZHH2o8y6257SKLRVPdvTMcxBkEiIIgOI3oeJLLle54CVXc8GtqhbIvnJNNGxREirpE+nQ2j6dvgCko5BGnd/8wu+18d1RWCNxRVjCmEFAn8Pd5p8ayEkGyI6wGON7GxXNlz/2uOj1sFj2v3+Phf8q6rpuenm5UZGNPd0yfJrvZRVZ4ZCeE8tlQEeUjSL0yhZKcppGuFiSWxRnVmSqfrHMfzG7J3TP96idywwMTtrNGSm3UyZhl2i0Od9ZcTFoC9Gk3gzdFPp6tQBfcaDxaB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(6636002)(38100700002)(2616005)(31686004)(36756003)(316002)(26005)(3480700007)(6512007)(110136005)(186003)(5660300002)(31696002)(7116003)(6506007)(86362001)(66946007)(4326008)(8676002)(66476007)(66556008)(83380400001)(6666004)(8936002)(508600001)(15650500001)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWdpZ3pkTjZnRVZObnh0akpoMlpRS2Z5OWJBaXJ4d2ZoYUcrYkwvQnI4Qk92?=
 =?utf-8?B?M1p3ZTYvNDJkOEVnSllqWmJ1M1YranFuM2x2UjV0Unk3QlhaN1JSOGgvalF1?=
 =?utf-8?B?RXZ1d281eUpiVDZGWnU0L0hjakQ0c08zNlNUWStmVU9EU1JKcmtYWnJxSGIw?=
 =?utf-8?B?UXVYSVhXQ0pRZFNOV0hjd0EwblVaenFnSzlOT0NmK2NJbld1bHh0RElsdzdN?=
 =?utf-8?B?TkJFajlWWTVlVFdxNDBOb1hpbVAvSGM2a0EvamxldnUwT054SkFuUTdYYTgv?=
 =?utf-8?B?RGRDWVJpbTVZWm9aZ3NoOEI2Z0dhSVdPdjJSSHJPdkFPd1hXSEN2Y05KVmhs?=
 =?utf-8?B?YzBTS2xXTTZqZi9WWDVZSW5UMkV1VWF2NVZtdEgzb1BpQzZVT3pwa3BtNUJN?=
 =?utf-8?B?UDAxN1puYXBiWkNueHNMN25aUUp4M0J1Vm9xZytqSVNWV1V1d1lpT01QVVdU?=
 =?utf-8?B?dmNHenI3V0swZENwZ2xwVXowMzVGZ3cwc1hscGVYYzhnRVVjZW9zaGJoTU1q?=
 =?utf-8?B?STBUUkdDVDFsNlVPSUVwL3k2em9ldGdRMDV1c2s2RloxOWthSlphZldBeHVT?=
 =?utf-8?B?UGlYQW1oYWFYUDEzdkRQVFE3Yk9xWjBBVlcvV2UyeHVJME5MZ0FkN3J1ZEFp?=
 =?utf-8?B?d2luVVZIWVhYZjhjWXpkSnl3S05MYnhtYXc4NlluWHYwMlRIYUNIRjh5Zlpl?=
 =?utf-8?B?N3pSY3VqZXZtZmdZMzRxOTFDbUh1YVY2bHlScENCcVdSRTRpR1pEeTRYVjkw?=
 =?utf-8?B?SGtxYldiVDZZQU0xNmVPbkdQQXpFM1Zza3BmeFZpN3R6elRzZ3JmVk5ja1k5?=
 =?utf-8?B?N29aRklEZnB0b1EzRnY0MUoxdndCYkNSNG1nMWFOOW1zdjBzSDJMMWdWS0s1?=
 =?utf-8?B?Z2xIby9UMmNPUzBGWFYreDlodXVnSkJ6S0pWN0c0UjJVaGRxTW9jc2RodzlY?=
 =?utf-8?B?aWtVcklnMVIzb3Q1a2lhUXN1c2VqN2FITllIc2o2WkpVQVJXTVY5bC95Rk5R?=
 =?utf-8?B?NzFGOTBKM1hUUFNzM3Ivb082cmlsNVZVT0JCVS9qV0FwM29UN1VxeTM4TWVX?=
 =?utf-8?B?WGFDREI1S1prazdzQmRZdjhrY3RZWmZwOHlNbkpkdmZWZmhzaEpWQjlTc05V?=
 =?utf-8?B?Tm11eSs3MVMwaGRqUW92UEptbGZqbHRwY2NPdEVuVElDSHNobURUK2Y4TGxm?=
 =?utf-8?B?RkpvMFczci82MkpUNlp2YVdoRzMvN0NkSFk2VG5zUkJ3TmhBMkQraXRJZnhU?=
 =?utf-8?B?VzIvT1N1YmJTekpLdC9LWEE5WWJmVnl3TXdKWWpTTkppY3J6OHpQNFlKY0V6?=
 =?utf-8?B?S0ZYNlNaOFcvcG1uZURWSThCcFZZcWFlbkYwekhJbWh6MFYvQjVheEtqWmt3?=
 =?utf-8?B?R3g1MzVxNVZnNXgrZVo0VTVPaW4xaE04MHZJN095L1BYL0hTUzhUOStBUXIz?=
 =?utf-8?B?ZzlZTEtqRU1ESk03aDdTdXJLRnlXaTRyWWtxZEU3bkxFbldNbW9nOXFROVRP?=
 =?utf-8?B?cXVFR1FObDZSSHUrbUU5eWJiMklsV0o2cHhxYVFNSUNFbnVLZzBtSzhBS0Mx?=
 =?utf-8?B?TUhiZC9FNGdFUEtjNnRhMVpMK0d5TUc2cVMwRi9jTmpGbjM4UWhzOWl5NkZV?=
 =?utf-8?B?N3hWRVZTV01pZkZuTUVWYVlHMjQ5Y2F6U0dHdDRBbGZZbS95ekQ0TTVDTzYx?=
 =?utf-8?B?MVZ6QlRpajVBVXVENUsrSkE0dmhJbmJuR3JTd29Xcy9NZm9CeXdxMmNvY2dB?=
 =?utf-8?B?U1FNL3RXaldkYjZmZ0RzV3RlZ2xBQncreTdVSlRsZFBSWU4vUTJqdzVGU0tW?=
 =?utf-8?B?NVJvWGpqTTNDZVU0ODAwS2hJUFRUUlRDM2hwZU4zeVlMVUMvZ2tXTlNDS2Rl?=
 =?utf-8?B?c0hIS0VwaE9UM1l4VE1rU0JHVUYwUXZIZ3VnbGlNYjVkT3BnRVRFaHdrLzF3?=
 =?utf-8?B?RHRIVUd0M1pnSVh2NVQxeXhUQ085TVFwNFQ5TDcwMDZaU0VGeUFETW9yc01J?=
 =?utf-8?B?TU5yQkR6MlI0WHM0RXJmb0UzajZYM2Mxd01IQkg5SjlXOGVmRndLeVFoTjVO?=
 =?utf-8?B?Ukt0d0tkY2lHYXVhUFd4aGI4ZjRVOVRmWHJ0TG5RMExlVi8wME9PejFzTnFU?=
 =?utf-8?B?UXFGUnNRbDVDQklDektzdjdNa3Q3ZEdGT0paT1RERHBjVTg2MzhBWi92eWVy?=
 =?utf-8?B?eFBRU2QzZkNSdUFLT1hTd2V1NlM4V1R3VlU0emJ3UkFHY2pSaDBBSFdXRlUr?=
 =?utf-8?B?TThvWHl5TG1jaUpWeU1pT05MMDNnY3NRaXUwVEt6bkRFNEI3U2U1dE80TWlD?=
 =?utf-8?B?U1hvVktKcU1Xc3dWcUJhZnBQU2hFOC9Tc3ovVFJFZ3BBTmQ2RXJOdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c23e8dd2-3699-4dc8-cfaf-08da43cbe920
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 12:40:29.7041 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9tXXGe0w/PhddsMjlueYdrp7FwR2BxVW9JRSCATFaFK1e077f7iMqU+FRuKcAi8f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1130
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hey guys,

so today Bas came up with a new requirement regarding the explicit 
synchronization to VM updates and a bunch of prototype patches.

I've been thinking about that stuff for quite some time before, but to 
be honest it's one of the most trickiest parts of the driver.

So my current thinking is that we could potentially handle those 
requirements like this:

1. We add some new EXPLICIT flag to context (or CS?) and VM IOCTL. This 
way we either get the new behavior for the whole CS+VM or the old one, 
but never both mixed.

2. When memory is unmapped we keep around the last unmap operation 
inside the bo_va.

3. When memory is freed we add all the CS fences which could access that 
memory + the last unmap operation as BOOKKEEP fences to the BO and as 
mandatory sync fence to the VM.

Memory freed either because of an eviction or because of userspace 
closing the handle will be seen as a combination of unmap+free.


The result is the following semantic for userspace to avoid implicit 
synchronization as much as possible:

1. When you allocate and map memory it is mandatory to either wait for 
the mapping operation to complete or to add it as dependency for your CS.
     If this isn't followed the application will run into CS faults 
(that's what we pretty much already implemented).

2. When memory is freed you must unmap that memory first and then wait 
for this unmap operation to complete before freeing the memory.
     If this isn't followed the kernel will add a forcefully wait to the 
next CS to block until the unmap is completed.

3. All VM operations requested by userspace will still be executed in 
order, e.g. we can't run unmap + map in parallel or something like this.

Is that something you guys can live with? As far as I can see it should 
give you the maximum freedom possible, but is still doable.

Regards,
Christian.
