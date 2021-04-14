Return-Path: <SRS0=h6PS=JL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E66C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 14:58:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BBDA611C9
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 14:58:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BBDA611C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2ABCD6E4AB;
	Wed, 14 Apr 2021 14:58:51 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68DA46E4AB
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Apr 2021 14:58:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cmqHD8Qn4f2jSkzukm8Z1Tfp5yFQWy/qlFd+GUhHwqRQwAbCdD4xEMQPruDL92VnyCpRjr9HnFbOgdSMkrvA5izJmgVK2r75bn/p/zmWyDwJ3QedTr6Kg3FpzBpZMJZt93Yd3H9IiPXJPtmqHwKxJhTq1YuDIKDERR4K5993gtDN8luOgLFtXVJkmulrvp/zi/sxozreT3TwJae/+YFm5xBFvCoYMfZQNsOcqcHJrEbzr70TJiyFlOWpBhcLtJ0qQLYsKy5qM8BcuSMTc3qaj/M8+a1jUGR1etyCwofEStmo6g8aPpZxl2NeGh54vekdz0mmBVNzg4vmHa7BK0awsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7QTpLUolKRi/nqgCpIZ/7x9PxC+fuWSxXWAXtZcSa4=;
 b=HKXnBp8WUgCn6Ol7VCHcyXWNQiIr62hO0VG42Gj+Rrw/BBtgEyPKjEtkpxfYt4DYHO7Qahsai5oy3iJ8f+279AdjLHS+nok5T3ph64+JrlTvLuEduGkxV5gbwyR1xTR1XSxVqmOKM67jjG7LbjleCEgNHqKF+PBqshyahS85kEcynMvVpY24BLs6T9G2GvVM+a98JfRuk2C6XYn/7fE8CzJMEm5EjJkcRz23+JpCPj8sSPqTVXdXH9AnLfL4HDW4pwzBgTQjHRkHaF8Q0hQGJpnjt6/IIsUAIyMSqJ+sJzz4iQ+F2MJnXoFPxsB+M6+MCEqHjOIhplzFGvXChaRP+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7QTpLUolKRi/nqgCpIZ/7x9PxC+fuWSxXWAXtZcSa4=;
 b=Pqb/UwN41kuUvz3vm9tJ0cDn0Xd3Pp0eW2QBqfBPGhfLMT7trAF4uKXH9ngUloQpE2us3axP0S6dQ9xZNLx03wxmS2MRNHX4Mzx7ABd/BkjUHAjZKuO8Tq79lz63IucWyLyf3AbRux0wpbtaOhGoEsnMAFKF2IPrQFvctoJVHYI=
