Return-Path: <SRS0=E5im=JG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830BDC433B4
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Apr 2021 16:39:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 458656108B
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Apr 2021 16:39:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 458656108B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0982E6EC3C;
	Fri,  9 Apr 2021 16:39:54 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2055.outbound.protection.outlook.com [40.107.95.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FA576EC3C
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Apr 2021 16:39:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ITOv/+3SBDz+/YkJa+PTmhiGuQfj0yy/EuiC1fhnXMOctcTeEoaXv3fuyq0lxo+5T3qd+ThiTqyqP534csRH+GIqxFKuudpX9gA1XsQwrobTufauWrTLtvb6s14So98FVdVp1ukYBUIVGLBm5SktlCaJE/LUAZOGAyQtCPH78pHNlvGEiDvmC/6EHUF8gGDaNoWUuwyQdt+8o9tGYsZyJzHLiSv1urqCSYxLk6C1WEgWmK7Ro72IIAGItIkjhgD0WZkkI1KkNR1ipJgnngeYaNeet24FTtz3aJazryV+fkZN/pGq/Df6ahIW5T2P48BifwQhrNnPQYpYMa4eNMfqIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NZ4raHyx3GKMUCnRfdHQdq+a4C/xVHKl80EvNIZS9s=;
 b=f8nvhMWyh+DxkSn7nRU/9jR2xPDKK1d4BdJaqRhBK3t1HVkoe7WnBDuhSvF9GcO4Yl/m2jMZ7nU4WwVct+gZe8BkT64IHSbu4yjTNLZkhYo+2iMDZQpJh/+NeVcuVywrNUtG3mWLxvZJ/mp+NohB16HIx6ejdpMr61casfTvQZlaR+Yjn4qF4POhhS3ob0L/iDrf+a3OiTMLGhv4e80PQuZ6gS4YMcsJqUqAFbc9DMY0Axd1lMuqyXIZ0lff1H4YALespj3/ABi3WiK2rXBLzSYsw9btv/4mQaHf2iS+oHAgeZYZgBmd5uHtUJcuEIPLGsjXYIq9bbjVd+cW6ojvAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NZ4raHyx3GKMUCnRfdHQdq+a4C/xVHKl80EvNIZS9s=;
 b=o0/idyLKhRiQCCL/OEP0Zv8/f1qzv38pOmfBS/5+qpCeGhw5LphEyN5CH2m9f0ZLu/Cs9oXFSN6zxeCY+O9oIvYCWHTKMELp+BC4dr0/W+YVI0h02Kcl9rW3SSc0IzwRurck90iM9qLGfQZMRjX/yWPhluaVq6YzRH8zvcNFkJ4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4947.namprd12.prod.outlook.com (2603:10b6:208:17d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Fri, 9 Apr
 2021 16:39:51 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4020.017; Fri, 9 Apr 2021
 16:39:51 +0000
Subject: Re: [PATCH 0/4] Refine GPU recovery sequence to enhance its stability
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Li, Dennis" <Dennis.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
References: <20210318072339.28736-1-Dennis.Li@amd.com>
 <DM5PR12MB25330F3CD92C587C2E921424ED699@DM5PR12MB2533.namprd12.prod.outlook.com>
 <MN2PR12MB3775531A74B886A207134B1583699@MN2PR12MB3775.namprd12.prod.outlook.com>
 <DM5PR12MB253379E8C89D8A20C8A0245AED699@DM5PR12MB2533.namprd12.prod.outlook.com>
 <378fdffb-99b5-2a14-736d-a06f310b040c@amd.com>
 <1e37bb4d-f54d-1b7e-4632-94cfcf749528@amd.com>
 <51d7873d-cf35-6be5-79c2-024937c67f6a@amd.com>
 <29ffe63b-9049-824f-84fc-a92fdb451e0d@amd.com>
 <e37bdceb-cdb2-a826-21cf-8cb88748be08@gmail.com>
 <1e4b766d-b5c2-e6b5-8be6-9b2fae3abc94@amd.com>
 <b67ab565-e4be-0809-7021-cb59fd10464a@amd.com>
 <8c2cbe39-ea05-add4-efee-65527e53bb34@gmail.com>
 <50e0907c-52d6-1fdb-aa5e-39b1c326180c@amd.com>
 <4a1e3961-8708-46b7-bfd8-86a4ee4e2726@amd.com>
 <f36bef2c-d5c2-7290-c029-2bcc9d834bbc@amd.com>
 <b3965720-ea45-7664-5927-dd3836bfa46d@amd.com>
 <32b2ab00-7514-43ce-cb28-a437c194c16a@gmail.com>
 <01f69c6f-02a3-3387-db6b-0fa1bfa9bd17@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <70a534b7-2e55-cdd7-2f82-3b8799967aa0@amd.com>
Date: Fri, 9 Apr 2021 18:39:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <01f69c6f-02a3-3387-db6b-0fa1bfa9bd17@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:38d3:2905:48d2:92b1]
X-ClientProxiedBy: FR0P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::10) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:38d3:2905:48d2:92b1]
 (2a02:908:1252:fb60:38d3:2905:48d2:92b1) by
 FR0P281CA0005.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:15::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.6 via Frontend Transport; Fri, 9 Apr 2021 16:39:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6303c98-ff9f-4b3d-ba01-08d8fb761885
