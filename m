Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEA6C433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 15:15:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF51E610FA
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 15:15:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF51E610FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83D706E894;
	Tue, 18 May 2021 15:15:14 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2758A6E894;
 Tue, 18 May 2021 15:15:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acM6xhJvIT2sOA+VFf35Yl5DGMiG4jfJ+PDsyiWORGNZlXgA1owQ2Ys7X6tpwwIMw+HCtwnEuVD9Z65TmKN3582xw8P2FwyTU5CG5kkdUL9bdxpJ4qh7GG2AnkqI08wrKmJM2yuAdfDN45Lb9L9QaDWQtRmaoGFHsQzWCnNI5MrXirNuFEuTp4ViyESEKoG6prmrOdrNo8l0J7jmhcUETkM1MVC3d1vk2s0B41294UqhyybKJhA9K2LHtTACiBDsQamDEPCxnj3S4YQLU2SVi/UpiOndfmWptHzoo05S6WJfZl6pdRndUMC54MgX0vPccpkjc8o3T+l/GJ2FcPa/rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MhaYdq9Lu0i4iB20UnPYyzhdXJi/8M39gWlsyJKbJw=;
 b=bfgELP2YcpPLdDJ+afCa9h4Zm9CqRYmGLEZmQNVXGEGXuqp8WkogHmCOkr6vZSPdxzlA46JcIk4uV4DtcDOVHM+DPwtxPS4OPva/mAgjg1tYY0v0ZlPo4DjlyeRbFCUY2tt/Lhk1BwXxa0UgZyZzEYMOXFBac0sj79R7rXFeCI8bXBRNiv2/2hIl4Un1R3u4xyEgb0Kxb2nGIs6rTf08WxnUGNDiGpYu+CqS/3ALaiz+GZdMltB8SQi5oDbcc/BBUKNcuwC8tqlSul0jVn2IpTVz/HJ4PcrqSDQmWMT6URgzyHKZOOcxcqbCL9bo5z/0My9HaKQnlt9od0ernWHCig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MhaYdq9Lu0i4iB20UnPYyzhdXJi/8M39gWlsyJKbJw=;
 b=4mcX+8+ZgcY0xC3LOyvPjrhEk0cmXHKILN03L6HmeBoHvYlV/eoMSZ+3LFAhaW4i08XKeYwaDM7hW8w32CQw+hYR85aQ8gkONmVJVKdu6vGktxh5UAur5crCYTlruIVM3yiOvOT7krmSBxYfEOIwcenQh+tz6iyEZhSSez+YHQ0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2388.namprd12.prod.outlook.com (2603:10b6:207:4a::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Tue, 18 May
 2021 15:15:07 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4129.032; Tue, 18 May 2021
 15:15:07 +0000
Subject: Re: [PATCH v7 13/16] drm/scheduler: Fix hang when sched_entity
 released
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-pci@vger.kernel.org, ckoenig.leichtzumerken@gmail.com,
 daniel.vetter@ffwll.ch, Harry.Wentland@amd.com
References: <20210512142648.666476-1-andrey.grodzovsky@amd.com>
 <20210512142648.666476-14-andrey.grodzovsky@amd.com>
 <9e1270bf-ab62-5d76-b1de-e6cd49dc4841@amd.com>
 <f0c5dea7-af35-9ea5-028e-6286e57a469a@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <34d4e4a8-c577-dfe6-3190-28a5c63a2d23@amd.com>
Date: Tue, 18 May 2021 17:15:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <f0c5dea7-af35-9ea5-028e-6286e57a469a@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:3b27:1830:9671:4cc9]
X-ClientProxiedBy: AM0PR04CA0125.eurprd04.prod.outlook.com
 (2603:10a6:208:55::30) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:3b27:1830:9671:4cc9]
 (2a02:908:1252:fb60:3b27:1830:9671:4cc9) by
 AM0PR04CA0125.eurprd04.prod.outlook.com (2603:10a6:208:55::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25 via Frontend Transport; Tue, 18 May 2021 15:15:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 266c2bcd-eca7-4a99-ba2c-08d91a0fb83a
X-MS-TrafficTypeDiagnostic: BL0PR12MB2388:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2388F300BA60622EAEC35479832C9@BL0PR12MB2388.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: or+PDKiGFZFoCvPG4IUUh0DqXxbNHqSIzcF74597VuNXyeCI9yfCHq84x5s4L5yItjVZvq/vp4v2GgoXvryitS0tWID/uaebMSjH6HT4nu+g5I0L99zhlBXwqjLeRJn8IqUuM4nvaXL1npWaTwt5cCF5JPYou+oo12ovR3VYL6DMMnM7sy83NioXbAEWayCDNk9rybaqUcHyyyjlPd7T6BxFeNvE9IOiIA2CyYGO1Skc+P3G7eDh90LuMRSH5+iZ+4S+IetPNCXCtywix4s1QBNJ8840UXrlxlnKQQNQmcAFaH390cwKpp6s+4uzBtKgFbVaLPEQrZKT6UMZo3hhF48YhSAiS4XTvfkpMoqgjP070FuOK8CgBnaxtbMKlxTvGHv4D6XqA9y3p69T45ppNES4agsafB/Xvt/yEc+J1gmeX4k412gsQ4Wx3nhwOm6PEUsnY9DOPAqk5bYgTGm9iZJvSr2x5psoI8rhwDsGbZbT6sPaoPWFbroifl/W+7XKA3eNxGraJN/R7B/AiuXhmc/TZXvebZN6f52Rb9V5+puLwiilzcKmHnE65+ohYXmRQkMnU2+haWPn3WWfzOWwB59vpHMGTikiGnKLJMdyzKtef6xOGFY1N3A98F/cN8EALhY+Dcg+oBdqwaSkRuXNu4KNBj+L0H7v67UW3nUKNw6vFvtBI9YWsCfqcdGryWU6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(31696002)(53546011)(86362001)(2906002)(6666004)(31686004)(8936002)(478600001)(4326008)(66946007)(66476007)(2616005)(5660300002)(66556008)(8676002)(6636002)(36756003)(316002)(186003)(6486002)(16526019)(66574015)(83380400001)(38100700002)(52116002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZXhlUlpDT3B2a3Bpakg1MzZyZlkxYUx1S3M4TWZOdFBmL3g0MUdPUnhDWVdT?=
 =?utf-8?B?dlEyY0MyN2RrcWFTNHlxWUdON1pWZjJIQ09LVDBXWUZTVHhLL0ZiK0o4em5k?=
 =?utf-8?B?ZG43bDdOZTlJUHBZR0RnMmNPQmhFVGRTWVJybGk4LytYNDdoblFpR0tsRTY4?=
 =?utf-8?B?U2RkakpLZ1VHdFN6cUhBR3hlaTFLNVY0N3pyZGdFL2tqTlIrSWQ4eXk4OFha?=
 =?utf-8?B?WFk2STJDY0lpcG8vRTBydXJPVCt6SG5rVm5TS0Q0Qk80WHBiRUtHNTRkWFNr?=
 =?utf-8?B?QlVKc3pJUDFhbHVPUUw2RUh5Tmx1cGkwb3pBRDQ1UENIYnpGQmJQTXhGckFj?=
 =?utf-8?B?bGxuK29nU0h2MXpZS3FSOHNvdFhQMmFrL1FZNzM5OUQ1Ym1hUXl0NVNyeWo3?=
 =?utf-8?B?RU5zVkVxWFhlRHV0SlBuck0zWkV5L0VFYW5OQ3R4aVZRNUczSlQwREhVK2Zl?=
 =?utf-8?B?S0RSQzJqV0R1REhld2krY1ZXak5lSGNnMlFNOGpObE02ZEduK2dIV1VpazZH?=
 =?utf-8?B?MlhEWmJrbnBPNElYUmQyMWpESHFMVEFHOUkzL1kzZllMcUhDYTcwWWIxVS9N?=
 =?utf-8?B?QlVBc2VlMzVHSkg0SFBLdWdSbEJoNEtLVzNua2h1UzZYelpHRjFZRW1hUC9M?=
 =?utf-8?B?aVd6U1plKzRMOWRmYzdkTWo0NE9JYUJ2bERINEc2aWVJZkpHQ0pYRzlTYlpp?=
 =?utf-8?B?bTYrWGJyNGFDR3FkRXcrWlpReThvZmI4TUxlYU1WUU5wc05sSlEvRkh3YWpi?=
 =?utf-8?B?bUUyTHZYVVdQY1MrbzY2cVI3Q2paaTVXZ2UrYjNDYVd2WmtGRjBRVzcwSWhB?=
 =?utf-8?B?TkordmdLQTM2d0NvaVpmOHZpRVFvR2w2VzhUY2JEZTd0WFp2RTRUUDk1dCty?=
 =?utf-8?B?TlBEOURMYjE1aU1OaStQZnpncUgrVUxwVTRweVdZQVhxQ0RvT05Xc0xKYkE4?=
 =?utf-8?B?QXVHSkVSMkJzbk1nWUc5YjhXZm56dTc5Ykg5NUF3bXU3Q0t4RnhiNmhsakFq?=
 =?utf-8?B?K005d09SQ1FOcjZVa0ZGSWJ6Mzc1Rnk2Z1VXVEVRWUJxSitBaVNlS1JqTW8y?=
 =?utf-8?B?Qll1NlczZEJlajdYaHlPY2R2d0dzcWNRTGZQemJiOExNZmxIOU5zQUhjYWl6?=
 =?utf-8?B?bytXOGtyeFJ5VHFZQUYzTGpDYk80U2RoNEEvc1lqSzU2MEFiUVBHT1Z1Kzhl?=
 =?utf-8?B?WXVzR0h1dDhHRVJxdm5QdXkvLzB0NFg5eHdNdExNR1l5dGUrWDlSSENyN1JX?=
 =?utf-8?B?OHF6MEFTUEwyKzZ6MkNIZStFb2k5YjRRV05yZ3Y2Zk1BdDdOZWUxRVZKYkNR?=
 =?utf-8?B?ZFlseFlIaFg0TjBKVWJucERLNlgyUTFTeFgwWEZFaW1tTFh5QTlBeHZoM0JK?=
 =?utf-8?B?N25ZWnA5ZGQ4aEpXQmt1c1AxaXQ1eHNrR0lGekV2WkxuMVBGanhQTjltd0E4?=
 =?utf-8?B?RURTVFc3MzBHZVdjU213WlFDQ0kyUHdXZk13Q2FtZ3hhbk9oTGV6bXAydWc4?=
 =?utf-8?B?emt5cklWRkZqQ21OS2ZNaGZxUDEyTW5kVERKRFFxN0JiTHo1Z0QxVFNjNUZu?=
 =?utf-8?B?L1Y0NDdoNzhvMUxRZ09veXhlVmZpWVlYdlU3V0xuNlRUVUM5aFAzK0xZQ3BM?=
 =?utf-8?B?YmFiYnNsQTFzekIrNFg2c1hybVlwYVdkeFBKWGhORk00QWpnUUJML0Z2dUEx?=
 =?utf-8?B?YjcyK3JrREVOVE8xK0hGZ3QyeW14OEZ0OU94UDY4dlM1QTRERHJ2K2NaMHl4?=
 =?utf-8?B?V2NOdVFpRFVEM3V2NjlRTXlkblIxQnZ6Y0I2dUd1dHJzc051ZklBaCt3SkVT?=
 =?utf-8?B?SllSVExwTVlRdlN5bTRPUTMvZnZza3F1UUtKWlA0U3F0L2JuV3llelBtTTJl?=
 =?utf-8?Q?sZ+tFlWLmNdq+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 266c2bcd-eca7-4a99-ba2c-08d91a0fb83a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 15:15:06.9232 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y8XSU3OpQ8NEhCZ499rQEUFjM9FfAXYzKiNdLt2/ZnLNUoTnA13tcgnTXMLEgDQ1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2388
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
Cc: Alexander.Deucher@amd.com, gregkh@linuxfoundation.org, ppaalanen@gmail.com,
 helgaas@kernel.org, Felix.Kuehling@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTguMDUuMjEgdW0gMTc6MDMgc2NocmllYiBBbmRyZXkgR3JvZHpvdnNreToKPgo+IE9uIDIw
MjEtMDUtMTggMTA6MDcgYS5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gSW4gYSBzZXBh
cmF0ZSBkaXNjdXNzaW9uIHdpdGggRGFuaWVsIHdlIG9uY2UgbW9yZSBpdGVyYXRlZCBvdmVyIHRo
ZSAKPj4gZG1hX3Jlc3YgcmVxdWlyZW1lbnRzIGFuZCBJIGNhbWUgdG8gdGhlIGNvbmNsdXNpb24g
dGhhdCB0aGlzIGFwcHJvYWNoIAo+PiBoZXJlIHdvbid0IHdvcmsgcmVsaWFibGUuCj4+Cj4+IFRo
ZSBwcm9ibGVtIGlzIGFzIGZvbGxvd2luZzoKPj4gMS4gZGV2aWNlIEEgc2NoZWR1bGVzIHNvbWUg
cmVuZGVyaW5nIHdpdGggaW50byBhIGJ1ZmZlciBhbmQgZXhwb3J0cyAKPj4gaXQgYXMgRE1BLWJ1
Zi4KPj4gMi4gZGV2aWNlIEIgaW1wb3J0cyB0aGUgRE1BLWJ1ZiBhbmQgd2FudHMgdG8gY29uc3Vt
ZSB0aGUgcmVuZGVyaW5nLCAKPj4gZm9yIHRoZSB0aGUgZmVuY2Ugb2YgZGV2aWNlIEEgaXMgcmVw
bGFjZWQgd2l0aCBhIG5ldyBvcGVyYXRpb24uCj4+IDMuIGRldmljZSBCIGlzIGhvdCBwbHVnZ2Vk
IGFuZCB0aGUgbmV3IG9wZXJhdGlvbiBjYW5jZWxlZC9uZXdlciAKPj4gc2NoZWR1bGVkLgo+Pgo+
PiBUaGUgcHJvYmxlbSBpcyBub3cgdGhhdCB3ZSBjYW4ndCBkbyB0aGlzIHNpbmNlIHRoZSBvcGVy
YXRpb24gb2YgCj4+IGRldmljZSBBIGlzIHN0aWxsIHJ1bm5pbmcgYW5kIGJ5IHNpZ25hbGluZyBv
dXIgZmVuY2VzIHdlIHJ1biBpbnRvIHRoZSAKPj4gcHJvYmxlbSBvZiBwb3RlbnRpYWwgbWVtb3J5
IGNvcnJ1cHRpb24uCj4KPgo+IEkgYW0gbm90IHN1cmUgdGhpcyBwcm9ibGVtIHlvdSBkZXNjcmli
ZSBhYm92ZSBpcyByZWxhdGVkIHRvIHRoaXMgcGF0Y2guCgpXZWxsIGl0IGlzIGtpbmQgb2YgcmVs
YXRlZC4KCj4gSGVyZSB3ZSBwdXJlbHkgZXhwYW5kIHRoZSBjcml0ZXJpYSBmb3Igd2hlbiBzY2hl
ZF9lbnRpdHkgaXMKPiBjb25zaWRlcmVkIGlkbGUgaW4gb3JkZXIgdG8gcHJldmVudCBhIGhhbmcg
b24gZGV2aWNlIHJlbW92ZS4KCkFuZCBleGFjdGx5IHRoYXQgaXMgcHJvYmxlbWF0aWMuIFNlZSB0
aGUgam9icyBvbiB0aGUgZW50aXR5IG5lZWQgdG8gCmNsZWFubHkgd2FpdCBmb3IgdGhlaXIgZGVw
ZW5kZW5jaWVzIGJlZm9yZSB0aGV5IGNhbiBiZSBjb21wbGV0ZWQuCgpkcm1fc2NoZWRfZW50aXR5
X2tpbGxfam9icygpIGlzIGFsc28gbm90IGhhbmRsaW5nIHRoYXQgY29ycmVjdGx5IGF0IHRoZSAK
bW9tZW50LCB3ZSBvbmx5IHdhaXQgZm9yIHRoZSBsYXN0IHNjaGVkdWxlZCBmZW5jZSBidXQgbm90
IGZvciB0aGUgCmRlcGVuZGVuY2llcyBvZiB0aGUgam9iLgoKPiBXZXJlIHlvdSBhZGRyZXNzaW5n
IHRoZSBwYXRjaCBmcm9tIHllc3RlcmRheSBpbiB3aGljaCB5b3UgY29tbWVudGVkCj4gdGhhdCB5
b3UgZm91bmQgYSBwcm9ibGVtIHdpdGggaG93IHdlIGZpbmlzaCBmZW5jZXMgPyBJdCB3YXMKPiAn
W1BBVENIIHY3IDEyLzE2XSBkcm0vYW1kZ3B1OiBGaXggaGFuZyBvbiBkZXZpY2UgcmVtb3ZhbC4n
Cj4KPiBBbHNvLCBpbiB0aGUgcGF0Y2ggc2VyaWVzIGFzIGl0IGlzIG5vdyB3ZSBvbmx5IHNpZ25h
bCBIVyBmZW5jZXMgZm9yIHRoZQo+IGV4dHJhY3RlZCBkZXZpY2UgQiwgd2UgYXJlIG5vdCB0b3Vj
aGluZyBhbnkgb3RoZXIgZmVuY2VzLiBJbiBmYWN0IGFzIHlvdQo+IG1heSByZW1lbWJlciwgSSBk
cm9wcGVkIGFsbCBuZXcgbG9naWMgdG8gZm9yY2luZyBmZW5jZSBjb21wbGV0aW9uIGluCj4gdGhp
cyBwYXRjaCBzZXJpZXMgYW5kIG9ubHkgY2FsbCBhbWRncHVfZmVuY2VfZHJpdmVyX2ZvcmNlX2Nv
bXBsZXRpb24KPiBmb3IgdGhlIEhXIGZlbmNlcyBvZiB0aGUgZXh0cmFjdGVkIGRldmljZSBhcyBp
dCdzIGRvbmUgdG9kYXkgYW55d2F5LgoKU2lnbmFsaW5nIGhhcmR3YXJlIGZlbmNlcyBpcyB1bnBy
b2JsZW1hdGljIHNpbmNlIHRoZXkgYXJlIGVtaXR0ZWQgd2hlbiAKdGhlIHNvZnR3YXJlIHNjaGVk
dWxpbmcgaXMgYWxyZWFkeSBjb21wbGV0ZWQuCgpDaHJpc3RpYW4uCgo+Cj4gQW5kcmV5Cj4KPj4K
Pj4gTm90IHN1cmUgaG93IHRvIGhhbmRsZSB0aGF0IGNhc2UuIE9uZSBwb3NzaWJpbGl0eSB3b3Vs
ZCBiZSB0byB3YWl0IAo+PiBmb3IgYWxsIGRlcGVuZGVuY2llcyBvZiB1bnNjaGVkdWxlZCBqb2Jz
IGJlZm9yZSBzaWduYWxpbmcgdGhlaXIgCj4+IGZlbmNlcyBhcyBjYW5jZWxlZC4KPj4KPj4gQ2hy
aXN0aWFuLgo+Pgo+PiBBbSAxMi4wNS4yMSB1bSAxNjoyNiBzY2hyaWViIEFuZHJleSBHcm9kem92
c2t5Ogo+Pj4gUHJvYmxlbTogSWYgc2NoZWR1bGVyIGlzIGFscmVhZHkgc3RvcHBlZCBieSB0aGUg
dGltZSBzY2hlZF9lbnRpdHkKPj4+IGlzIHJlbGVhc2VkIGFuZCBlbnRpdHkncyBqb2JfcXVldWUg
bm90IGVtcHR5IEkgZW5jb3VudHJlZAo+Pj4gYSBoYW5nIGluIGRybV9zY2hlZF9lbnRpdHlfZmx1
c2guIFRoaXMgaXMgYmVjYXVzZSAKPj4+IGRybV9zY2hlZF9lbnRpdHlfaXNfaWRsZQo+Pj4gbmV2
ZXIgYmVjb21lcyBmYWxzZS4KPj4+Cj4+PiBGaXg6IEluIGRybV9zY2hlZF9maW5pIGRldGFjaCBh
bGwgc2NoZWRfZW50aXRpZXMgZnJvbSB0aGUKPj4+IHNjaGVkdWxlcidzIHJ1biBxdWV1ZXMuIFRo
aXMgd2lsbCBzYXRpc2Z5IGRybV9zY2hlZF9lbnRpdHlfaXNfaWRsZS4KPj4+IEFsc28gd2FrZXVw
IGFsbCB0aG9zZSBwcm9jZXNzZXMgc3R1Y2sgaW4gc2NoZWRfZW50aXR5IGZsdXNoaW5nCj4+PiBh
cyB0aGUgc2NoZWR1bGVyIG1haW4gdGhyZWFkIHdoaWNoIHdha2VzIHRoZW0gdXAgaXMgc3RvcHBl
ZCBieSBub3cuCj4+Pgo+Pj4gdjI6Cj4+PiBSZXZlcnNlIG9yZGVyIG9mIGRybV9zY2hlZF9ycV9y
ZW1vdmVfZW50aXR5IGFuZCBtYXJraW5nCj4+PiBzX2VudGl0eSBhcyBzdG9wcGVkIHRvIHByZXZl
bnQgcmVpbnNlcmlvbiBiYWNrIHRvIHJxIGR1ZQo+Pj4gdG8gcmFjZS4KPj4+Cj4+PiB2MzoKPj4+
IERyb3AgZHJtX3NjaGVkX3JxX3JlbW92ZV9lbnRpdHksIG9ubHkgbW9kaWZ5IGVudGl0eS0+c3Rv
cHBlZAo+Pj4gYW5kIGNoZWNrIGZvciBpdCBpbiBkcm1fc2NoZWRfZW50aXR5X2lzX2lkbGUKPj4+
Cj4+PiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgR3JvZHpvdnNreSA8YW5kcmV5Lmdyb2R6b3Zza3lA
YW1kLmNvbT4KPj4+IFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+Cj4+PiAtLS0KPj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2No
ZWRfZW50aXR5LmMgfMKgIDMgKystCj4+PiDCoCBkcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3Nj
aGVkX21haW4uY8KgwqAgfCAyNCAKPj4+ICsrKysrKysrKysrKysrKysrKysrKysrKwo+Pj4gwqAg
MiBmaWxlcyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Pgo+Pj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfZW50aXR5LmMgCj4+
PiBiL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfZW50aXR5LmMKPj4+IGluZGV4IDAy
NDljNzQ1MDE4OC4uMmU5M2U4ODFiNjVmIDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYwo+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3NjaGVk
dWxlci9zY2hlZF9lbnRpdHkuYwo+Pj4gQEAgLTExNiw3ICsxMTYsOCBAQCBzdGF0aWMgYm9vbCBk
cm1fc2NoZWRfZW50aXR5X2lzX2lkbGUoc3RydWN0IAo+Pj4gZHJtX3NjaGVkX2VudGl0eSAqZW50
aXR5KQo+Pj4gwqDCoMKgwqDCoCBybWIoKTsgLyogZm9yIGxpc3RfZW1wdHkgdG8gd29yayB3aXRo
b3V0IGxvY2sgKi8KPj4+IMKgwqDCoMKgwqAgaWYgKGxpc3RfZW1wdHkoJmVudGl0eS0+bGlzdCkg
fHwKPj4+IC3CoMKgwqDCoMKgwqDCoCBzcHNjX3F1ZXVlX2NvdW50KCZlbnRpdHktPmpvYl9xdWV1
ZSkgPT0gMCkKPj4+ICvCoMKgwqDCoMKgwqDCoCBzcHNjX3F1ZXVlX2NvdW50KCZlbnRpdHktPmpv
Yl9xdWV1ZSkgPT0gMCB8fAo+Pj4gK8KgwqDCoMKgwqDCoMKgIGVudGl0eS0+c3RvcHBlZCkKPj4+
IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gdHJ1ZTsKPj4+IMKgwqDCoMKgwqAgcmV0dXJuIGZh
bHNlOwo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFp
bi5jIAo+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX21haW4uYwo+Pj4gaW5k
ZXggOGQxMjExZTg3MTAxLi5hMmE5NTM2OTNiNDUgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vc2NoZWR1bGVyL3NjaGVkX21haW4uYwo+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3Nj
aGVkdWxlci9zY2hlZF9tYWluLmMKPj4+IEBAIC04OTgsOSArODk4LDMzIEBAIEVYUE9SVF9TWU1C
T0woZHJtX3NjaGVkX2luaXQpOwo+Pj4gwqDCoCAqLwo+Pj4gwqAgdm9pZCBkcm1fc2NoZWRfZmlu
aShzdHJ1Y3QgZHJtX2dwdV9zY2hlZHVsZXIgKnNjaGVkKQo+Pj4gwqAgewo+Pj4gK8KgwqDCoCBz
dHJ1Y3QgZHJtX3NjaGVkX2VudGl0eSAqc19lbnRpdHk7Cj4+PiArwqDCoMKgIGludCBpOwo+Pj4g
Kwo+Pj4gwqDCoMKgwqDCoCBpZiAoc2NoZWQtPnRocmVhZCkKPj4+IMKgwqDCoMKgwqDCoMKgwqDC
oCBrdGhyZWFkX3N0b3Aoc2NoZWQtPnRocmVhZCk7Cj4+PiArwqDCoMKgIGZvciAoaSA9IERSTV9T
Q0hFRF9QUklPUklUWV9DT1VOVCAtIDE7IGkgPj0gCj4+PiBEUk1fU0NIRURfUFJJT1JJVFlfTUlO
OyBpLS0pIHsKPj4+ICvCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgZHJtX3NjaGVkX3JxICpycSA9ICZz
Y2hlZC0+c2NoZWRfcnFbaV07Cj4+PiArCj4+PiArwqDCoMKgwqDCoMKgwqAgaWYgKCFycSkKPj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnRpbnVlOwo+Pj4gKwo+Pj4gK8KgwqDCoMKgwqDC
oMKgIHNwaW5fbG9jaygmcnEtPmxvY2spOwo+Pj4gK8KgwqDCoMKgwqDCoMKgIGxpc3RfZm9yX2Vh
Y2hfZW50cnkoc19lbnRpdHksICZycS0+ZW50aXRpZXMsIGxpc3QpCj4+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAvKgo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIFByZXZlbnRzIHJl
aW5zZXJ0aW9uIGFuZCBtYXJrcyBqb2JfcXVldWUgYXMgaWRsZSwKPj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgKiBpdCB3aWxsIHJlbW92ZWQgZnJvbSBycSBpbiBkcm1fc2NoZWRfZW50aXR5
X2ZpbmkKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBldmVudHVhbGx5Cj4+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgICovCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzX2Vu
dGl0eS0+c3RvcHBlZCA9IHRydWU7Cj4+PiArwqDCoMKgwqDCoMKgwqAgc3Bpbl91bmxvY2soJnJx
LT5sb2NrKTsKPj4+ICsKPj4+ICvCoMKgwqAgfQo+Pj4gKwo+Pj4gK8KgwqDCoCAvKiBXYWtldXAg
ZXZlcnlvbmUgc3R1Y2sgaW4gZHJtX3NjaGVkX2VudGl0eV9mbHVzaCBmb3IgdGhpcyAKPj4+IHNj
aGVkdWxlciAqLwo+Pj4gK8KgwqDCoCB3YWtlX3VwX2FsbCgmc2NoZWQtPmpvYl9zY2hlZHVsZWQp
Owo+Pj4gKwo+Pj4gwqDCoMKgwqDCoCAvKiBDb25maXJtIG5vIHdvcmsgbGVmdCBiZWhpbmQgYWNj
ZXNzaW5nIGRldmljZSBzdHJ1Y3R1cmVzICovCj4+PiDCoMKgwqDCoMKgIGNhbmNlbF9kZWxheWVk
X3dvcmtfc3luYygmc2NoZWQtPndvcmtfdGRyKTsKPj4KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeAo=
