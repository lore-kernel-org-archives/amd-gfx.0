Return-Path: <SRS0=uLL/=J3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0664C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 22:32:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79A1761209
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 22:32:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79A1761209
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EE746F5F8;
	Fri, 30 Apr 2021 22:32:37 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2D376F5F8
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Apr 2021 22:32:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BguM9t4CTIsnN2qhxV6QT6SyXa+rp0VjAbpaoSwvMdf8N0IfYegYFuxA7NFimFTwkKLe0Hz+5qgjjpywaiAbKI7+RAG7jTw+tBcGdnVTxsbtH5hoP6DkeFXkiAr3tYLFXb78+cNLjSvEyM9rlQ6GIu8N2GktQ44J9RCwyYI0lqa1zzFy9U5fevREw5BxmxtY+CyinIMlN7Q0aDh7pKKEv9oMGZq1ONYQAwLIpuKpJ47EviJJt84s+Vh+iCJ5aYsPl7zOBXgVX67y7EzClKflIYwqbpR5s3j5YmwoRlUWY3oNGoD7xJbCloMAatSwRdILTxxz4LqfGSD89g+evP7fbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcJix/D/TT9DXDehI7wM4E+lBkptgo3ffUGPUwHZLJI=;
 b=ZVmVJwvnXq6EzWNZvqU19GxHQV+2x3MdVRHvMkE6Z1FueOUWv0FyEvtx8GV+QI1P0o7SbJPALi43jLWi6hcqnmdvmFY+HuPugJuRhwM/tMOpjnvWQaXCd3EoWVM+gpGiLnHxmulWk3Y9+cMoKa3XS53oscyrqMgT8Dsn0+q4wyJvIGJntPECh7kQnxXWsf2fQ5etAbpIc6nmNPoIYFAVjxdbuS3Razg43iZl/RyF9infdVE99+UBKJdDqSaSXfwfir9rziHrSHZUMVKNsbfYFbIB5VOy3U7rEc454IJcEdusSt9PScyyEifyWf6Pp5Rj8T2NtQozyBi4B5ks8wubhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcJix/D/TT9DXDehI7wM4E+lBkptgo3ffUGPUwHZLJI=;
 b=WMenjt/9dvlxFwYI21z0UGYtvFjprKCvRfegnNyrrZPz+vGdgrsibI+RSMvqVOyF3fXP5JuOKCTp6Xyq8t62/rc8cQtrrdXvfGStQ0uvAYN6t+M+chlRMkDpUXMn2pzpoZZWLD1yKzbsqvdhYSQ9prJUOn7T0vPu0Rl4eSvOR4U=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by BL0PR12MB2449.namprd12.prod.outlook.com (2603:10b6:207:40::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Fri, 30 Apr
 2021 22:32:33 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%5]) with mapi id 15.20.4065.027; Fri, 30 Apr 2021
 22:32:33 +0000
Subject: Re: [PATCH] drm/amdkfd: fix incorrect condition check for pci atomics
 gpu flags
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210430205111.72778-1-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <1e2555aa-e27f-5fcf-0627-a565d0b46d79@amd.com>
Date: Fri, 30 Apr 2021 18:32:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210430205111.72778-1-jonathan.kim@amd.com>
Content-Language: en-US
X-Originating-IP: [142.182.183.69]
X-ClientProxiedBy: YTOPR0101CA0011.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::24) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.182.183.69) by
 YTOPR0101CA0011.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24 via Frontend
 Transport; Fri, 30 Apr 2021 22:32:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2723aff7-9f8f-4524-ed53-08d90c27d8e4
