Return-Path: <SRS0=/n0Y=HD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE96C433E9
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 14:25:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD83B64DCC
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 14:25:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD83B64DCC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D24A6E5D3;
	Mon,  1 Feb 2021 14:25:42 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam04on0630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe4d::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A0A06E5C6
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Feb 2021 14:25:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DlFv65q8wMkwFXWouxF2AtwyREhDPcJO9/ccICEE5hKhnehxOFucOG98EAo/WMy/RWAHFtbnBaa5Uq/hCCyHnhTVUHS1S4cTJfbaWm7ICVzxyLzLRUGtSlxEiTReuAlTLWNBJDVkmKf/8K93adprOi6uynnC3LLJ1WnD7qUJ31ruwvIwU9AhZWlFYc/oCRNT471e/pgXMIoVP0dfv6wk41Bwh/VvEd/5H6++PJ90i+Ngp182GUkLiVp1eZuE2lc7zWqiLDZOThrZyMdzgZ/oho8AgVgCD7lww4frvkUgHyFvq1gYELJZgQg87mvg0M1xkeSnHeH5eAzZOTziX/NR4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=564iovEBqgvuXG2Cc9PGKWz57Je3q699qDAwKLy1cEc=;
 b=m9DYe97+qll6J+UL89Vob85nYOwlWd+pkMc9pvK1pjRJ8rzRfcmtJdY9uayh77HPSP2c+LqS+lZFtPMdhRd962PaQedMbg/k3kyvSkvrpGHsIMGjO0GU5v7BuJJiEMI9Lbz1wtFQw25llUWmfbVaUR5r8cOCruttJJ0iVmC+sUHpBto4EupPwJtLPTqlgL9gXojOtCyZh2hgkPhOZOcqRA7+yu0t+Fll2ojwTmlSfnd4XsJ6VgBd2C9PkHIpV0Bb4PLE9P7Hczdujxc6wPZGo2jQpbKl8en4wjMZ5TZr2HPSfrysZcKoZHbLtKVfhGJEvyWA9slWMDt/XEeXCrNp8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=564iovEBqgvuXG2Cc9PGKWz57Je3q699qDAwKLy1cEc=;
 b=SBXrf/JVyQO7dTaP8Xn4F0wiAMnjT894zPhqZ3NCSNW0lywTmIrCGl0VYkwzqioCGgI7/3WTloAC38y386arT6m0pbUtsM+vRm4RNxsihd5cPuzg/gGIS3bJE7NH7hIExx8/qxdv+w3kCf8Ln220ls7cX4cxDeyH/kB1RR7jpg8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB3694.namprd12.prod.outlook.com (2603:10b6:208:165::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Mon, 1 Feb
 2021 14:25:37 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab%8]) with mapi id 15.20.3784.022; Mon, 1 Feb 2021
 14:25:37 +0000
Subject: Re: [PATCH] drm/amdkfd: fix null pointer panic while free buffer in
 kfd
To: Huang Rui <ray.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210201103916.3153820-1-ray.huang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <1e721947-02e4-2fdf-42d0-e00fbb5a2856@amd.com>
Date: Mon, 1 Feb 2021 09:25:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210201103916.3153820-1-ray.huang@amd.com>
Content-Language: en-US
X-Originating-IP: [142.117.121.176]
X-ClientProxiedBy: YTOPR0101CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::23) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.117.121.176) by
 YTOPR0101CA0010.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend
 Transport; Mon, 1 Feb 2021 14:25:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a6484978-9abe-4de3-09da-08d8c6bd3ead