X-MS-TrafficTypeDiagnostic: BL0PR12MB4947:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB49474C08CAE8FD038C22BFC983739@BL0PR12MB4947.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wjbliY0B0CHr0Zx4sOWI2QFgabHmYpQcp0bblbLD15y1Qwk9cB6NnrOd0drGrT2U0efRDEf0IzxmqIbn/opzxcTDwS7eBLyqGZxBfFMiBahj9WIug2fyo8rXHc2jxQAYCeXuSYsfEjwi6sGMzczkQvkgPVcs6Yd3wCWCqHSiLlNxiHkWvLSDeE5oikHeydBrDol+NOs9JqFiEG1khx7r0alCrVd00575zbCQxbaRdf+aYu/eP7XHd3eJ1n/orQX16iFEOXCCpS3rT7yGVit7/pQiakw/RWKXWSxTuw/7yWoAt9Vh5nD/sEh2fm3+fU+iKdGKBomieLArJdmJkYpk8vzdeBUpATE+FTT9kVr3RgqlhIKlObS9TsiusS4IcRTkxmQpwVnyt13Ryg7Tiqg81oYl1miOAqZ/lKKxbzJJn+5WAInsA8KG91k3X5q/oTdxGpZThEvrEVOoTQnXBTV1+jRBfogovSIurnaQMvrdQlB/lNPmwxwom2huo3lOhR85hlbWKQuKZSTTmcGLCZlQILnuBKADNZUJPjVyKECVwA5LG/Yk1F9AMlCiWBxcNqBV+8UP2uv9l0zMPiNdIAD7PqXI48J4l9r+4OOTFgTw8Tz/9u+6Ji/tyfoee9479hSKZgP1+51ezkzgDQeGelmokmUqSTIXikNee4dszVbfx31y4SQHfXHcmvSJd91Fc+kAc26TLoaM1U+fwm4ka2GyxidDftiVx7IGyC3yHp61Zi+U2ipEemlVx76zWEFemnVZDC3uhivylxEXXBOO/0JdpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(366004)(396003)(39860400002)(376002)(6666004)(966005)(53546011)(31696002)(66476007)(8676002)(6486002)(478600001)(31686004)(66556008)(66946007)(6636002)(2906002)(83380400001)(16526019)(38100700001)(186003)(36756003)(316002)(52116002)(2616005)(66574015)(86362001)(8936002)(921005)(110136005)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?b3g3SEZzemt4YzJxQWozamJoM3hobTRvSHlsM1NzblE2SG1XMVJTeDF3NGdZ?=
 =?utf-8?B?elExSHBobXJWVzVwUWtTUGROLzBqSEE4L3FiZ25IZTFKckJ4OHBFcmp3S3FY?=
 =?utf-8?B?QU9YcXo2VjZJa3NyUFRtcytMRnQ2bC9ndDZETlpodE5JVmg4eU9haUhDSXZE?=
 =?utf-8?B?d1g5THJnTnBSempEdUFWU25ZOXlvY1M4Ym1KZnVkbEJLYVJwNWwrY05KWGph?=
 =?utf-8?B?anloN1p5ZXdDcjhQSTJzYndzcUU2cGw5cmZISW5PZTVNTXRWaHdMWU9IMWdq?=
 =?utf-8?B?amx3anIxOXR2YXJyMDJ3aVhTUkpVSVcyYzdDM3FDZWZqeVhUYzArdEdHTndJ?=
 =?utf-8?B?eWp1UEFJWVR1c3UvVG9VdlZ4dkE3WVNGb2NydjJ3VWFSc1YvTGlCUUZVeEhC?=
 =?utf-8?B?UTJwcVpxQzlReEYwTWVweUdYVWM0bVFPRWpEUGV5U0Q4a0oxSG9zMWFGM0RE?=
 =?utf-8?B?UGVwSXNUTkJJc3FFM2lGbDNNaVI5cTlXTndjNTFzajZMT0RtNTMzbEd4Sjls?=
 =?utf-8?B?THAzQjVCUkJ3Q09MUFJlWmQ4QXFrREpBZ3pMT2U5SGdURitiZStLc2ttbmF6?=
 =?utf-8?B?RnRZUjNURmdMTWVPVlYxMHFkb093d2dLbU1ZU0FyU0dMSTBkVEFRR1JrUEFU?=
 =?utf-8?B?Rk5WeStLRFRSR1dRdzVlVDYrcHpudC96M1dSVGpNT1pJZTBBakd4eTVZS01T?=
 =?utf-8?B?Z3RpNC9CL1liYkRGclZHQS90c3NYOW9GVEFNT2E2SEtVRW5ZU0N4Y1ZPTzY5?=
 =?utf-8?B?ZEw3bmhXVVJXTnJqV09FZXVRUTZmNjZyMm1ST3dxdDBaTlJaQVBURTU0QWsr?=
 =?utf-8?B?UW1Fd3JxNW9uSHYySkdOU25FQWdQVWQ4bXUwNHp0K2c1L3hIK0VZOEZtRlQ3?=
 =?utf-8?B?WlpaajMwTWF1VmMySmdYQ2FSSDFCUTBNd2oyLzBjMGVZbW11aVpRZ2o1bzhz?=
 =?utf-8?B?SVlNMWpiaHpTeHZuUTJjZitFSXhTL3dsak55eWV1RmZpUjlpYXEvclhtTEVY?=
 =?utf-8?B?eHRpVXhBRDYzYS9UZHRjNFhwT1NuaVU4QkxHRjNDY05adlpVaVg3eFhRaWN5?=
 =?utf-8?B?ZDhYWitCdXQ3S2IvSVd3cDlZWnRSMnRQVWJST1FseVBIK1I1Z20yQWNFRlRh?=
 =?utf-8?B?MEh3TjFKZDlMOWJQK0tBSlkxLzRsNHViS1JrNU81SGN0cFA5eUN3WVJZcHho?=
 =?utf-8?B?N3NrS1dnYlRoYitLNzlySFV6blRRT2ltRWdHd1FZM2Q1TGUvNHhlK1FORVRo?=
 =?utf-8?B?QTg3dk5KU0VXalRiY0w2LzZXUlpiMVJXRkF1Qkg1ZVkxMXNXRjhNdG9TUjdB?=
 =?utf-8?B?SU1iMHF1bndtMFZha29aWlJmWlZPK2M1NnhXcHlCdG4xd2I1WnZxc1JJS3pt?=
 =?utf-8?B?eitoQkgxdzdQU05CVTFySC9kS1ZheVR1Z01mL1U2NjQvZlp1Q0lGYVdENHZh?=
 =?utf-8?B?ZlFOc0JjVDZJS2M0eTVEMEg0Slhyc0JqWkMxdjNyMnRSblQxOXk1STdnVTdK?=
 =?utf-8?B?UTJoSFJjYlNKMEpDdzlGRE5RYlI1ZElwTlVyT2lPeDZyZGl1VWpCYW51dDVZ?=
 =?utf-8?B?VTlqUEhaRng2eExVU2oraWpncmZadWZMWitlN0xKdUZ5eFh3clNrSUtqVHBY?=
 =?utf-8?B?RXNQS21TRGV4UTh0VWt3K2NnOUxjQm1oUVJuOGZ3M2E0SGp1K2d0NnFwbHpm?=
 =?utf-8?B?T3N0ZHZGMDIrYlF3WGJIME56bW1YSElTS05UZDRzTDNBWG41eEZ6QnFsVmYv?=
 =?utf-8?B?Smd3U2FvWXlqM09aZzRSbldEV0NCU3UxQ3NxakZnQ3RVNk5lWk91RER4WDJS?=
 =?utf-8?B?djcxdVZMNGY4bG9na09zM0RFaForWWtrVmVac2w3Y0M0dFB5aFE4TEJBNkxW?=
 =?utf-8?Q?WQjtXAlfJGIDU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6303c98-ff9f-4b3d-ba01-08d8fb761885
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 16:39:51.0004 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4b2NB7lnUva8DXihOHBBrwHw2m2uA2DUO5q0szglW4jRCNmOWDF7tko4RYtHQFfe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4947
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