X-MS-TrafficTypeDiagnostic: BL0PR12MB2449:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB24499ED1063635B836210F91925E9@BL0PR12MB2449.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +HbbbkeOI8dkwxZiiZ99d5DFxRo/2uJuanR3OMI2CMUkXtsGvpxu1ZH3KWp0dW/dEmujIsLytXhdulna4Fp6ynuB4xOoR/afy8Ona7VXJu85qXRgw44pHgWD8UuEyiuHo1kCt43ALwTL6PM5BojAUgS9N/I8hxcTOaEuIsYDciI72ddKksauP0s/ohpXFrU7oc/eiIafCpEvBN8mTyCMuQbXcLu/sFmmeYdeg+GplkI//Cn6j//CjpbRTr6Vl3cSKaE3/bFWU3N0aT4mEE65dowrySx4Utx/wICVmM93ln8syX/Gpph4ChVqnCQoPefJwqJZplr4Rs5nWZP7KEKOIJipsm0djfipdLwLvs15Nv5xkadtypkCiXijb1y9zTM8WkmG/S9xGGVmqrmtlinPol7PBrDJBN6G5wNbA0iEm9Pd76w6Tr3FrFWlfnNGn0bwp+72gHPWinphmIfSu6cN63bRwzqPelV7FWslhJuA1is75hVovblj+ZnA+PSjEOWbDziu3bSaz5gDyM5vok6GMxgeRjK4mcjpYKZeMeMeMSuDmXkvKI2ApAIqlftf+R8Sg01TX4yj8mOyyF+7sucto5NFvs8EmlgbmMElmOKR5s8Nec1TYnrdTxerPpK6EQSsZAItXbUYitLZ9Kn/aijf2+isfHuCd7KkAYieqbFApQVqr25hl3UEvGi7Z7e5OMNn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(366004)(346002)(39860400002)(2906002)(6486002)(86362001)(186003)(38100700002)(956004)(31686004)(4326008)(66946007)(5660300002)(8676002)(44832011)(66476007)(66556008)(2616005)(478600001)(83380400001)(16526019)(26005)(8936002)(31696002)(316002)(36756003)(16576012)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UDdqZ1k3NHNEYmxUYzd5YUR2bEVXcGp6RExxWnVWWS9mbjFEMDg1NlQ1SmVw?=
 =?utf-8?B?UUNldzF2WWpuNVEwRTBYNnlVM0hKMUsxVFRFSXlVVzBvVlQ5Q2gwQitPbXls?=
 =?utf-8?B?L2VEaTA1SFpTR2FlV0dsS0RuVGhTTXlTWUtwVFVMVE1zQmpSRWV6M0xBZWJi?=
 =?utf-8?B?STFmcDBqRXppZVZKVFlJQVk4VnZZazlvelBBZHlFYlc5U2VibXFXemhwd0N3?=
 =?utf-8?B?dDJyYW9tOVA5RGpyZWFXZ2ZEeHdGSElTeVdNYjRKL1lMblhMWFl4TDZhY28w?=
 =?utf-8?B?b2lqL1hKb0pMUld5aWlBcmowUHp6Y1gzNlZFNjcwcTArV0V6bmxOdzZIK3Q2?=
 =?utf-8?B?dmRtL1pLS2xNUkxmODlyNXZ2bVZYd2l5VmFjTVRYTDBvSVk2REw4MHF2UXg4?=
 =?utf-8?B?SDB1aFIrMEFYTXJCTStZbDBuQ3d0YVhRUHRXWGhiMk5Pck9DRVB5QkcrWDl6?=
 =?utf-8?B?M2hrNFJlOVZNSnpQKzR6aW1CcW1kWksrZnBQc2FJOSttOXc1VEhGbUlmN29V?=
 =?utf-8?B?R00ycTZxWkdiUWdaMGJySkpYZ3RmYUNLTEZyLyt1QU1UbDJBd1FYNVVrc2Mr?=
 =?utf-8?B?WnpPVU5XRk1SNU5tZFlueUJDS0FJQjd3a2RHVlhHL25MRnI5M3hEZzY0OGhQ?=
 =?utf-8?B?NWtuWXRIdHlWRnMwcm9KbFk3cDBlRFdGVzVzdjA2NnRPWEZ4YzMvV25MRW9v?=
 =?utf-8?B?N2luTWtYUXRFZkFqOEZpbCtmcDZpN1MvdG1veG5VSEd1bmh1dE9pdXdjbHFw?=
 =?utf-8?B?UlNyTzNoTE5YUENycnNWUG14Qys1dk96NHdsZk0wVG5SOUlySkRJWVd5ZFRE?=
 =?utf-8?B?TmZLaWlRTC9nK0MxbWtleUFqOGhWTFRpV1B1My9GcXV4aC9mTGN6bEhkd1JP?=
 =?utf-8?B?d1pMUHdWc1RpTHNnN0kzRzVSY2pwUWtNbGlYa2R4VFFEM09CZDFYRWlzT3dD?=
 =?utf-8?B?RHVBbHp4akpZM2txeWlDYldXMDNNQmFqeTEzcjhGOVJQNE1OK1B6ZElVU0tO?=
 =?utf-8?B?Tk1HY09Zb1pGRlVicXpvQldmZVVXcm9JQlhLRWV3cmxiS0VXSlJ0WkpUSVc4?=
 =?utf-8?B?SVNMWFF0Qmp0Qm9STnRqR3RwVzZZQVFiekpscjBXMDZkbkxDQ3pJbVUwTjFi?=
 =?utf-8?B?UzdPRk91ZkVBTlBXZ21Bei92YWVzS24vS3Zlb3JXdTlPSVdiYU4zVTQ4L2U1?=
 =?utf-8?B?NjRQY3ZuOWlwNjVwVml3QlZvWVdEQ05ZMXo1WEVkd2dEZURLYkhQcUxjQTNX?=
 =?utf-8?B?bW5lbFhHcXVWYy9DTXJjK3d2cmlXWkwvOFlWOXpYUUl3cWh4VFN2VlpBRlRR?=
 =?utf-8?B?aG9HRjFpMmQvUUxuU3V4OW5rQnltODdKbEIwWWc5eU5FSDdwQnNpK1ZKYmpo?=
 =?utf-8?B?NW9sbkVDK25KOHBGN2ZmTXpRWFZ0QTg2ZDB2WjhwK0NUdEFTWGxtczN6bWlq?=
 =?utf-8?B?Q1ZlRUh5Q0VqcktCa05JZjFPdEtaTmhpU3h4blVaZTczdmFHQjdadEJtWHVL?=
 =?utf-8?B?T0J1VURHeGl1QVdFbm1YeEhYMEo5dWU4aldtbDFNbUs0ZVFzdG5BbmRDVG1O?=
 =?utf-8?B?YW0wbVZkR2cxWGZVV1JZd0FCOWN6VUY5aXB5Z0NlS2xVdGk1K0FLSzhSdWk3?=
 =?utf-8?B?OWxjZFNmL05aMXJCN3V2SW94UjdQL3VMb2lKaEFBNTBvTXZoTmg4VzMyV250?=
 =?utf-8?B?cnMxbGxUWUFqVXU1VHZhd1NSTVFZaEFOL0UvQWNnbUl1dEg3SkFURzFoVlNU?=
 =?utf-8?Q?+0ot0pA0VyHOyzQXkfE3O+tTce7bkeiCze3nWVW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2723aff7-9f8f-4524-ed53-08d90c27d8e4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 22:32:33.3149 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PymkHIMvTjOQWrBXF/5ojLnZ6lAYzvbgFekXQCTYIdjm9+qGzQvqknL+EhcKxvXAqyGQjssI6NOTOzdzpN+rzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2449
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
Cc: Oak.Zeng@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAyMS0wNC0zMCB1bSA0OjUxIHAubS4gc2NocmllYiBKb25hdGhhbiBLaW06Cj4gQXMgcGNp
X2F0b21pY3NfZGV2aWNlX3RvX3Jvb3QgY2hlY2sgaXMgYSBob3N0IHRvIGRldmljZSBzdXBwb3J0
IGNoZWNrLAo+IHRoZSBkZXZpY2UgeGdtaSBoaXZlIHNldHVwIHN0YXR1cyBpcyBpcnJlbGV2YW50
IHRvIHNldHRpbmcgdGhlIE5PX0FUT01JQ1MKPiBncHUgZmxhZ3Mgc28gbW92ZSBpdCB1bmRlciB0
aGUgY29ycmVjdCBob3N0LWRldmljZSBjaGVjayBjb25kaXRpb24uCgpJIHRoaW5rIHRoYXQncyBz
dGlsbCBub3QgcXVpdGUgY29ycmVjdC4gVGhlIGZsYWcgaXMgYXBwbGllZCB0byBhbGwKZGlyZWN0
IG91dGdvaW5nIGxpbmtzIGZyb20gdGhlIEdQVS4gVGhhdCBpbmNsdWRlcyB0aGUgbGluayB0byB0
aGUgQ1BVCmFuZCB0aGUgbGlua3MgdG8gb3RoZXIgR1BVcyBpbiB0aGUgWEdNSSBoaXZlLiBUZWNo
bmljYWxseSB3ZSBtYXkgd2FudApkaWZmZXJlbnQgZmxhZ3MgZm9yIGRpZmZlcmVudCB0eXBlcyBv
ZiBsaW5rcy4KCkkgdGhpbmsgdGhpcyB3aG9sZSBmdW5jdGlvbiBpcyBqdXN0IGNvbXBsZXRlbHkg
YnJva2VuIGZvciBzeXN0ZW1zIHdpdGgKWEdNSSBiZWNhdXNlIGl0IGRvZXNuJ3QgbWFrZSB0aGF0
IGRpc3RpbmN0aW9uLgoKTWF5YmUgaW5zdGVhZCBvZiBsb29raW5nIGF0IGFkZXYtPmdtYy54Z21p
LmNvbm5lY3RlZF90b19jcHUsIGxvb2sgYXQKbGluay0+aW9saW5rX3R5cGUgaW5zaWRlIHRoZSBs
b29wLiBJZiBpdCdzIENSQVRfSU9MSU5LX1RZUEVfUENJRVhQUkVTUywKeW91IGFwcGx5IHRoZSBO
T19BVE9NSUMgZmxhZ3MgYXMgYXBwcm9wcmlhdGUuIElmIGl0J3MKQ1JBVF9JT0xJTktfVFlQRV9Y
R01JLCB5b3UgY2FuIHNraXAgaXQsIGJlY2F1c2UgWEdNSSBpcyBhc3N1bWVkIHRvCmFsd2F5cyBz
dXBwb3J0IGF0b21pY3MuIFRoaXMgd291bGQgZml4IEErQSBhcyB3ZWxsIGFzIG5vcm1hbCBYR01J
CmJldHdlZW4gR1BVcyBhdCBvbmNlLgoKUmVnYXJkcywKwqAgRmVsaXgKCgo+Cj4gU2lnbmVkLW9m
Zi1ieTogSm9uYXRoYW4gS2ltIDxqb25hdGhhbi5raW1AYW1kLmNvbT4KPiAtLS0KPiAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3RvcG9sb2d5LmMgfCAyIC0tCj4gIDEgZmlsZSBjaGFu
Z2VkLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1ka2ZkL2tmZF90b3BvbG9neS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Rv
cG9sb2d5LmMKPiBpbmRleCAzMDQzMGFlZmNmYzcuLmM4NGRiNjQ0MWM0ZSAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfdG9wb2xvZ3kuYwo+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF90b3BvbG9neS5jCj4gQEAgLTEyMDYsMjMgKzEyMDYs
MjEgQEAgc3RhdGljIHZvaWQga2ZkX2ZpbGxfaW9saW5rX25vbl9jcmF0X2luZm8oc3RydWN0IGtm
ZF90b3BvbG9neV9kZXZpY2UgKmRldikKPiAgCj4gIAlhZGV2ID0gKHN0cnVjdCBhbWRncHVfZGV2
aWNlICopKGRldi0+Z3B1LT5rZ2QpOwo+ICAJaWYgKCFhZGV2LT5nbWMueGdtaS5jb25uZWN0ZWRf
dG9fY3B1KSB7Cj4gIAkJcGNpZV9jYXBhYmlsaXR5X3JlYWRfZHdvcmQoZGV2LT5ncHUtPnBkZXYs
Cj4gIAkJCQlQQ0lfRVhQX0RFVkNBUDIsICZjYXApOwo+ICAKPiAgCQlpZiAoIShjYXAgJiAoUENJ
X0VYUF9ERVZDQVAyX0FUT01JQ19DT01QMzIgfAo+ICAJCQkgICAgIFBDSV9FWFBfREVWQ0FQMl9B
VE9NSUNfQ09NUDY0KSkpCj4gIAkJCWNwdV9mbGFnIHw9IENSQVRfSU9MSU5LX0ZMQUdTX05PX0FU
T01JQ1NfMzJfQklUIHwKPiAgCQkJCUNSQVRfSU9MSU5LX0ZMQUdTX05PX0FUT01JQ1NfNjRfQklU
Owo+IC0JfQo+ICAKPiAtCWlmICghYWRldi0+Z21jLnhnbWkubnVtX3BoeXNpY2FsX25vZGVzKSB7
Cj4gIAkJaWYgKCFkZXYtPmdwdS0+cGNpX2F0b21pY19yZXF1ZXN0ZWQgfHwKPiAgCQkJCWRldi0+
Z3B1LT5kZXZpY2VfaW5mby0+YXNpY19mYW1pbHkgPT0KPiAgCQkJCQkJCUNISVBfSEFXQUlJKQo+
ICAJCQlmbGFnIHw9IENSQVRfSU9MSU5LX0ZMQUdTX05PX0FUT01JQ1NfMzJfQklUIHwKPiAgCQkJ
CUNSQVRfSU9MSU5LX0ZMQUdTX05PX0FUT01JQ1NfNjRfQklUOwo+ICAJfQo+ICAKPiAgCS8qIEdQ
VSBvbmx5IGNyZWF0ZXMgZGlyZWN0IGxpbmtzIHNvIGFwcGx5IGZsYWdzIHNldHRpbmcgdG8gYWxs
ICovCj4gIAlsaXN0X2Zvcl9lYWNoX2VudHJ5KGxpbmssICZkZXYtPmlvX2xpbmtfcHJvcHMsIGxp
c3QpIHsKPiAgCQlsaW5rLT5mbGFncyA9IGZsYWc7Cl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