X-MS-TrafficTypeDiagnostic: MN2PR12MB3694:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3694F6E73FB318848B3DF06D92B69@MN2PR12MB3694.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SQhSTGkOl2lIkNoKAOr3evbRh/mEUQp4Evak6k81jS9MGl0tMYOBan0ST28zxavMrWVsR51YGEQ5eFVxtxPWFc3308c/yc+qH+MX5hoHKaf8lRvLBzGKqCxic+/mW8HeFZ5+q3Zz9A5DZ5XVKrQO8PU8tdK2C7FkVA10fOZlIYVI5F5GjqhWkSAkPb4dLHYqm6ffOzS5+ua6N0gzzIqL9sKCY21x5063WoqXNdEYi9/ej8wm+oqKYRIwS+R7h/Q5sYoRjUbvmJ2AOi3l0usVqsgY5EoCRxVAI929Ws4+g57T9OSwzoN+6pBHm/iAhDpPe7K5SrQ9V0mzhmzMpgssMmn5yN2vbSYT2i0wZuSZswe1pAXy00EsilESRo5Ttfnx3GlfrJw24axJ+iq84uaP6qsN9KnGptMO2vs8UZRJSa9sC2t3/O/tM/B51HdnNKcuNyXF14f7PNUkp+J/WQrUZbNo/diR2iQgKMpj5rQ5xLqp7xOzIwH2VlsxO3V5kcMILs54QaoULOMjVYyYAmzDa07currF3sySBcS17df+Hi1y8qZd+8htcEzw2dZ7VMz2JDuf8mgd6128CzrHsBbVDdVFsvwN7ETVn5OEHYFBTlM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(86362001)(16526019)(66476007)(31686004)(2906002)(44832011)(31696002)(83380400001)(16576012)(316002)(36756003)(66556008)(5660300002)(4326008)(54906003)(26005)(66946007)(478600001)(956004)(52116002)(6486002)(186003)(8936002)(8676002)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZjBTbE8wMHc0VHlHaDdIcFllaThvcnhoaEtMTVdhbStvcDN4dWpReHNvNGln?=
 =?utf-8?B?ZTFPcmI0N0RtMDVMellqckRaWk9GQThHckN6czM5THpnc3o5dnRpWFY2Mi9P?=
 =?utf-8?B?MGVyd2FFenJWbzRhaktuUzRtNUhDMG1FS3cwczYrOEhUZ1d3Q3FURjNHMFZ2?=
 =?utf-8?B?TGhwVWlOcmNacVJoTlNtYkRvaEpwRytZWmVpeEZNOURIa3BmNVJxVWxzdG83?=
 =?utf-8?B?VEphMGtQU3VoNVdCZXJ0Nnh4QTZlYmlLMVBDYjNITDBjRldZUGVsNGVkcHp6?=
 =?utf-8?B?Tk9kL2NIY3NKaVJmUGF1aEFJQyszclFQNWJNdXJTTlNQcW53UTIzTzE3dE1p?=
 =?utf-8?B?dmNGc0FGUWx3VW51N2F6QU91aTZnbVZoamhlRGJCSFo3bEorMTlyV3dlbFlz?=
 =?utf-8?B?UE1zbXQ1cHlud0htc2NIK2t4cmg5RlExbGtGV0JsNDl5ZjY4K2VHNXlySU1r?=
 =?utf-8?B?T0FuNmxGQ3ZaL2pUWUo0Zm42NlJvR1FEVG5rckJXUnlQNEFmTUQ3ZnNpMnh3?=
 =?utf-8?B?UEgzc2xOa1QvWmVKaFI5bUUzUjdmMlpVMXRvTjB5TEFaMGhraDgvT2NkZ0R2?=
 =?utf-8?B?WXdBbTJvbkZ3YmJJWEtTbmtZYmE0RmxMUENmZlZIQmg2RDBYc0ZMbGF5Z1ZZ?=
 =?utf-8?B?cGFWZlVsdG42VXltL0F2WUtIT1NWZGdaSlJTc1pDMzlVb1JLNkJBKzBpblRZ?=
 =?utf-8?B?N2VvcERkV3FtdVZwNnAxVlg3MGVKVjVMdElyakxXcnVaN2dueXg5VUorSXAz?=
 =?utf-8?B?aTF0dW5IYXdFL0NWQzdrZzZxTXJYbDE0aTk1RTNZZkUrcFhNa2lVWGFWQSsx?=
 =?utf-8?B?L283QTF3MlA0Q1F2RXFGaHVqVW5VbnVWbW9XUytXWW1OWGVQVVYxTzZCeERR?=
 =?utf-8?B?Sno3WmYwb204c0VBalFyYlA0U3Q2K1RHZjZ1OExpS1ZPWVFtVGM0d0lXbTFk?=
 =?utf-8?B?TE1XY1E5QUM0RW53QUZ5Vi9SOThRSTBpMDVXS3NNaUtsek52bHZmUU9ZVExW?=
 =?utf-8?B?Y21OYUdPdWRJdGU2dUZsTXJTUHhvVHZnbXV1blFvU2p6L1JBSnRRTTRHTnFp?=
 =?utf-8?B?ODZZdmF3L05hUzJ2Q3lQV05RVWhvaHZULzN1Y2l0K3hNS2x0cnJ3dzdVTWpY?=
 =?utf-8?B?UnZ2eHh6ZzhTYThhMER2VUpDMVkxR1JBSE91dGtWTktqVmZyQ3JxSkVXMndM?=
 =?utf-8?B?VHl2Y0V5Ump5NFpQV3Q4OWFLcWt5QmYyZUVYb2VWYlBFbW13bGtJZ0dnK0Nr?=
 =?utf-8?B?NXcxYTNvbDViNlg1UU5pVm1lbnZUQllHYUFLMVY2b3hpaHk2dWNweDM0ME0r?=
 =?utf-8?B?U2YzUi9oaWcwZkhYMWVaajB5SDllVTlISUJJWUtMMjJJa0N4N1QwNnZrZ0Ra?=
 =?utf-8?B?VGlxaDh0OTBsblhkOTRJbXdvaUhNMVVxWUFlNU9CR3FFRXBYQitnOFBHZ2FB?=
 =?utf-8?B?Q3BXOGNyN0dWMzdLSzJpdEtSK3RMdXNxTDJyUVFRPT0=?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6484978-9abe-4de3-09da-08d8c6bd3ead
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2021 14:25:37.7263 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LrafERpJp9jzlzItx0s510XHAREQU2d/hlCGgoOK6nX4cKev7WR6EEb25+mMH5o7BUZD9eQ6i+ZAUwyCx5DmGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3694
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Changfeng <Changfeng.Zhu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhhbmsgeW91IGZvciBjYXRjaGluZyB0aGlzLiBJIGhhdmVuJ3QgaGFkIGEgY2hhbmNlIHRvIHRy
eSBvdXQgQWxleCdzCnJlYmFzZWQgYnJhbmNoIG15c2VsZiB5ZXQuIEkgdGhpbmsgdGhpcyBuZWVk
cyBhCgrCoMKgwqAgRml4ZXM6IDI0NmNiN2U0OWE3MCAoImRybS9hbWRncHU6IEludHJvZHVjZSBH
RU0gb2JqZWN0IGZ1bmN0aW9ucyIpCgpXaXRoIHRoYXQgZml4ZWQsIHRoZSBwYXRjaCBpcwoKUmV2
aWV3ZWQtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgoKVGhlIGZp
eCBhbHNvIG5lZWRzIHRvIGdvIHVwc3RyZWFtIGFzIEtGRCBzZWVtcyB0byBiZSB2ZXJ5IGJyb2tl
biB3aXRob3V0IGl0LgoKUmVnYXJkcywKwqAgRmVsaXgKCkFtIDIwMjEtMDItMDEgdW0gNTozOSBh
Lm0uIHNjaHJpZWIgSHVhbmcgUnVpOgo+IEluIGRybV9nZW1fb2JqZWN0X2ZyZWUsIGl0IHdpbGwg
Y2FsbCBmdW5jcyBvZiBkcm0gYnVmZmVyIG9iai4gU28KPiBrZmRfYWxsb2Mgc2hvdWxkIHVzZSBh
bWRncHVfZ2VtX29iamVjdF9jcmVhdGUgaW5zdGVhZCBvZgo+IGFtZGdwdV9ib19jcmVhdGUgdG8g
aW5pdGlhbGl6ZSB0aGUgZnVuY3MgYXMgYW1kZ3B1X2dlbV9vYmplY3RfZnVuY3MuCj4KPiBbICAz
OTYuMjMxMzkwXSBhbWRncHU6IFJlbGVhc2UgVkEgMHg3Zjc2YjRhZGEwMDAgLSAweDdmNzZiNGFk
ZDAwMAo+IFsgIDM5Ni4yMzEzOTRdIGFtZGdwdTogICByZW1vdmUgVkEgMHg3Zjc2YjRhZGEwMDAg
LSAweDdmNzZiNGFkZDAwMCBpbiBlbnRyeSAwMDAwMDAwMDg1YzI0YTQ3Cj4gWyAgMzk2LjIzMTQw
OF0gQlVHOiBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlLCBhZGRyZXNzOiAwMDAwMDAw
MDAwMDAwMDAwCj4gWyAgMzk2LjIzMTQ0NV0gI1BGOiBzdXBlcnZpc29yIHJlYWQgYWNjZXNzIGlu
IGtlcm5lbCBtb2RlCj4gWyAgMzk2LjIzMTQ2Nl0gI1BGOiBlcnJvcl9jb2RlKDB4MDAwMCkgLSBu
b3QtcHJlc2VudCBwYWdlCj4gWyAgMzk2LjIzMTQ4NF0gUEdEIDAgUDREIDAKPiBbICAzOTYuMjMx
NDk1XSBPb3BzOiAwMDAwIFsjMV0gU01QIE5PUFRJCj4gWyAgMzk2LjIzMTUwOV0gQ1BVOiA3IFBJ
RDogMTM1MiBDb21tOiBjbGluZm8gVGFpbnRlZDogRyAgICAgICAgICAgT0UgICAgIDUuMTEuMC1y
YzItY3VzdG9tICMxCj4gWyAgMzk2LjIzMTUzN10gSGFyZHdhcmUgbmFtZTogQU1EIENlbGFkb24t
Uk4vQ2VsYWRvbi1STiwgQklPUyBXQ0QwNDAxTl9XZWVrbHlfMjBfMDRfMCAwNC8wMS8yMDIwCj4g
WyAgMzk2LjIzMTU2M10gUklQOiAwMDEwOmRybV9nZW1fb2JqZWN0X2ZyZWUrMHhjLzB4MjIgW2Ry
bV0KPiBbICAzOTYuMjMxNjA2XSBDb2RlOiBlYiBlYyA0OCA4OSBjMyBlYiBlNyAwZiAxZiA0NCAw
MCAwMCA1NSA0OCA4OSBlNSA0OCA4YiBiZiAwMCAwNiAwMCAwMCBlOCA3MiAwZCAwMSAwMCA1ZCBj
MyAwZiAxZiA0NCAwMCAwMCA0OCA4YiA4NyA0MCAwMSAwMCAwMCA8NDg+IDhiIDAwIDQ4IDg1IGMw
IDc0IDBiIDU1IDQ4IDg5IGU1IGU4IDU0IDM3IDdjIGRiIDVkIGMzIDBmIDBiIGMzCj4gWyAgMzk2
LjIzMTY2Nl0gUlNQOiAwMDE4OmZmZmZiNDcwNDE3N2ZjZjggRUZMQUdTOiAwMDAxMDI0Ngo+IFsg
IDM5Ni4yMzE2ODZdIFJBWDogMDAwMDAwMDAwMDAwMDAwMCBSQlg6IGZmZmY5OTNhMGQwY2M0MDAg
UkNYOiAwMDAwMDAwMDAwMDAzMTEzCj4gWyAgMzk2LjIzMTcxMV0gUkRYOiAwMDAwMDAwMDAwMDAw
MDAxIFJTSTogZTljZGE3YTVkMDc5MWM2ZCBSREk6IGZmZmY5OTNhMzMzYTkwNTgKPiBbICAzOTYu
MjMxNzM2XSBSQlA6IGZmZmZiNDcwNDE3N2ZkZDAgUjA4OiBmZmZmOTkzYTAzODU1ODU4IFIwOTog
MDAwMDAwMDAwMDAwMDAwMAo+IFsgIDM5Ni4yMzE3NjFdIFIxMDogZmZmZjk5M2EwZDFmNzE1OCBS
MTE6IDAwMDAwMDAwMDAwMDAwMDEgUjEyOiAwMDAwMDAwMDAwMDAwMDAwCj4gWyAgMzk2LjIzMTc4
NV0gUjEzOiBmZmZmOTkzYTBkMGNjNDI4IFIxNDogMDAwMDAwMDAwMDAwMzAwMCBSMTU6IGZmZmZi
NDcwNDE3N2ZkZTAKPiBbICAzOTYuMjMxODExXSBGUzogIDAwMDA3Zjc2YjU3MzA3NDAoMDAwMCkg
R1M6ZmZmZjk5M2IyNzVjMDAwMCgwMDAwKSBrbmxHUzowMDAwMDAwMDAwMDAwMDAwCj4gWyAgMzk2
LjIzMTg0MF0gQ1M6ICAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAz
Mwo+IFsgIDM5Ni4yMzE4NjBdIENSMjogMDAwMDAwMDAwMDAwMDAwMCBDUjM6IDAwMDAwMDAxNmQy
ZTIwMDAgQ1I0OiAwMDAwMDAwMDAwMzUwZWUwCj4gWyAgMzk2LjIzMTg4NV0gQ2FsbCBUcmFjZToK
PiBbICAzOTYuMjMxODk3XSAgPyBhbWRncHVfYW1ka2ZkX2dwdXZtX2ZyZWVfbWVtb3J5X29mX2dw
dSsweDI0Yy8weDI1ZiBbYW1kZ3B1XQo+IFsgIDM5Ni4yMzIwNTZdICA/IF9fZHluYW1pY19kZXZf
ZGJnKzB4Y2QvMHgxMDAKPiBbICAzOTYuMjMyMDc2XSAga2ZkX2lvY3RsX2ZyZWVfbWVtb3J5X29m
X2dwdSsweDkxLzB4MTAyIFthbWRncHVdCj4gWyAgMzk2LjIzMjIxNF0gIGtmZF9pb2N0bCsweDIx
MS8weDM1YiBbYW1kZ3B1XQo+IFsgIDM5Ni4yMzIzNDFdICA/IGtmZF9pb2N0bF9nZXRfcXVldWVf
d2F2ZV9zdGF0ZSsweDUyLzB4NTIgW2FtZGdwdV0KPgo+IFNpZ25lZC1vZmYtYnk6IEh1YW5nIFJ1
aSA8cmF5Lmh1YW5nQGFtZC5jb20+Cj4gLS0tCj4KPiBUaGlzIHBhdGNoIGlzIHRvIGZpeCB0aGUg
aXNzdWUgb24gbGF0ZXN0IDUuMTEtcmMyIGJhc2VkIGFtZC1zdGFnaW5nLWRybS1uZXh0Lgo+Cj4g
LS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYyB8
IDE2ICsrKysrKy0tLS0tLS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwg
MTAgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2FtZGtmZF9ncHV2bS5jCj4gaW5kZXggMDg0OWI2OGU3ODRmLi5hYzBhNDMyYTliZjcgMTAw
NjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2
bS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2
bS5jCj4gQEAgLTI2LDYgKzI2LDcgQEAKPiAgI2luY2x1ZGUgPGxpbnV4L3NjaGVkL3Rhc2suaD4K
PiAgCj4gICNpbmNsdWRlICJhbWRncHVfb2JqZWN0LmgiCj4gKyNpbmNsdWRlICJhbWRncHVfZ2Vt
LmgiCj4gICNpbmNsdWRlICJhbWRncHVfdm0uaCIKPiAgI2luY2x1ZGUgImFtZGdwdV9hbWRrZmQu
aCIKPiAgI2luY2x1ZGUgImFtZGdwdV9kbWFfYnVmLmgiCj4gQEAgLTExNTIsNyArMTE1Myw3IEBA
IGludCBhbWRncHVfYW1ka2ZkX2dwdXZtX2FsbG9jX21lbW9yeV9vZl9ncHUoCj4gIAlzdHJ1Y3Qg
c2dfdGFibGUgKnNnID0gTlVMTDsKPiAgCXVpbnQ2NF90IHVzZXJfYWRkciA9IDA7Cj4gIAlzdHJ1
Y3QgYW1kZ3B1X2JvICpibzsKPiAtCXN0cnVjdCBhbWRncHVfYm9fcGFyYW0gYnA7Cj4gKwlzdHJ1
Y3QgZHJtX2dlbV9vYmplY3QgKmdvYmo7Cj4gIAl1MzIgZG9tYWluLCBhbGxvY19kb21haW47Cj4g
IAl1NjQgYWxsb2NfZmxhZ3M7Cj4gIAlpbnQgcmV0Owo+IEBAIC0xMjIwLDE5ICsxMjIxLDE0IEBA
IGludCBhbWRncHVfYW1ka2ZkX2dwdXZtX2FsbG9jX21lbW9yeV9vZl9ncHUoCj4gIAlwcl9kZWJ1
ZygiXHRjcmVhdGUgQk8gVkEgMHglbGx4IHNpemUgMHglbGx4IGRvbWFpbiAlc1xuIiwKPiAgCQkJ
dmEsIHNpemUsIGRvbWFpbl9zdHJpbmcoYWxsb2NfZG9tYWluKSk7Cj4gIAo+IC0JbWVtc2V0KCZi
cCwgMCwgc2l6ZW9mKGJwKSk7Cj4gLQlicC5zaXplID0gc2l6ZTsKPiAtCWJwLmJ5dGVfYWxpZ24g
PSAxOwo+IC0JYnAuZG9tYWluID0gYWxsb2NfZG9tYWluOwo+IC0JYnAuZmxhZ3MgPSBhbGxvY19m
bGFnczsKPiAtCWJwLnR5cGUgPSBib190eXBlOwo+IC0JYnAucmVzdiA9IE5VTEw7Cj4gLQlyZXQg
PSBhbWRncHVfYm9fY3JlYXRlKGFkZXYsICZicCwgJmJvKTsKPiArCXJldCA9IGFtZGdwdV9nZW1f
b2JqZWN0X2NyZWF0ZShhZGV2LCBzaXplLCAxLCBhbGxvY19kb21haW4sIGFsbG9jX2ZsYWdzLAo+
ICsJCQkJICAgICAgIGJvX3R5cGUsIE5VTEwsICZnb2JqKTsKPiAgCWlmIChyZXQpIHsKPiAgCQlw
cl9kZWJ1ZygiRmFpbGVkIHRvIGNyZWF0ZSBCTyBvbiBkb21haW4gJXMuIHJldCAlZFxuIiwKPiAt
CQkJCWRvbWFpbl9zdHJpbmcoYWxsb2NfZG9tYWluKSwgcmV0KTsKPiArCQkJIGRvbWFpbl9zdHJp
bmcoYWxsb2NfZG9tYWluKSwgcmV0KTsKPiAgCQlnb3RvIGVycl9ib19jcmVhdGU7Cj4gIAl9Cj4g
KwlibyA9IGdlbV90b19hbWRncHVfYm8oZ29iaik7Cj4gIAlpZiAoYm9fdHlwZSA9PSB0dG1fYm9f
dHlwZV9zZykgewo+ICAJCWJvLT50Ym8uc2cgPSBzZzsKPiAgCQliby0+dGJvLnR0bS0+c2cgPSBz
ZzsKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
