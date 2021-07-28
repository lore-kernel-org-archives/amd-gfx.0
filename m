Return-Path: <SRS0=0Udm=MU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D60C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jul 2021 11:04:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18D7360F46
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jul 2021 11:04:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 18D7360F46
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF9EA6E8D2;
	Wed, 28 Jul 2021 11:04:02 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2072.outbound.protection.outlook.com [40.107.100.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AC826E8D2
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jul 2021 11:04:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HyJR8nuYIcatzYPmhUsboKgo7tfICldmP7PgTKryrzA746ZAY+aWWemEostP1KRSB+L/fFUCU4QRSuxuaesoSLu3Uo2b8EIcCbxwov/1pPqGxk+A+n7ecrUS/swBepPIeToL0GiXyqusIhpsO6D3sFPnNfcKyolCaL2ucfmqzbZqxxkwEGmt+lYM0iZFs0u7egQELmZc5vVmOrKtiHVL7uUpGROQOhiOQ6a4n93IP6SxDmKSxlxTDefwhHjbsGVMSgGPvUKpoyIfcUxucE+cfAE8SLdBKBtOu0i22+eIS7ZmdArOHoVzXbGOIGxBTFVyQvpptu+RF3Xtr7JzF9yZ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4cRhkzvL6rPTWdMniJ4XAGVslRr1Lay9BFOjm37Zd8=;
 b=gOw0p3K5ycVNXBCuUU1QWKjiK7S9e8SaVUom/jx4BRziaVFST1f9S8jdIg7PYNPt2ijsqKYvAA6oES0oWV6NxHve8M2KFM18ww6BcjehKGsYxmHd3qPFVhNWvotLTHIrIoUNdRWZM4XnBlP9A+HIzIEMUyL1cory1W3ChCwlpicDywr/AoxKrGAEwhid8e/iPepKTf0RaieVch43CGKGFQbm30svsMuDjmKl7u5jPcWqEYOD5MmjEvbSj0hjalnST9dN7N9W7mPUB1qAiqL5GRHp31K60NoehVcrXrxLPIbEqOt55cTvIrwGr7AS1MbyTxy+WuprR/ZFc2YzJy/RkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4cRhkzvL6rPTWdMniJ4XAGVslRr1Lay9BFOjm37Zd8=;
 b=qvZaP63wm+7shhTS3zofUn9anKKVHM8eihaS4F34YpngEVvh0kFKjEQJbCrtPtTFzjmdkwDFm+VjatkjldgCY5uBXgHpKc0ECai8g3JmK8Ywd9CM8s7wTCjFDt0VWcBp6Q2LzWhit5XhdHhwBrovenMGrHFGbRHT6p3thWVTK8g=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5356.namprd12.prod.outlook.com (2603:10b6:408:105::23)
 by BN9PR12MB5381.namprd12.prod.outlook.com (2603:10b6:408:102::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Wed, 28 Jul
 2021 11:04:00 +0000
Received: from BN9PR12MB5356.namprd12.prod.outlook.com
 ([fe80::e1cb:9940:1924:50f2]) by BN9PR12MB5356.namprd12.prod.outlook.com
 ([fe80::e1cb:9940:1924:50f2%6]) with mapi id 15.20.4352.031; Wed, 28 Jul 2021
 11:04:00 +0000
Subject: Re: [PATCH] drm/amdgpu: Fix build error reported for some config
To: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
References: <20210727062804.3654932-1-Pratik.Vishwakarma@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <ddd22e40-8720-4fbc-9980-37d7482c338e@amd.com>
Date: Wed, 28 Jul 2021 16:33:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210727062804.3654932-1-Pratik.Vishwakarma@amd.com>
Content-Language: en-US
X-ClientProxiedBy: BMXPR01CA0079.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::19) To BN9PR12MB5356.namprd12.prod.outlook.com
 (2603:10b6:408:105::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 BMXPR01CA0079.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:54::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.18 via Frontend Transport; Wed, 28 Jul 2021 11:03:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2aefbff7-68fb-41e6-ba54-08d951b766f8
X-MS-TrafficTypeDiagnostic: BN9PR12MB5381:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5381ABE586B40D9AB88F620697EA9@BN9PR12MB5381.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:605;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wABE9wlWrPKMnKqKFg2aQZ7WYyqHVAOYLL2RPCcFBTwSH4QC9IhLwRwPJA077oUd2Iizs0hcr31BBTgZPMeKsIZSMmT2SZ0ULveB/ZUJ0gWH3gBdtjHhRcWU7KJyTcKpArhXAvrWy09JYvkkK7nBeoK/OePCc8D4vY/90k3ffqthHNxEfDbizJD5BrGENVHkITiI3Rn37jCSzF4Xr4NiU4WC778gUcOPd2B8Qcv+m7S4lbyJ4+T5tlyC6gp/6A8MAR32kV6pAjq/G6hbfbu21oJC3FF24XnMoZifl7jZvosbtDv3lCe3WMn4GoFio9XBwdOwR8Wh+zUITfzIUMdNilvN/sWnQrOd25RF/3aRPokDB/OWEOKRty/HisShtmMTYLm5xMeaXAtRu17HpOaybixnBtkHJIKPljTZd6iveF/7qXvsKenZ1XgK9C0HrGCWz6M6jsIZUlNfA6ttz1AMyOwPlzXHtT/fJXjbj7XjdS700QZGN/1rqkOkIbXiAT4pzoHv3louU8sOS6ClGL1z4x3wxa6WVFYCg6kONIKWkA/RCM5YBpCMLjXySGITD+NUdRa7iRItJVX1dA53roCqFD3x+Jz6DvTiQMJKhCSteyJzwq5FkYsDz1toaQ4G75X7upQeJSxWXnq062mlUWg7nyTeQRp2CZQC3ftNSJARl1bS/Dr7vmcxJgO+o9coTdaFtVedl5KY74QOpiN2R31fcEP2/8L/HLSkRec4/GPA5jg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(6486002)(2906002)(478600001)(38100700002)(66476007)(8936002)(186003)(26005)(6666004)(53546011)(5660300002)(36756003)(16576012)(86362001)(8676002)(66556008)(2616005)(83380400001)(31686004)(66946007)(956004)(31696002)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnFVbSswMTY4VXdYakdhSGpBVU9pbmY3c3FINUE4Y3c1MUo5anQxUFZOMUxo?=
 =?utf-8?B?eTByTU1QNTZNb0tabW5GSUd0YUhNZGxDNnNlak5TRm95VXlFTVdQekJiOU5O?=
 =?utf-8?B?UlUzd0M1SWlidEJPNjVla3JBR2lwTjZOOHVacU96d1llRmxmZjJFeWFnNlBY?=
 =?utf-8?B?NzhVcjRzZkdKZ0kvTEJsSjdZTCs3Nk96eG1HS09KZTJXZ3M5Q2ttTEdHRHQ5?=
 =?utf-8?B?MUFqOHZtaDBSKzhWTUh1VDV2TUtnNFRha1F4WnplZE5TRW00R0hyUEJ4amNW?=
 =?utf-8?B?Ky9QS0FkbU1JOE1qRG1wdVY4dm9wQ1pYVEtuNFFTSTNWd3JTU2xaRG5DU2pw?=
 =?utf-8?B?WmhGUG5NT1Q0cGVSdjRDbysrb0p3QXh2RG5aK1NaK2NnQnl5d2kvQWdQV0hT?=
 =?utf-8?B?OVdwY1RpRmdzVXJ0dDhwWnpSZkgxbEpSMVlTQ2lJSzhKMTNCK3dOd0kxRGs4?=
 =?utf-8?B?MDlQN0xzcytDdCs2a3JaU1RwKzRLVUFSQkJhcHIvNHhsSWJqdi8vUTBhUTgy?=
 =?utf-8?B?aVRzdTZpalZIRXJlbWFEUTU1eW5Ia1JXamdpMVpRNGlYUFg5c3M0QThLZjUx?=
 =?utf-8?B?L1BHeWxraXlhYStVZGV2bVdDMTdMWjBESXc1QXFRdU1kRERMYUI4dGdubzhx?=
 =?utf-8?B?S241bWw1dWo0SlQ0cm5sUlZWa0k2NjdhU2VZekI5S3Z1ZnN2OGdaeHR0SDlr?=
 =?utf-8?B?SVpaWlZmSHk5NWlLbHhDNFk2SThSZkszRWg2SnBtRXJhVndyTTc1VTVKVnMr?=
 =?utf-8?B?Rm5aWS8wMlhhQmhDZ2p3cmZUbERhWXFaaDFUVy9uMHFobGY1eXhGcFZ0WDZ2?=
 =?utf-8?B?WTFzYmVzNlJOOXpjeGFjcVRHRzBMUUVTS2REMVMrZ1c1Y080WjVDd2FYT0U3?=
 =?utf-8?B?Y2tpQUJURzJqTmFYUnVkQ3FUZW9UYlZjMXVEYUNqTHpuUG1Vcko5eURod2VI?=
 =?utf-8?B?VUlmaTlqSTFBbHIwbWpRZk02Q2FLVEQxRWp5Rng3TkFhSXRGb0NFLzc4Z0I1?=
 =?utf-8?B?ZzNreWRiUURrT0J4SHBSS0lHTjQ1R25wTklhRFIxVWg0UVBnaFk2c09nTWxy?=
 =?utf-8?B?TDk5WS9PRnVlZlR1cDhDM1UyZ1NITUd6THZ4NmJmcXFrVHFhdkFLNGZidFVY?=
 =?utf-8?B?V2hIeHJWMkNWV1IxMC93VDhiWTQrNklPMnJyMUFxY0o2bnM0Y1FsTlQvd1hK?=
 =?utf-8?B?WmJJNk9QOHEwRHluc09rdnNWZkYyOXBxSkwrWHNlZG1yMTZHT1VOSEFwNzhN?=
 =?utf-8?B?aGVGQmtSaThIYU5DNitzQ2FScFY4cUdmbXAzVmpJQ0FSaWpWOU92cGZMSnpY?=
 =?utf-8?B?cHV1b2h2WEpnaStzLzFXZGNlWnNzbjN3OU5NQVUydHVlNkc4TVdIVVpxSXJS?=
 =?utf-8?B?RlA3dUxOMHAwcW9sWm43QkpINlNibk9CVXQ5cVdNQTZJc0xQN21TaFlURmdF?=
 =?utf-8?B?MkE5SEpsdnJzbldBckMvcnJYNGNSSGRUdUZCOFZkYlhhd1h0ZkVtUHJZRWFh?=
 =?utf-8?B?OHRwclN5TERNMDc2a0J2UUFpbW1NT0tsdUx1R3B3NUhnNVdtRlhNeTdialkr?=
 =?utf-8?B?UDV1Tzl5RW1BTHc4OXEvSzJLU0wyTkxiMXVVSkFsbGl3em5aUHBReVQ5WTN4?=
 =?utf-8?B?QzFMWGwzdk1SVmNFMWV5cXFuRUJacHFHL3E5cW56MVp1UFZVL25WSkV2YnBU?=
 =?utf-8?B?Vm1zOVRjTENEanZEM3U2aUhYSGhXZ2xzZFFlOWxoaEZkTW9keXRVdm9uekxX?=
 =?utf-8?Q?83oHIqh63EtFzB0NxGYLrCKmripjI9nGOVrw0ox?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aefbff7-68fb-41e6-ba54-08d951b766f8
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 11:04:00.3354 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Px7YIwluTcQzh5wKb01HcqmTpdFsSt+WIbRytwCazh3sfJPXAHAmBBsMq32WfY4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5381
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UmV2aWV3ZWQtYnk6IExpam8gTGF6YXIgPGxpam8ubGF6YXJAYW1kLmNvbT4KCk9uIDcvMjcvMjAy
MSAxMTo1OCBBTSwgUHJhdGlrIFZpc2h3YWthcm1hIHdyb3RlOgo+IGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9hY3BpLmM6IEluIGZ1bmN0aW9uIOKAmGFtZGdwdV9hY3BpX2lzX3Mw
aXhfYWN0aXZl4oCZOgo+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hY3BpLmM6
MTA0NTozMjogZXJyb3I6IOKAmHBtX3N1c3BlbmRfdGFyZ2V0X3N0YXRl4oCZIHVuZGVjbGFyZWQg
KGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKQo+ICAgMTA0NSB8ICAgICAgICAgICAgICAgICAg
ICAgICAgIHJldHVybiBwbV9zdXNwZW5kX3RhcmdldF9zdGF0ZSA9PSBQTV9TVVNQRU5EX1RPX0lE
TEU7Cj4gICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+Cj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FjcGkuYzox
MDQ1OjMyOiBub3RlOiBlYWNoIHVuZGVjbGFyZWQgaWRlbnRpZmllciBpcyByZXBvcnRlZCBvbmx5
IG9uY2UgZm9yIGVhY2ggZnVuY3Rpb24gaXQgYXBwZWFycyBpbgo+ICAgIENDIFtNXSAgZHJpdmVy
cy9tZWRpYS91c2IvZHZiLXVzYi9ub3ZhLXQtdXNiMi5vCj4gICAgQ0MgW01dICBkcml2ZXJzL3Vz
Yi9nYWRnZXQvbGVnYWN5L2F1ZGlvLm8KPiAgICBDQyBbTV0gIGRyaXZlcnMvbmV0L2V0aGVybmV0
L2ludGVsL2lnYy9pZ2NfdHNuLm8KPiAgICBDQyBbTV0gIG5ldC9tYWM4MDIxMS9tbG1lLm8KPiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYWNwaS5jOjEwNDU6NTk6IGVycm9yOiDi
gJhQTV9TVVNQRU5EX1RPX0lETEXigJkgdW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVu
Y3Rpb24pCj4gICAxMDQ1IHwgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHBtX3N1c3Bl
bmRfdGFyZ2V0X3N0YXRlID09IFBNX1NVU1BFTkRfVE9fSURMRTsKPiAgICAgICAgfCAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+
fn5+fn5+fn5+fn5+Cj4gICAgQ0MgW01dICBkcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl9z
b3VyY2VzaW5rLm8KPiBtYWtlWzRdOiAqKiogW3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6MjcyOiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYWNwaS5vXSBFcnJvciAxCj4gbWFrZVsz
XTogKioqIFtzY3JpcHRzL01ha2VmaWxlLmJ1aWxkOjUxNTogZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHVdIEVycm9yIDIKPiAKPiBDaGVjayBpZiBQTV9TTEVFUCBhbmQgU1VTUEVORCBhcmUgc3Vw
cG9ydGVkLgo+IAo+IEZpeGVzOiA2OWU4MWRiMzM3YzEgZHJtL2FtZGdwdTogQ2hlY2sgcG1vcHMg
Zm9yIGRlc2lyZWQgc3VzcGVuZCBzdGF0ZQo+IFNpZ25lZC1vZmYtYnk6IFByYXRpayBWaXNod2Fr
YXJtYSA8UHJhdGlrLlZpc2h3YWthcm1hQGFtZC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfYWNwaS5jIHwgMiArKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfYWNwaS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FjcGku
Ywo+IGluZGV4IDBjMjgxYzdmNWNlYS4uNGMxZjJhYzYxZjlhIDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hY3BpLmMKPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfYWNwaS5jCj4gQEAgLTEwNDAsMTAgKzEwNDAsMTIgQEAgdm9p
ZCBhbWRncHVfYWNwaV9kZXRlY3Qodm9pZCkKPiAgIGJvb2wgYW1kZ3B1X2FjcGlfaXNfczBpeF9h
Y3RpdmUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gICB7Cj4gICAjaWYgZGVmaW5lZChD
T05GSUdfQU1EX1BNQykgfHwgZGVmaW5lZChDT05GSUdfQU1EX1BNQ19NT0RVTEUpCj4gKyNpZiBJ
U19FTkFCTEVEKENPTkZJR19TVVNQRU5EKSAmJiBJU19FTkFCTEVEKENPTkZJR19QTV9TTEVFUCkK
PiAgIAlpZiAoYWNwaV9nYmxfRkFEVC5mbGFncyAmIEFDUElfRkFEVF9MT1dfUE9XRVJfUzApIHsK
PiAgIAkJaWYgKGFkZXYtPmZsYWdzICYgQU1EX0lTX0FQVSkKPiAgIAkJCXJldHVybiBwbV9zdXNw
ZW5kX3RhcmdldF9zdGF0ZSA9PSBQTV9TVVNQRU5EX1RPX0lETEU7Cj4gICAJfQo+ICsjZW5kaWYK
PiAgICNlbmRpZgo+ICAgCXJldHVybiBmYWxzZTsKPiAgIH0KPiAKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