QW0gMDkuMDQuMjEgdW0gMTc6NDIgc2NocmllYiBBbmRyZXkgR3JvZHpvdnNreToKPgo+IE9uIDIw
MjEtMDQtMDkgMzowMSBhLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBBbSAwOS4wNC4y
MSB1bSAwODo1MyBzY2hyaWViIENocmlzdGlhbiBLw7ZuaWc6Cj4+PiBBbSAwOC4wNC4yMSB1bSAy
MjozOSBzY2hyaWViIEFuZHJleSBHcm9kem92c2t5Ogo+Pj4+IFtTTklQXQo+Pj4+IEJ1dCBpbnNl
cnRpbmcgZG1yX2Rldl9lbnRlci9leGl0IG9uIHRoZSBoaWdoZXN0IGxldmVsIGluIGRybV9pb2N0
bCAKPj4+PiBpcyBtdWNoIGxlc3MgZWZmb3J0IGFuZCBsZXNzIHJvb20gZm9yIGVycm9yIHRoZW4g
Z29pbmcgdGhyb3VnaCBlYWNoIAo+Pj4+IElPQ1RMIGFuZCB0cnlpbmcgdG8gaWRlbnRpZnkgYXQg
d2hhdCBwb2ludCAocG9zc2libHkgbXVsdGlwbGUgCj4+Pj4gcG9pbnRzKSB0aGV5IGFyZSBhYm91
dCB0byBhY2Nlc3MgSFcsIHNvbWUgb2YgdGhpcyBpcyBoaWRkZW4gZGVlcCBpbiAKPj4+PiBIQUwg
bGF5ZXJzIHN1Y2ggYXMgREMgbGF5ZXIgaW4gZGlzcGxheSBkcml2ZXIgb3IgdGhlIG11bHRpIGxh
eWVycyAKPj4+PiBvZiBwb3dlcnBsYXkvU01VIGxpYnJhcmllcy4gQWxzbywgd2UgY2FuJ3Qgb25s
eSBsaW1pdCBvdXItc2VsZiB0byAKPj4+PiBiYWNrLWVuZCBpZiBieSB0aGlzIHlvdSBtZWFuIEFT
SUMgc3BlY2lmaWMgZnVuY3Rpb25zIHdoaWNoIGFjY2VzcyAKPj4+PiByZWdpc3RlcnMuIFdlIGFs
c28gbmVlZCB0byB0YWtlIGNhcmUgb2YgYW55IE1NSU8ga2VybmVsIEJPIChWUkFNIAo+Pj4+IEJP
cykgd2hlcmUgd2UgbWF5IGFjY2VzcyBkaXJlY3RseSBNTUlPIHNwYWNlIGJ5IHBvaW50ZXIgZnJv
bSB0aGUgCj4+Pj4gZnJvbnQgZW5kIG9mIHRoZSBkcml2ZXIgKEhXIGFnbm9zdGljKSBhbmQgVFRN
L0RSTSBsYXllcnMuCj4+Pgo+Pj4gRXhhY3RseSwgeWVzLiBUaGUga2V5IHBvaW50IGlzIHdlIG5l
ZWQgdG8gaWRlbnRpZnkgc3VjaCBwbGFjZXMgCj4+PiBhbnl3YXkgZm9yIEdQVSByZXNldCB0byB3
b3JrIHByb3Blcmx5LiBTbyB3ZSBjb3VsZCBqdXN0IHBpZ2d5IGJhY2sgCj4+PiBob3RwbHVnIG9u
IHRvcCBvZiB0aGF0IHdvcmsgYW5kIGFyZSBkb25lLgo+Cj4KPiBJIHNlZSBtb3N0IG9mIHRoaXMg
d2FzIGRvbmUgQnkgRGVuaXMgaW4gdGhpcyBwYXRjaCAKPiBodHRwczovL2NnaXQuZnJlZWRlc2t0
b3Aub3JnL35hZ3JvZHpvdi9saW51eC9jb21taXQvP2g9ZHJtLW1pc2MtbmV4dCZpZD1kZjljOGQx
YWEyNzhjNDM1YzMwYTY5YjhmMjQxOGI0YTUyZmNiOTI5LCAKPiBpbmRlZWQgdGhpcyBkb2Vzbid0
IGNvdmVyIHRoZSBkaXJlY3QgYnkgcG9pbnRlciBhY2Nlc3NlcyBvZiBNTUlPIGFuZCAKPiB3aWxs
IGludHJvZHVjZSBtdWNoIG1vcmUgb2YgdGhvc2UgYW5kLCBhcyBwZW9wbGUgd3JpdGUgbmV3IGNv
ZGUsIG5ldyAKPiBwbGFjZXMgdG8gY292ZXIgd2lsbCBwb3AgdXAgbGVhZGluZyB0byByZWdyZXNz
aW9ucyBhbmQgZXh0cmEgd29yayB0byAKPiBmaXguIEl0IHdvdWxkIGJlIHJlYWxseSBtdWNoIGJl
dHRlciBpZiB3ZSBjb3VsZCBibGFua2V0IGNvdmVyIGl0IGF0IAo+IHRoZSB2ZXJ5IHRvcMKgIHN1
Y2ggYXMgcm9vdCBvZiBhbGwgSU9DVExzIG9yLCBmb3IgYW55IHF1ZXVlZCB3b3JrL3RpbWVyIAo+
IGF0IHRoZSB2ZXJ5IHRvcCBmdW5jdGlvbiwgdG8gaGFuZGxlIGl0IG9uY2UgYW5kIGZvciBhbGwu
CgpBbmQgZXhhY3RseSB0aGF0J3Mgd2hhdCBpcyBub3QgcG9zc2libGUuIEF0IGxlYXN0IGZvciB0
aGUgcmVzZXQgY2FzZSB5b3UgCm5lZWQgdG8gbG9vayBpbnRvIGVhY2ggaGFyZHdhcmUgYWNjZXNz
IGFuZCBoYW5kbGUgdGhhdCBiaXQgYnkgYml0IGFuZCBJIAp0aGluayB0aGF0IGZvciB0aGUgaG90
cGx1ZyBjYXNlIHdlIHNob3VsZCBnbyBkb3duIHRoYXQgcm91dGUgYXMgd2VsbC4KCj4+Pgo+Pj4+
Cj4+Pj4gT3VyIHByb2JsZW0gaGVyZSBpcyBob3cgdG8gc2lnbmFsIGFsbCB0aGUgZXhpc3RpbmfC
oCBmZW5jZXMgb24gb25lIAo+Pj4+IGhhbmQgYW5kIG9uIHRoZSBvdGhlciBwcmV2ZW50IGFueSBu
ZXcgZG1hX2ZlbmNlIHdhaXRzIGFmdGVyIHdlIAo+Pj4+IGZpbmlzaGVkIHNpZ25hbGluZyBleGlz
dGluZyBmZW5jZXMuIE9uY2Ugd2Ugc29sdmVkIHRoaXMgdGhlbiB0aGVyZSAKPj4+PiBpcyBubyBw
cm9ibGVtIHVzaW5nIGRybV9kZXZfdW5wbHVnIGluIGNvbmp1bmN0aW9uIHdpdGggCj4+Pj4gZHJt
X2Rldl9lbnRlci9leGl0IGF0IHRoZSBoaWdoZXN0IGxldmVsIG9mIGRybV9pb2N0bCB0byBmbHVz
aCBhbnkgCj4+Pj4gSU9DVExzIGluIGZsaWdodCBhbmQgYmxvY2sgYW55IG5ldyBvbmVzLgo+Pj4+
Cj4+Pj4gSU1ITyB3aGVuIHdlIHNwZWFrIGFib3V0IHNpZ25hbGxpbmcgYWxsIGZlbmNlcyB3ZSBk
b24ndCBtZWFuIEFMTCAKPj4+PiB0aGUgY3VycmVudGx5IGV4aXN0aW5nIGRtYV9mZW5jZSBzdHJ1
Y3RzICh0aGV5IGFyZSBzcHJlYWQgYWxsIG92ZXIgCj4+Pj4gdGhlIHBsYWNlKSBidXQgcmF0aGVy
IHNpZ25hbCBhbGwgdGhlIEhXIGZlbmNlcyBiZWNhdXNlIEhXIGlzIHdoYXQncyAKPj4+PiBnb25l
IGFuZCB3ZSBjYW4ndCBleHBlY3QgZm9yIHRob3NlIGZlbmNlcyB0byBiZSBldmVyIHNpZ25hbGVk
LiBBbGwgCj4+Pj4gdGhlIHJlc3Qgc3VjaCBhczogc2NoZWR1bGVyIGZlbmNlcywgdXNlciBmZW5j
ZXMsIGRybV9nZW0gCj4+Pj4gcmVzZXJ2YXRpb24gb2JqZWN0cyBlLnQuYy4gYXJlIGVpdGhlciBk
ZXBlbmRlbnQgb24gdGhvc2UgSFcgZmVuY2VzIAo+Pj4+IGFuZCBoZW5jZSBzaWduYWxpbmcgdGhl
IEhXIGZlbmNlcyB3aWxsIGluIHR1cm4gc2lnbmFsIHRoZW0gb3IsIGFyZSAKPj4+PiBub3QgaW1w
YWN0ZWQgYnkgdGhlIEhXIGJlaW5nIGdvbmUgYW5kIGhlbmNlIGNhbiBzdGlsbCBiZSB3YWl0ZWQg
b24gCj4+Pj4gYW5kIHdpbGwgY29tcGxldGUuIElmIHRoaXMgYXNzdW1wdGlvbiBpcyBjb3JyZWN0
IHRoZW4gSSB0aGluayB0aGF0IAo+Pj4+IHdlIHNob3VsZCB1c2Ugc29tZSBmbGFnIHRvIHByZXZl
bnQgYW55IG5ldyBzdWJtaXNzaW9uIHRvIEhXIHdoaWNoIAo+Pj4+IGNyZWF0ZXMgSFcgZmVuY2Vz
IChzb21ld2hlcmUgYXJvdW5kIGFtZGdwdV9mZW5jZV9lbWl0KSwgdGhlbiAKPj4+PiB0cmF2ZXJz
ZSBhbGwgZXhpc3RpbmcgSFcgZmVuY2VzIChjdXJyZW50bHkgdGhleSBhcmUgc3ByZWFkIGluIGEg
ZmV3IAo+Pj4+IHBsYWNlcyBzbyBtYXliZSB3ZSBuZWVkIHRvIHRyYWNrIHRoZW0gaW4gYSBsaXN0
KSBhbmQgc2lnbmFsIHRoZW0uIAo+Pj4+IEFmdGVyIHRoYXQgaXQncyBzYWZlIHRvIGNhbCBkcm1f
ZGV2X3VucGx1ZyBhbmQgYmUgc3VyZSAKPj4+PiBzeW5jaHJvbml6ZV9zcmN1IHdvbid0IHN0YWxs
IGJlY2F1c2Ugb2Ygb2YgZG1hX2ZlbmNlX3dhaXQuIEFmdGVyIAo+Pj4+IHRoYXQgd2UgY2FuIHBy
b2NlZWQgdG8gY2FuY2VsaW5nIHdvcmsgaXRlbXMsIHN0b3BwaW5nIHNjaGVkdWxlcnMgCj4+Pj4g
ZS50LmMuCj4+Pgo+Pj4gVGhhdCBpcyBwcm9ibGVtYXRpYyBhcyB3ZWxsIHNpbmNlIHlvdSBuZWVk
IHRvIG1ha2Ugc3VyZSB0aGF0IHRoZSAKPj4+IHNjaGVkdWxlciBpcyBub3QgY3JlYXRpbmcgYSBu
ZXcgaGFyZHdhcmUgZmVuY2UgaW4gdGhlIG1vbWVudCB5b3UgdHJ5IAo+Pj4gdG8gc2lnbmFsIGFs
bCBvZiB0aGVtLiBJdCB3b3VsZCByZXF1aXJlIGFub3RoZXIgU1JDVSBvciBsb2NrIGZvciB0aGlz
Lgo+Cj4KPiBJZiB3ZSB1c2UgYSBsaXN0IGFuZCBhIGZsYWcgY2FsbGVkICdlbWl0X2FsbG93ZWQn
IHVuZGVyIGEgbG9jayBzdWNoIAo+IHRoYXQgaW4gYW1kZ3B1X2ZlbmNlX2VtaXQgd2UgbG9jayB0
aGUgbGlzdCwgY2hlY2sgdGhlIGZsYWcgYW5kIGlmIHRydWUgCj4gYWRkIHRoZSBuZXcgSFcgZmVu
Y2UgdG8gbGlzdCBhbmQgcHJvY2VlZCB0byBIVyBlbWl0aW9uIGFzIG5vcm1hbCwgCj4gb3RoZXJ3
aXNlIHJldHVybiB3aXRoIC1FTk9ERVYuIEluIGFtZGdwdV9wY2lfcmVtb3ZlIHdlIHRha2UgdGhl
IGxvY2ssIAo+IHNldCB0aGUgZmxhZyB0byBmYWxzZSwgYW5kIHRoZW4gaXRlcmF0ZSB0aGUgbGlz
dCBhbmQgZm9yY2Ugc2lnbmFsIGl0LiAKPiBXaWxsIHRoaXMgbm90IHByZXZlbnQgYW55IG5ldyBI
VyBmZW5jZSBjcmVhdGlvbiBmcm9tIG5vdyBvbiBmcm9tIGFueSAKPiBwbGFjZSB0cnlpbmcgdG8g
ZG8gc28gPwoKV2F5IHRvIG11Y2ggb3ZlcmhlYWQuIFRoZSBmZW5jZSBwcm9jZXNzaW5nIGlzIGlu
dGVudGlvbmFsbHkgbG9jayBmcmVlIHRvIAphdm9pZCBjYWNoZSBsaW5lIGJvdW5jaW5nIGJlY2F1
c2UgdGhlIElSUSBjYW4gbW92ZSBmcm9tIENQVSB0byBDUFUuCgpXZSBuZWVkIHNvbWV0aGluZyB3
aGljaCBhdCBsZWFzdCB0aGUgcHJvY2Vzc2luZyBvZiBmZW5jZXMgaW4gdGhlIAppbnRlcnJ1cHQg
aGFuZGxlciBkb2Vzbid0IGFmZmVjdCBhdCBhbGwuCgo+Pgo+PiBBbHRlcm5hdGl2ZWx5IGdyYWJi
aW5nIHRoZSByZXNldCB3cml0ZSBzaWRlIGFuZCBzdG9wcGluZyBhbmQgdGhlbiAKPj4gcmVzdGFy
dGluZyB0aGUgc2NoZWR1bGVyIGNvdWxkIHdvcmsgYXMgd2VsbC4KPj4KPj4gQ2hyaXN0aWFuLgo+
Cj4KPiBJIGRpZG4ndCBnZXQgdGhlIGFib3ZlIGFuZCBJIGRvbid0IHNlZSB3aHkgSSBuZWVkIHRv
IHJldXNlIHRoZSBHUFUgCj4gcmVzZXQgcndfbG9jay4gSSByZWx5IG9uIHRoZSBTUkNVIHVucGx1
ZyBmbGFnIGZvciB1bnBsdWcuIEFsc28sIG5vdCAKPiBjbGVhciB0byBtZSB3aHkgYXJlIHdlIGZv
Y3VzaW5nIG9uIHRoZSBzY2hlZHVsZXIgdGhyZWFkcywgYW55IGNvZGUgCj4gcGF0Y2ggdG8gZ2Vu
ZXJhdGUgSFcgZmVuY2VzIHNob3VsZCBiZSBjb3ZlcmVkLCBzbyBhbnkgY29kZSBsZWFkaW5nIHRv
IAo+IGFtZGdwdV9mZW5jZV9lbWl0IG5lZWRzIHRvIGJlIHRha2VuIGludG8gYWNjb3VudCBzdWNo
IGFzLCBkaXJlY3QgSUIgCj4gc3VibWlzc2lvbnMsIFZNIGZsdXNoZXMgZS50LmMKCllvdSBuZWVk
IHRvIHdvcmsgdG9nZXRoZXIgd2l0aCB0aGUgcmVzZXQgbG9jayBhbnl3YXksIGNhdXNlIGEgaG90
cGx1ZyAKY291bGQgcnVuIGF0IHRoZSBzYW1lIHRpbWUgYXMgYSByZXNldC4KCgpDaHJpc3RpYW4u
Cgo+Cj4gQW5kcmV5Cj4KPgo+Pgo+Pj4KPj4+IENocmlzdGlhbi4KPj4+Cj4+Pj4KPj4+PiBBbmRy
ZXkKPj4+Pgo+Pj4+Cj4+Pj4+Cj4+Pj4+PiBBbmRyZXkKPj4+Pj4+Cj4+Pj4+Pgo+Pj4+Pgo+Pj4K
Pj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