Authentication-Results: ffwll.ch; dkim=none (message not signed)
 header.d=none;ffwll.ch; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3887.namprd12.prod.outlook.com (2603:10b6:208:168::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 14 Apr
 2021 14:58:48 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4020.022; Wed, 14 Apr 2021
 14:58:48 +0000
Subject: Re: [PATCH 0/4] Refine GPU recovery sequence to enhance its stability
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Li, Dennis" <Dennis.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, Daniel Vetter <daniel@ffwll.ch>
References: <20210318072339.28736-1-Dennis.Li@amd.com>
 <70a534b7-2e55-cdd7-2f82-3b8799967aa0@amd.com>
 <62a329d4-ffd1-3ac1-03eb-dd0089b75541@amd.com>
 <b6a24d3f-4fe6-c642-b478-36e386aa906d@gmail.com>
 <80713dbe-411c-d79b-34ba-b67bc3a50dc5@amd.com>
 <cd94e02c-11c8-0198-ab70-0ceee54d437b@amd.com>
 <aaa2b266-f091-dd9c-e49d-5e528decfbd7@amd.com>
 <a970101f-89f1-8bdf-51d9-4a4e5e0f9e9a@amd.com>
 <ecf465a2-d4fc-1cbf-a9d5-39c3844f23bb@amd.com>
 <2894bf97-8c39-6610-c479-b089c46513e7@amd.com>
 <0224d3c2-1bd0-3941-fa7f-5667027368fa@amd.com>
 <a92e8f96-029f-6d21-4430-7e3116c21dea@amd.com>
 <9ea8f0c1-8d58-f4ab-e2a9-1ef8fd00718c@amd.com>
 <9b9e84ca-b259-b683-ef9d-1f9be95e1734@gmail.com>
 <ae02bdf3-8f4b-ed38-b62d-c3b606554a59@amd.com>
 <8b2db19a-d5f9-a7e3-6662-b990b7b3db2f@amd.com>
 <0fe87232-08ec-d804-ff55-2716b8e09c12@amd.com>
 <e37d6954-46e7-e7eb-22c3-a5b19829fe6c@amd.com>
 <65cd86df-b660-6c8a-348e-d511b61d91d4@amd.com>
 <689099ea-c1e9-31ea-6a5a-070562cb7440@amd.com>
 <b30c75cf-9b00-b52d-1ac1-ccd33e02bfe3@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <3dab0504-b834-add7-1f2f-0237b0f0c20d@amd.com>
Date: Wed, 14 Apr 2021 16:58:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <b30c75cf-9b00-b52d-1ac1-ccd33e02bfe3@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:e9a3:13df:a504:8764]
X-ClientProxiedBy: AM3PR05CA0085.eurprd05.prod.outlook.com
 (2603:10a6:207:1::11) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:e9a3:13df:a504:8764]
 (2a02:908:1252:fb60:e9a3:13df:a504:8764) by
 AM3PR05CA0085.eurprd05.prod.outlook.com (2603:10a6:207:1::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.17 via Frontend Transport; Wed, 14 Apr 2021 14:58:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40db2b1c-19c6-4255-30ec-08d8ff55ce8c
X-MS-TrafficTypeDiagnostic: MN2PR12MB3887:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3887458FE9A80036D1B9A573834E9@MN2PR12MB3887.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c98raGlnr2tRV2HtHsjV3nFlS/ktj3x5Dtbaqx6gFt5K0bhHz36I7fZBxVqy+BamD/I6owCSsHH35vGlpFJKYYn3oaZGa77h5bx10vU2jxd0+xIOvadSmErs4eBh/XDTQHNTK5VE+/2DNsRGNjlzbwDfw7TAFxLDVuwPXsV9YSQL292KoNXn3NX78rBXBvVcRDlGem9s+NnOJIaK/hkPOavcV/1LtBASEFF/Ckl4CFlWc69GhGQB6VYWn96J8dKE7jdM4AxkgdtRaI6XgRt2JGP+GW4+EAyxsPBLSgTMBMnoAjJMiWIZ2qwiJXb+SGNsKvOOkAbO/69VdcQ9A34eTeDstJzvLlYtO3NHVUt1fS6FY3vCPxdhVlwlNFHISpupKc+UuYqHnmrTsJlDfgebAvI1FShECSsnVG+5923yqkthnWr5/K+G8mrOSXdSHHVktrj5D4DbksU9VHDIOKq4vMfliB0Od4kWh4Eg3DG5PIVvlTY84MJ+eNE9T4Cht0olcZaqRl0zV1CyzhZmbegA/kvXgM8Pnr5h5Ek1R8ApcMOs9bn9RjNUuEFPQRXZFs1oB9mRmlpWbMGjx6RlBGG9Fa1zUHPPGKuOcB15mr7k84KQ01DuEn1xf+GJnLc6RM19M8LyO0Ti73aj8IbzGMX59jSIJptD4PPMoq/5LexeE+kFcBVnzou9sBckQ9I7kgp0vQxtxuLFd2RHEezkkx0NS7h/mCg/tO9JVpMzN3HSUa/x329K6zfoWnSGxj59i/BC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(2616005)(316002)(6666004)(38100700002)(110136005)(36756003)(5660300002)(66946007)(66556008)(45080400002)(478600001)(2906002)(16526019)(6486002)(52116002)(66476007)(966005)(31696002)(8676002)(31686004)(8936002)(186003)(921005)(83380400001)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?S1VpbTkranZHeGVMQ0ZNdU9wblV5MmlSOXA0WDU1UWlVMFNIeThZSzRRdXlR?=
 =?utf-8?B?Uk1pdXRRSU1lMGwzcTJOeXhMT2JrTWlWcjBlOWlLUHhYNWlnTXVCL1pzVVJS?=
 =?utf-8?B?U3ovaEc0L2NQeUVZc2tlK2pYOS9yWU9JSGxINHd3THpGWVJQb3BJYkJvd20r?=
 =?utf-8?B?WkNOM25wVVExek5xY3lxVzhsZHYwRUN1VjFtdVhpVUFVT0JPSUUraDRkV0ZW?=
 =?utf-8?B?dmF5K3RxU3N4VUdCSVhZWVQwS1k5aWYxUm80SjBwbHgreFp5RzB4cEtwdysr?=
 =?utf-8?B?M3BOVmUvVWxkTW9YaXVlZzhSZ0tUZnNMWGZ0azZvL0JlUVp3NEZ5Q1cyZ3B1?=
 =?utf-8?B?ZTF1Z21qdXFFSEdxVTh5Z1JYMnI2cnlOY2RJSUxjU21jNGduWFJSMkVUUmI5?=
 =?utf-8?B?ZWV0eFF3WFhDUWp0d2c3eCtPdEdKWWJmcXlUWU9lR0RmS2d2QjVmK1V6bnBq?=
 =?utf-8?B?YkNrMTZDbTJZUGt6NXFIZUdhMGExbkZGRWJVTk1ldmFjK1VVN1ZSS3RTOG52?=
 =?utf-8?B?ZHc2MnQxMjc5eGI1YUlvV1Z6aUJNa08yNUJ4MzRtS0RPdm1PYmgwSFdMb3pQ?=
 =?utf-8?B?OFhTUUpSR0FXL3V3aVBZVU9JNjcxbmRicVF6U1lhZE5xUjBzbS9UL2lMS1o4?=
 =?utf-8?B?NWM4ZldaVmYyS20rSm1lcGlZYzFncjZ5QmVJU0RocnRWa0lNcWkvQmRmbzRp?=
 =?utf-8?B?Y1FFS0hCeGJWbnNtMk1nZFlsSnkzUE5STGFXa0dsYVcwOFc2aXdaZ2doQlpX?=
 =?utf-8?B?RnhPalVFZ0FwYnFHNkYrcTdvZTdySWdRNGgyTGlUbUFmMm8ySW5OODZ5cEda?=
 =?utf-8?B?d0lWM3NnWmE5bXEySHIzSGdrSys5c2xhemZ3M1BkYlRLaTAyVHJDT2E5Yjk0?=
 =?utf-8?B?NSsySENySUZONTZCanpoUFVIRTJzQmF0a1RrR2YxMURwakNSN3VjVG5OVkJL?=
 =?utf-8?B?bHhVbTlUQzBUdE5INitlWmlsWWVnZGhndzUzUkNvMmt2alVmRmV3cEh4dHhY?=
 =?utf-8?B?S2hsejlWcXdTb1RkTkYwbXo4SUphY0pXTWMzbitXTjlkOUFmUkZPTWowYWdi?=
 =?utf-8?B?L3NZaVZyOW5SdWFTUnpSVnMyUWF4bWhVRnZqaXM4ODJzWmMrQytic0lHaCtR?=
 =?utf-8?B?aDE4OVM0b0dmVENBcmkyWW5wa1hPQWZjSlQrZWtLVEVPbXRDNjd0aWp0RDFz?=
 =?utf-8?B?aDdLUDlTSDcxeHN4bTNoa1dTSklJTE9qOGg0RUtrZHlPWXFuVWVpZXFjbHFu?=
 =?utf-8?B?eitOMzRUS0Y3Y2J1MHRMbU1ZZTNLeGxucDhyejVoV09Fa3huZ1BtUllPS3Jv?=
 =?utf-8?B?anpQUndyTXVXS2Z6WXF0TFhkZkhPbjdKemo1dFd0cndwMGltYktPUGluT2E5?=
 =?utf-8?B?WnFPR1dYM1VLbzR5NFg3MWh4V3YvSE1XYmVBa0NmdndIKzRCWVZoN1RJUi9D?=
 =?utf-8?B?RW9XUFZqTzh6Z3FrWGxzdHhMSTMrRUphMEhZUUxvQTVxWTgvN1R1SHZ1RFRz?=
 =?utf-8?B?M3dSa0JTRkJwVDJ5TWJkTVRMcWMyS1V3WVBGSGhYOWxUOTYydTZjQ3Qra1N3?=
 =?utf-8?B?R3oyQnlLTmNabDJVSXFoN1hZZmR1dC9DWENhTUF1SmYxalpZWnlsTzdoc0Yy?=
 =?utf-8?B?VHRyb294VG02YTdINzBCa1lBbitTRzdRN0QrY3Y4SUdDdWpPU0NaZFQ3dngw?=
 =?utf-8?B?eDEzcGhGRUs0SVkvZnhrZDVKN3VzODZUV21sa0pBK3ZqUG9GdVNhTjhzWFU0?=
 =?utf-8?B?QkFLZFgxVWg0UWZUSnJ3a2k4ekx4ZnMrRmZ4dE1LbGtoMHVCWE9OSWZqK25C?=
 =?utf-8?B?MVZSdSs1UDdVOU5hOEhXM21vbnpzQTE4OG1KcHdDQU1IazlvYTJFRmRCajZC?=
 =?utf-8?Q?vFgHPI9sWV/hV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40db2b1c-19c6-4255-30ec-08d8ff55ce8c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2021 14:58:47.8410 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wrgOfSAmTbOho7eWAjq/PwAy8Oqqe8TlwK2ApsL+zSw4ULanruGUkbimjGrQ5BaU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3887
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

QW0gMTQuMDQuMjEgdW0gMTY6MzYgc2NocmllYiBBbmRyZXkgR3JvZHpvdnNreToKPiDCoFtTTklQ
XQo+Pj4+Cj4+Pj4gV2UgYXJlIHJhY2luZyBoZXJlIG9uY2UgbW9yZSBhbmQgbmVlZCB0byBoYW5k
bGUgdGhhdC4KPj4+Cj4+Pgo+Pj4gQnV0IHdoeSwgSSB3cm90ZSBhYm92ZSB0aGF0IHdlIGZpcnN0
IHN0b3AgdGhlIGFsbCBzY2hlZHVsZXJzLCB0aGVuIAo+Pj4gb25seSBjYWxsIGRybV9zY2hlZF9l
bnRpdHlfa2lsbF9qb2JzLgo+Pgo+PiBUaGUgc2NoZWR1bGVycyBjb25zdW1pbmcgam9icyBpcyBu
b3QgdGhlIHByb2JsZW0sIHdlIGFscmVhZHkgaGFuZGxlIAo+PiB0aGF0IGNvcnJlY3QuCj4+Cj4+
IFRoZSBwcm9ibGVtIGlzIHRoYXQgdGhlIGVudGl0aWVzIG1pZ2h0IGNvbnRpbnVlIGZlZWRpbmcg
c3R1ZmYgaW50byAKPj4gdGhlIHNjaGVkdWxlci4KPgo+Cj4gTWlzc2VkIHRoYXQuwqAgT2ssIGNh
biBJIGp1c3QgdXNlIG5vbiBzbGVlcGluZyBSQ1Ugd2l0aCBhIGZsYWcgYXJvdW5kIAo+IGRybV9z
Y2hlZF9lbnRpdHlfcHVzaF9qb2IgYXQgdGhlIGFtZGdwdSBsZXZlbCAob25seSAyIGZ1bmN0aW9u
cyBjYWxsIAo+IGl0IC0gYW1kZ3B1X2NzX3N1Ym1pdCBhbmQgYW1kZ3B1X2pvYl9zdWJtaXQpIGFz
IGEgcHJlbGltaW5hcnkgc3RlcCB0byAKPiBmbHVzaCBhbmQgYmxvY2sgaW4gZmxpZ2h0IGFuZCBm
dXR1cmUgc3VibWlzc2lvbnMgdG8gZW50aXR5IHF1ZXVlID8KCkRvdWJsZSBjaGVja2luZyB0aGUg
Y29kZSBJIHRoaW5rIHdlIGNhbiB1c2UgdGhlIG5vdGlmaWVyX2xvY2sgZm9yIHRoaXMuCgpFLmcu
IGluIGFtZGdwdV9jcy5jIHNlZSB3aGVyZSB3ZSBoYXZlIHRoZSBnb3RvIGVycm9yX2Fib3J0LgoK
VGhhdCBpcyB0aGUgcGxhY2Ugd2hlcmUgc3VjaCBhIGNoZWNrIGNvdWxkIGJlIGFkZGVkIHdpdGhv
dXQgYW55IAphZGRpdGlvbmFsIG92ZXJoZWFkLgoKQ2hyaXN0aWFuLgoKPgo+Cj4+Cj4+Pj4KPj4+
Pj4+Cj4+Pj4+PiBGb3Igd2FpdGluZyBmb3Igb3RoZXIgZGV2aWNlIEkgaGF2ZSBubyBpZGVhIGlm
IHRoYXQgY291bGRuJ3QgCj4+Pj4+PiBkZWFkbG9jayBzb21laG93Lgo+Pj4+Pgo+Pj4+Pgo+Pj4+
PiBZZWEsIG5vdCBzdXJlIGZvciBpbXBvcnRlZCBmZW5jZXMgYW5kIGRtYV9idWZzLCBJIHdvdWxk
IGFzc3VtZSB0aGUgCj4+Pj4+IG90aGVyIGRldmljZXMgc2hvdWxkIG5vdCBiZSBpbXBhY3RlZCBi
eSBvdXIgZGV2aWNlIHJlbW92YWwgYnV0LCAKPj4+Pj4gd2hvIGtub3dzLi4uCj4+Pj4+Cj4+Pj4+
IFNvIEkgZ3Vlc3Mgd2UgYXJlIE5PVCBnb2luZyB3aXRoIGZpbmFsaXppbmcgSFcgZmVuY2VzIGJl
Zm9yZSAKPj4+Pj4gZHJtX2Rldl91bnBsdWcgYW5kIGluc3RlYWQgd2lsbCBqdXN0IGNhbGwgZHJt
X2Rldl9lbnRlci9leGl0IGF0IAo+Pj4+PiB0aGUgYmFjay1lbmRzIGFsbCBvdmVyIHRoZSBwbGFj
ZSB3aGVyZSB0aGVyZSBhcmUgTU1JTyBhY2Nlc3NlcyA/Cj4+Pj4KPj4+PiBHb29kIHF1ZXN0aW9u
LiBBcyB5b3Ugc2FpZCB0aGF0IGlzIHJlYWxseSB0aGUgaGFyZCBwYXRoLgo+Pj4+Cj4+Pj4gSGFu
ZGxpbmcgaXQgYWxsIGF0IG9uY2UgYXQgSU9DVEwgbGV2ZWwgY2VydGFpbmx5IGhhcyBzb21lIGFw
cGVhbCBhcyAKPj4+PiB3ZWxsLCBidXQgSSBoYXZlIG5vIGlkZWEgaWYgd2UgY2FuIGd1YXJhbnRl
ZSB0aGF0IHRoaXMgaXMgbG9jayBmcmVlLgo+Pj4KPj4+Cj4+PiBNYXliZSBqdXN0IGVtcGlyaWNh
bGx5IC0gbGV0J3MgdHJ5IGl0IGFuZCBzZWUgdW5kZXIgZGlmZmVyZW50IHRlc3QgCj4+PiBzY2Vu
YXJpb3Mgd2hhdCBhY3R1YWxseSBoYXBwZW5zwqAgPwo+Pgo+PiBOb3QgYSBnb29kIGlkZWEgaW4g
Z2VuZXJhbCwgd2UgaGF2ZSB0aGF0IGFwcHJvYWNoIHdheSB0byBvZnRlbiBhdCBBTUQgCj4+IGFu
ZCBhcmUgdGhlbiBzdXJwcmlzZWQgdGhhdCBldmVyeXRoaW5nIHdvcmtzIGluIFFBIGJ1dCBmYWls
cyBpbiAKPj4gcHJvZHVjdGlvbi4KPj4KPj4gQnV0IERhbmllbCBhbHJlYWR5IG5vdGVkIGluIGhp
cyByZXBseSB0aGF0IHdhaXRpbmcgZm9yIGEgZmVuY2Ugd2hpbGUgCj4+IGhvbGRpbmcgdGhlIFNS
Q1UgaXMgZXhwZWN0ZWQgdG8gd29yay4KPj4KPj4gU28gbGV0J3Mgc3RpY2sgd2l0aCB0aGUgYXBw
cm9hY2ggb2YgaGlnaCBsZXZlbCBsb2NraW5nIGZvciBob3RwbHVnLgo+Cj4KPiBUbyBteSB1bmRl
cnN0YW5kaW5nIHRoaXMgaXMgdHJ1ZSBmb3Igb3RoZXIgZGV2aXNlcywgbm90IHRoZSBvbmUgYmVp
bmcgCj4gZXh0cmFjdGVkLCBmb3IgaGltIHlvdSBzdGlsbCBuZWVkIHRvIGRvIGFsbCB0aGUgSFcg
ZmVuY2Ugc2lnbmFsbGluZyAKPiBkYW5jZSBiZWNhdXNlIHRoZSBIVyBpcyBnb25lIGFuZCB3ZSBi
bG9jayBhbnkgVERScyAod2hpY2ggd29uJ3QgaGVscCAKPiBhbnl3YXkpLgo+Cj4gQW5kcmV5Cj4K
Pgo+Pgo+PiBDaHJpc3RpYW4uCj4+Cj4+Pgo+Pj4gQW5kcmV5Cj4+Pgo+Pj4KPj4+Pgo+Pj4+IENo
cmlzdGlhbi4KPj4+Pgo+Pj4+Pgo+Pj4+PiBBbmRyZXkKPj4+Pj4KPj4+Pj4+Cj4+Pj4+PiBSZWdh
cmRzLAo+Pj4+Pj4gQ2hyaXN0aWFuLgo+Pj4+Pj4KPj4+Pj4+Pgo+Pj4+Pj4+IEFuZHJleQo+Pj4+
Pj4+Cj4+Pj4+Pj4KPj4+Pj4+Pj4KPj4+Pj4+Pj4KPj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4KPj4+
Pj4+Pj4+Pj4+IEJUVzogQ291bGQgaXQgYmUgdGhhdCB0aGUgZGV2aWNlIFNSQ1UgcHJvdGVjdHMg
bW9yZSB0aGFuIAo+Pj4+Pj4+Pj4+Pj4gb25lIGRldmljZSBhbmQgd2UgZGVhZGxvY2sgYmVjYXVz
ZSBvZiB0aGlzPwo+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+PiBJIGhhdmVuJ3Qg
YWN0dWFsbHkgZXhwZXJpZW5jZWQgYW55IGRlYWRsb2NrIHVudGlsIG5vdyBidXQsIAo+Pj4+Pj4+
Pj4+PiB5ZXMsIGRybV91bnBsdWdfc3JjdSBpcyBkZWZpbmVkIGFzIHN0YXRpYyBpbiBkcm1fZHJ2
LmMgYW5kIAo+Pj4+Pj4+Pj4+PiBzbyBpbiB0aGUgcHJlc2VuY2Ugb2YgbXVsdGlwbGUgZGV2aWNl
cyBmcm9tIHNhbWUgb3IgCj4+Pj4+Pj4+Pj4+IGRpZmZlcmVudCBkcml2ZXJzIHdlIGluIGZhY3Qg
YXJlIGRlcGVuZGVudCBvbiBhbGwgdGhlaXIgCj4+Pj4+Pj4+Pj4+IGNyaXRpY2FsIHNlY3Rpb25z
IGkgZ3Vlc3MuCj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+PiBTaGl0LCB5ZWFoIHRo
ZSBkZXZpbCBpcyBhIHNxdWlycmVsLiBTbyBmb3IgQStJIGxhcHRvcHMgd2UgCj4+Pj4+Pj4+Pj4g
YWN0dWFsbHkgbmVlZCB0byBzeW5jIHRoYXQgdXAgd2l0aCBEYW5pZWwgYW5kIHRoZSByZXN0IG9m
IHRoZSAKPj4+Pj4+Pj4+PiBpOTE1IGd1eXMuCj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+PiBJSVJDIHdl
IGNvdWxkIGFjdHVhbGx5IGhhdmUgYW4gYW1kZ3B1IGRldmljZSBpbiBhIGRvY2tpbmcgCj4+Pj4+
Pj4+Pj4gc3RhdGlvbiB3aGljaCBuZWVkcyBob3RwbHVnIGFuZCB0aGUgZHJpdmVyIG1pZ2h0IGRl
cGVuZCBvbiAKPj4+Pj4+Pj4+PiB3YWl0aW5nIGZvciB0aGUgaTkxNSBkcml2ZXIgYXMgd2VsbC4K
Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gQ2FuJ3Qgd2UgcHJvcG9zZSBhIHBhdGNoIHRv
IG1ha2UgZHJtX3VucGx1Z19zcmN1IHBlciAKPj4+Pj4+Pj4+IGRybV9kZXZpY2UgPyBJIGRvbid0
IHNlZSB3aHkgaXQgaGFzIHRvIGJlIGdsb2JhbCBhbmQgbm90IHBlciAKPj4+Pj4+Pj4+IGRldmlj
ZSB0aGluZy4KPj4+Pj4+Pj4KPj4+Pj4+Pj4gSSdtIHJlYWxseSB3b25kZXJpbmcgdGhlIHNhbWUg
dGhpbmcgZm9yIHF1aXRlIGEgd2hpbGUgbm93Lgo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBBZGRpbmcgRGFu
aWVsIGFzIHdlbGwsIG1heWJlIGhlIGtub3dzIHdoeSB0aGUgZHJtX3VucGx1Z19zcmN1IAo+Pj4+
Pj4+PiBpcyBnbG9iYWwuCj4+Pj4+Pj4+Cj4+Pj4+Pj4+IFJlZ2FyZHMsCj4+Pj4+Pj4+IENocmlz
dGlhbi4KPj4+Pj4+Pj4KPj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiBBbmRyZXkKPj4+Pj4+Pj4+Cj4+Pj4+
Pj4+Pgo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4gQ2hyaXN0aWFuLgo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+
Pj4+IEFuZHJleQo+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+
Pj4+IENocmlzdGlhbi4KPj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4gQW5kcmV5Cj4+Pj4+Pj4+
Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4gQW5kcmV5
Cj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+
Pj4+Pj4+Pj4+IENocmlzdGlhbi4KPj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+PiDC
oMKgwqAgLyogUGFzdCB0aGlzIHBvaW50IG5vIG1vcmUgZmVuY2UgYXJlIHN1Ym1pdHRlZCB0byAK
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gSFcgcmluZyBhbmQgaGVuY2Ugd2UgY2FuIHNhZmVseSBjYWxsIGZv
cmNlIHNpZ25hbCBvbiAKPj4+Pj4+Pj4+Pj4+Pj4+Pj4gYWxsIHRoYXQgYXJlIGN1cnJlbnRseSB0
aGVyZS4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4gwqDCoMKgwqAgKiBBbnkgc3Vic2VxdWVudGx5IGNyZWF0
ZWQgSFcgZmVuY2VzIHdpbGwgYmUgCj4+Pj4+Pj4+Pj4+Pj4+Pj4+IHJldHVybmVkIHNpZ25hbGVk
IHdpdGggYW4gZXJyb3IgY29kZSByaWdodCBhd2F5Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+IMKgwqDCoMKg
ICovCj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+IMKgwqDCoCBmb3JfZWFjaF9y
aW5nKGFkZXYpCj4+Pj4+Pj4+Pj4+Pj4+Pj4+IMKgwqDCoCDCoMKgwqAgYW1kZ3B1X2ZlbmNlX3By
b2Nlc3MocmluZykKPj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4gwqDCoMKgIGRy
bV9kZXZfdW5wbHVnKGRldik7Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+IMKgwqDCoCBTdG9wIHNjaGVkdWxl
cnMKPj4+Pj4+Pj4+Pj4+Pj4+Pj4gwqDCoMKgIGNhbmNlbF9zeW5jKGFsbCB0aW1lcnMgYW5kIHF1
ZXVlZCB3b3Jrcyk7Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+IMKgwqDCoCBod19maW5pCj4+Pj4+Pj4+Pj4+
Pj4+Pj4+IMKgwqDCoCB1bm1hcF9tbWlvCj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+
Pj4+IH0KPj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+
Pj4gQW5kcmV5Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gQWx0ZXJuYXRpdmVseSBncmFiYmlu
ZyB0aGUgcmVzZXQgd3JpdGUgc2lkZSBhbmQgCj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gc3RvcHBp
bmcgYW5kIHRoZW4gcmVzdGFydGluZyB0aGUgc2NoZWR1bGVyIGNvdWxkIAo+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Pj4+IHdvcmsgYXMgd2VsbC4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4+IENocmlzdGlhbi4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gSSBkaWRuJ3QgZ2V0IHRoZSBhYm92ZSBh
bmQgSSBkb24ndCBzZWUgd2h5IEkgbmVlZCAKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+IHRvIHJldXNl
IHRoZSBHUFUgcmVzZXQgcndfbG9jay4gSSByZWx5IG9uIHRoZSBTUkNVIAo+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Pj4gdW5wbHVnIGZsYWcgZm9yIHVucGx1Zy4gQWxzbywgbm90IGNsZWFyIHRvIG1lIHdo
eSAKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+IGFyZSB3ZSBmb2N1c2luZyBvbiB0aGUgc2NoZWR1bGVy
IHRocmVhZHMsIGFueSBjb2RlIAo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gcGF0Y2ggdG8gZ2VuZXJh
dGUgSFcgZmVuY2VzIHNob3VsZCBiZSBjb3ZlcmVkLCBzbyAKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+
IGFueSBjb2RlIGxlYWRpbmcgdG8gYW1kZ3B1X2ZlbmNlX2VtaXQgbmVlZHMgdG8gYmUgCj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4+PiB0YWtlbiBpbnRvIGFjY291bnQgc3VjaCBhcywgZGlyZWN0IElCIHN1
Ym1pc3Npb25zLCAKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+IFZNIGZsdXNoZXMgZS50LmMKPj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gWW91IG5lZWQgdG8gd29yayB0b2dl
dGhlciB3aXRoIHRoZSByZXNldCBsb2NrIAo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiBhbnl3YXksIGNh
dXNlIGEgaG90cGx1ZyBjb3VsZCBydW4gYXQgdGhlIHNhbWUgdGltZSAKPj4+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4gYXMgYSByZXNldC4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+
Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gRm9yIGdvaW5nIG15IHdheSBpbmRlZWQgbm93IEkgc2VlIG5v
dyB0aGF0IEkgaGF2ZSB0byAKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiB0YWtlIHJlc2V0IHdyaXRlIHNp
ZGUgbG9jayBkdXJpbmcgSFcgZmVuY2VzIAo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+IHNpZ25hbGxpbmcg
aW4gb3JkZXIgdG8gcHJvdGVjdCBhZ2FpbnN0IHNjaGVkdWxlci9IVyAKPj4+Pj4+Pj4+Pj4+Pj4+
Pj4+PiBmZW5jZXMgZGV0YWNobWVudCBhbmQgcmVhdHRhY2htZW50IGR1cmluZyBzY2hlZHVsZXJz
IAo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+IHN0b3AvcmVzdGFydC4gQnV0IGlmIHdlIGdvIHdpdGggeW91
ciBhcHByb2FjaCB0aGVuIAo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+IGNhbGxpbmcgZHJtX2Rldl91bnBs
dWcgYW5kIHNjb3BpbmcgCj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gYW1kZ3B1X2pvYl90aW1lb3V0IHdp
dGggZHJtX2Rldl9lbnRlci9leGl0IHNob3VsZCBiZSAKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiBlbm91
Z2ggdG8gcHJldmVudCBhbnkgY29uY3VycmVudCBHUFUgcmVzZXRzIGR1cmluZyAKPj4+Pj4+Pj4+
Pj4+Pj4+Pj4+PiB1bnBsdWcuIEluIGZhY3QgSSBhbHJlYWR5IGRvIGl0IGFueXdheSAtIAo+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9v
ay5jb20vP3VybD1odHRwczolMkYlMkZjZ2l0LmZyZWVkZXNrdG9wLm9yZyUyRn5hZ3JvZHpvdiUy
RmxpbnV4JTJGY29tbWl0JTJGJTNGaCUzRGRybS1taXNjLW5leHQlMjZpZCUzRGVmMGVhNGRkMjll
ZjQ0ZDI2NDljNWVkYTE2YzhmNDg2OWFjYzM2YjEmYW1wO2RhdGE9MDQlN0MwMSU3Q2FuZHJleS5n
cm9kem92c2t5JTQwYW1kLmNvbSU3Q2M3ZmM2Y2I1MDVjMzRhZWRmZTZkMDhkOGZlNGIzOTQ3JTdD
M2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzUzODk0NjMyNDg1
NzM2OSU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9p
VjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MxMDAwJmFtcDtzZGF0YT02
NDM2MlBSQzh4VGdSMlVqMlIyNTZiTWVnVm04WVdxMUtJJTJCQWp6ZVlYdjQlM0QmYW1wO3Jlc2Vy
dmVkPTAgCj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+
Pj4+Pj4+PiBZZXMsIGdvb2QgcG9pbnQgYXMgd2VsbC4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+
Pj4+Pj4+Pj4+Pj4+PiBDaHJpc3RpYW4uCj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gQW5kcmV5Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+
Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+
Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiBDaHJpc3RpYW4uCj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gQW5kcmV5Cj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+
Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiBDaHJpc3Rp
YW4uCj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gQW5kcmV5Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4+PiBBbmRyZXkKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+
Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+
Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Cj4+Pj4+Pgo+Pj4+Cj4+CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
