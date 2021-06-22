Return-Path: <SRS0=0Dgm=LQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632E3C2B9F4
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 12:23:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D7816023B
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 12:23:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D7816023B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6B5A6E4C9;
	Tue, 22 Jun 2021 12:23:13 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FF9D6E115;
 Tue, 22 Jun 2021 12:23:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFPjYZMxktyr4iFfFKPQ14BqEn5KJRd/Jeo2UjTGL0XUuT6jE9/thgHnYQFdwSzRaPo4l0WDZpimNxyFJkeOEkhApFpeTk6szqNnJU+JHbkwgyZGiwI3t+/zKYWzSMEGfld5kgHEJ0OZdGqBrkZIIB92ZOydF2j4IOuABFzjpcKv2f6hlSsQL25X+8TlUoKGzC/mua90iSnNxcb2jrMpCzXWkW1+ut1KfUz5KdN1VQPYjq37I18EW4TWHVDpqI0CtH3pIZckPMBCeRHFYyM6afzyvZVj863BAn41Y1k7+wTHw0VLcuW+p85kY/EFLnBHtDaJAF2idYjH7ywJ/BSt1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lCilTrr/PTXiFVNnjiuC1HbcRy9y74b7qZEKA6c13A=;
 b=VkOGvw7AnSrALxXf0Wg9Pg1BHAw6ULiO1syNtooFOUBY7nKu5EKy1zmewlxBXU5MXq2D8xznNegH+LdDfu9yptt7PcKlD4ShtchXRCDM9SoJyp0ckoFm3byDTA7zd7XV4W4n+bSp3uLH6Pv6AA33kOiHFk4OWTSyHfnVQrDobY99rUdRNXzGpzYcA1VoMgm4Ko9ROAcWCpQzkd9N+b7HDHKyPwXF7jbnvHniobkv/oaw6YvUuwOLycIOwsUTKD5KeFDcgJ0huLKAsPYte3ZPIBgpoRbpvQ15BTUlTXD9570fPRbXSM4eWQotOsIGrKXXAgSce3NFWD2JFp+cHSSkig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lCilTrr/PTXiFVNnjiuC1HbcRy9y74b7qZEKA6c13A=;
 b=onSA2uBb8uujfCLao/cQYHqgjShm6KDZLIOT4SJVpZuSn2ez3PdAPMHxjhZx1n+2PTmKBfNAslXfUOnyuKpAEPy7kNE3TIMOMC21bMCcdvmZVyh8Gt3gYR+5f4hZ0ZC6OR0nvnDtXRuALZlpDMQ8XaMSWt92y8+7jeoRrqnw4W0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4239.namprd12.prod.outlook.com (2603:10b6:208:1d2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Tue, 22 Jun
 2021 12:23:09 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756%5]) with mapi id 15.20.4242.024; Tue, 22 Jun 2021
 12:23:09 +0000
Subject: Re: [Linaro-mm-sig] [PATCH v3 1/2] habanalabs: define uAPI to export
 FD for DMA-BUF
To: Jason Gunthorpe <jgg@ziepe.ca>, Oded Gabbay <oded.gabbay@gmail.com>
References: <CAKMK7uFOfoxbD2Z5mb-qHFnUe5rObGKQ6Ygh--HSH9M=9bziGg@mail.gmail.com>
 <YNCN0ulL6DQiRJaB@kroah.com> <20210621141217.GE1096940@ziepe.ca>
 <CAFCwf10KvCh0zfHEHqYR-Na6KJh4j+9i-6+==QaMdHHpLH1yEA@mail.gmail.com>
 <20210621175511.GI1096940@ziepe.ca>
 <CAKMK7uEO1_B59DtM7N2g7kkH7pYtLM_WAkn+0f3FU3ps=XEjZQ@mail.gmail.com>
 <CAFCwf11jOnewkbLuxUESswCJpyo7C0ovZj80UrnwUOZkPv2JYQ@mail.gmail.com>
 <20210621232912.GK1096940@ziepe.ca>
 <d358c740-fd3a-9ecd-7001-676e2cb44ec9@gmail.com>
 <CAFCwf11h_Nj_GEdCdeTzO5jgr-Y9em+W-v_pYUfz64i5Ac25yg@mail.gmail.com>
 <20210622120142.GL1096940@ziepe.ca>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <d497b0a2-897e-adff-295c-cf0f4ff93cb4@amd.com>
Date: Tue, 22 Jun 2021 14:23:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210622120142.GL1096940@ziepe.ca>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:9dfd:8ca7:7f8d:67e4]
X-ClientProxiedBy: PR0P264CA0257.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::29)
 To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:9dfd:8ca7:7f8d:67e4]
 (2a02:908:1252:fb60:9dfd:8ca7:7f8d:67e4) by
 PR0P264CA0257.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.18 via Frontend Transport; Tue, 22 Jun 2021 12:23:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba31715c-0957-4656-30ee-08d935787ec2
X-MS-TrafficTypeDiagnostic: MN2PR12MB4239:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB42399E1D4CDFAA65AC9728ED83099@MN2PR12MB4239.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mu/CaM+QsDb2JpDf0b6Uu6SsATB915oNhspeTIVUkQweoU8kkG8qeuI619eSRqLSUnv0sEPATgRhhJSZC868SRAUfer2x3uPA9Gys1tqgnvqh4M6u+9NV5wakqvs7QGdJOpqB7wpOLeGZ0EfTIkzWCVv0zj/OHeCF423L4anykRT4sv7Ic00WaZ9aCXbrBAFy/2oiSzmJOVHvZVQibmjIMpBaQtrZBUdSqshjHwLprX+ZIGD/lLG1j1LUe10y5IMtHHAu/qpQjDVmKvaAyLrFePOkMFT7kgapWquOkDVXhbE36xxrhi+vFz1Iyn17l0EpNTI/6DH9XTYkYkg2ek66W3PJ0gD0AdCg9wX8PnFicHWDO2XgsyOtdtpQwpH/XVIAFN3FeZQ7T17t3DuLu+VI6mW8asOLs9xzVkPD9Lnw2Z4y+ZU6NQBptvkz/21NWZetSB2agKMEmB7dLG6zJtjb7/MaxKx7Gxnf+fH9/J+HXAMNwNaXvrr9lS/ECUcFReAqUyEmqQ+f7p29dg8Y5kbV/cvQPb6yl3RawvZLTK8uaWj2P9+OmIRw9YhOuGaHCePIphXADWGieijRU0OoDBeDX6ouR1mr7f2FKsWHWxVMBsNypx0o37F8lDrgQQB/AA3EkwKETIMz0YEw/l21pBuEsg3o5q7ruHNfhk1tBDPmn6I1lc+hKv2kUcPKG06iNvi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(66574015)(31696002)(110136005)(6666004)(54906003)(4326008)(5660300002)(7416002)(38100700002)(2906002)(83380400001)(31686004)(6486002)(16526019)(66556008)(53546011)(8676002)(86362001)(8936002)(478600001)(66946007)(2616005)(36756003)(316002)(186003)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkdHeElndUs5Q2JzRWhmcStQaFk1R2xEbm9UTVcxT2ZxeElFZmFPcnErdG9N?=
 =?utf-8?B?NmVzd2dQbE02cFFXNEVBclE2aFVOSE80N1RIZTJydlg4RTk4MVhJWGo1cm5x?=
 =?utf-8?B?UzhicUJnMXlBc3RYdUs2YjNkYTRzMkNBclB5Vk91UXNiSU1LZHJPcHNIeE9k?=
 =?utf-8?B?UVpMWTh3RW8wSWJpWldpQVgvRjR3ampMUHRDZ3RJSTdwc0FiUFdxSDl0c2dz?=
 =?utf-8?B?N2w4LzMveC9lRG9Ya3ltQTZjbDRpdXlFdTdrK3hKV0E4ZnA5RGFoZ0VaNDZF?=
 =?utf-8?B?Z2s4cEhWUjlaVG1FTlBYMWNKbS83OFVxejAxOGY0MzZjMFMyZE1rWW9zQ0s4?=
 =?utf-8?B?ZjhRQ0I4Zk9VQ1ZRUEJmczVIRU1LSG1YNkU5ckdzM01Mb0I1eFZkYlR4YjdV?=
 =?utf-8?B?WGI5cExMR1VUdkV3Rll3c09yS2pDUCt4YnNNSld2dHRJOEN6S2NsL0JROEt3?=
 =?utf-8?B?aDlnOVNzK0xOcU9RVGk2UXpvMGdka2dRTnA2YkhjVWY0ZEsxNG1ZemRUUlhj?=
 =?utf-8?B?aTF3OFppNkd2YU1Ra3lTelB5eDRwUEZFZlI1UG43Y2VLellORmdUZHBYa1p0?=
 =?utf-8?B?bHFRdWMyYm1GSmZHNGRGN2lkRWpvcDRIdlZPUldRRzZGYTJkODhnMkkxSmxZ?=
 =?utf-8?B?UGl3YVhRY2xvUExzVG5vYmtyQ2hSNm1XemZKYWpPN1EvYUpPdXcrTHdHYXY1?=
 =?utf-8?B?eWpGK2xGNExPbWNBeGFzNVovVzZld3dSaWpVcXBYYmxkbitpM0NrbnEzS2h6?=
 =?utf-8?B?eUV0bTdFV0NZK1RHd2ZqeE1TWVRsUVBIVS9pYkQ2TWRVa2JoMmdFZHF1N0c4?=
 =?utf-8?B?SzJYNlVvbkViSW9oeVM2N1FqeVQ0NE9SRkNYUEVzdkNQSmxQR2R5MmRvTzVo?=
 =?utf-8?B?WWlldlFkU0FLYVZZN2JNeU9lK05pS3RBVHcvM1ZNWDBhUHlOczJNejVaTjNU?=
 =?utf-8?B?dXcxQS8waUkzSnB3a0RHKzlHNnJDenVPaDRzaHNSL2RCWm8zeDRCNkxtVmI4?=
 =?utf-8?B?YW1Ta1BaQkxpbFIzQXhOMVhKU0g0dmNCVVNPSTh5THVTNHZmRzV0YkYwb0Rl?=
 =?utf-8?B?NmxDM0FoNUc1Mm1tOFcrdjV5M0U0eS9CdTM5dkpGbFVjamt0VHQrekw3Wk90?=
 =?utf-8?B?dEFMaVVPUVR4UW1OaSttVUUxSzFuLzBDVmM2dG9XeWxvcGhwMlo4QXkrdTM0?=
 =?utf-8?B?RUs1WEI4NkZCT2grRUxwTnRTbUtuWTN2WU5XQ1BJR3FYOU9XY09CSnhWMnBL?=
 =?utf-8?B?a0wwOUx3OVdEU2Z2TDJpUkUxWTVobTZLVU4xMU1BbmVuNmd6eVhjeWJxdUVE?=
 =?utf-8?B?bFhVUy9SRmNTRFpWSWlSQUsySWRISE5VdGtJbElqbmRTUWovQkJWeG81NmFF?=
 =?utf-8?B?ZVp3eVNzSTR0ajN2TjYwUnEzNHgvK1g4TzY2TDBNSHRscEcrQlEwalB0RE02?=
 =?utf-8?B?RUx4enZtR20zdzVuZEFnMlVCdy9CM09JMG9xK2QxOGdGSFd2TVNMUk1wN1gr?=
 =?utf-8?B?alVYV1BGbXhrTHM2a0l3eURYRXhzYjdYNWtpVnJJaEJydmJRSUgzNmZuck5P?=
 =?utf-8?B?aFYyZ1AzcW4yZFZ2dEFoREtDT0FFZFNxMnFXK3VUWDZNK2IwQS9FYTRTWWlL?=
 =?utf-8?B?bkhNQnFyTDF2R0E5STkwQ2dRZ1Jub2VQZWV3eDcwWDRzQXRuTWlSVkNkUHFO?=
 =?utf-8?B?eTUxZWpDSjZ2NU9COXBlN1VkUTNTanVZV243Rk9kaXJSRVltckQ4Yk9nc1gr?=
 =?utf-8?B?YVZkR0hNWnlhY1pqNE9kbUtNbEtqWjcrNDFYdEhPOE0reVNzRkp2R0JER1lZ?=
 =?utf-8?B?QVd0S2pGMDRqOC80dTI3UEM3Z1g4RTNmYTFEbndvRVVaVzVBb0Q2aHF4VnpV?=
 =?utf-8?Q?LlzYaW2qxgtVq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba31715c-0957-4656-30ee-08d935787ec2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 12:23:09.1717 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X52Nbfv1pZZ7xped0XVGD23eJOetH8FlvDHHZ05UtGcObTSeHJUC0jvOP7qvBnjh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4239
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
Cc: linux-rdma <linux-rdma@vger.kernel.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 sleybo@amazon.com, Gal Pressman <galpress@amazon.com>,
 dri-devel <dri-devel@lists.freedesktop.org>, Christoph Hellwig <hch@lst.de>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Doug Ledford <dledford@redhat.com>, Tomer Tayar <ttayar@habana.ai>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Greg KH <gregkh@linuxfoundation.org>, Alex Deucher <alexander.deucher@amd.com>,
 Leon Romanovsky <leonro@nvidia.com>, Oded Gabbay <ogabbay@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjIuMDYuMjEgdW0gMTQ6MDEgc2NocmllYiBKYXNvbiBHdW50aG9ycGU6Cj4gT24gVHVlLCBK
dW4gMjIsIDIwMjEgYXQgMTE6NDI6MjdBTSArMDMwMCwgT2RlZCBHYWJiYXkgd3JvdGU6Cj4+IE9u
IFR1ZSwgSnVuIDIyLCAyMDIxIGF0IDk6MzcgQU0gQ2hyaXN0aWFuIEvDtm5pZwo+PiA8Y2tvZW5p
Zy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+IHdyb3RlOgo+Pj4gQW0gMjIuMDYuMjEgdW0gMDE6
Mjkgc2NocmllYiBKYXNvbiBHdW50aG9ycGU6Cj4+Pj4gT24gTW9uLCBKdW4gMjEsIDIwMjEgYXQg
MTA6MjQ6MTZQTSArMDMwMCwgT2RlZCBHYWJiYXkgd3JvdGU6Cj4+Pj4KPj4+Pj4gQW5vdGhlciB0
aGluZyBJIHdhbnQgdG8gZW1waGFzaXplIGlzIHRoYXQgd2UgYXJlIGRvaW5nIHAycCBvbmx5Cj4+
Pj4+IHRocm91Z2ggdGhlIGV4cG9ydC9pbXBvcnQgb2YgdGhlIEZELiBXZSBkbyAqbm90KiBhbGxv
dyB0aGUgdXNlciB0bwo+Pj4+PiBtbWFwIHRoZSBkbWEtYnVmIGFzIHdlIGRvIG5vdCBzdXBwb3J0
IGRpcmVjdCBJTy4gU28gdGhlcmUgaXMgbm8gYWNjZXNzCj4+Pj4+IHRvIHRoZXNlIHBhZ2VzIHRo
cm91Z2ggdGhlIHVzZXJzcGFjZS4KPj4+PiBBcmd1YWJseSBtbWFwaW5nIHRoZSBtZW1vcnkgaXMg
YSBiZXR0ZXIgY2hvaWNlLCBhbmQgaXMgdGhlIGRpcmVjdGlvbgo+Pj4+IHRoYXQgTG9nYW4ncyBz
ZXJpZXMgZ29lcyBpbi4gSGVyZSB0aGUgdXNlIG9mIERNQUJVRiB3YXMgc3BlY2lmaWNhbGx5Cj4+
Pj4gZGVzaWduZWQgdG8gYWxsb3cgaGl0bGVzcyByZXZva2F0aW9uIG9mIHRoZSBtZW1vcnksIHdo
aWNoIHRoaXMgaXNuJ3QKPj4+PiBldmVuIHVzaW5nLgo+Pj4gVGhlIG1ham9yIHByb2JsZW0gd2l0
aCB0aGlzIGFwcHJvYWNoIGlzIHRoYXQgRE1BLWJ1ZiBpcyBhbHNvIHVzZWQgZm9yCj4+PiBtZW1v
cnkgd2hpY2ggaXNuJ3QgQ1BVIGFjY2Vzc2libGUuCj4gVGhhdCBpc24ndCBhbiBpc3N1ZSBoZXJl
IGJlY2F1c2UgdGhlIG1lbW9yeSBpcyBvbmx5IGludGVuZGVkIHRvIGJlCj4gdXNlZCB3aXRoIFAy
UCB0cmFuc2ZlcnMgc28gaXQgbXVzdCBiZSBDUFUgYWNjZXNzaWJsZS4KCk5vLCBlc3BlY2lhbGx5
IFAyUCBpcyBvZnRlbiBkb25lIG9uIG1lbW9yeSByZXNvdXJjZXMgd2hpY2ggYXJlIG5vdCBldmVu
IApyZW1vdGVseSBDUFUgYWNjZXNzaWJsZS4KClRoYXQncyBvbmUgb2YgdGhlIG1ham9yIHJlYXNv
bnMgd2h5IHdlIHVzZSBQMlAgaW4gdGhlIGZpcnN0IHBsYWNlLiBTZWUgCnRoZSB3aG9sZSBYR01J
IGltcGxlbWVudGF0aW9uIGZvciBleGFtcGxlLgoKPiBUaGFua3MgSmFzb24gZm9yIHRoZSBjbGFy
aWZpY2F0aW9uLCBidXQgSSBob25lc3RseSBwcmVmZXIgdG8gdXNlCj4gRE1BLUJVRiBhdCB0aGUg
bW9tZW50Lgo+IEl0IGdpdmVzIHVzIGp1c3Qgd2hhdCB3ZSBuZWVkIChldmVuIG1vcmUgdGhhbiB3
aGF0IHdlIG5lZWQgYXMgeW91Cj4gcG9pbnRlZCBvdXQpLCBpdCBpcyAqYWxyZWFkeSogaW50ZWdy
YXRlZCBhbmQgdGVzdGVkIGluIHRoZSBSRE1BCj4gc3Vic3lzdGVtLCBhbmQgSSdtIGZlZWxpbmcg
Y29tZm9ydGFibGUgdXNpbmcgaXQgYXMgSSdtIHNvbWV3aGF0Cj4gZmFtaWxpYXIgd2l0aCBpdCBm
cm9tIG15IEFNRCBkYXlzLgo+Pj4gVGhhdCB3YXMgb25lIG9mIHRoZSByZWFzb25zIHdlIGRpZG4n
dCBldmVuIGNvbnNpZGVyZWQgdXNpbmcgdGhlIG1hcHBpbmcKPj4+IG1lbW9yeSBhcHByb2FjaCBm
b3IgR1BVcy4KPiBXZWxsLCBub3cgd2UgaGF2ZSBERVZJQ0VfUFJJVkFURSBtZW1vcnkgdGhhdCBj
YW4gbWVldCB0aGlzIG5lZWQKPiB0b28uLiBKdXN0IG5vYm9keSBoYXMgd2lyZWQgaXQgdXAgdG8g
aG1tX3JhbmdlX2ZhdWx0KCkKPgo+Pj4+IFNvIHlvdSBhcmUgdGFraW5nIHRoZSBoaXQgb2YgdmVy
eSBsaW1pdGVkIGhhcmR3YXJlIHN1cHBvcnQgYW5kIHJlZHVjZWQKPj4+PiBwZXJmb3JtYW5jZSBq
dXN0IHRvIHNxdWVlemUgaW50byBETUFCVUYuLgo+IFlvdSBzdGlsbCBoYXZlIHRoZSBpc3N1ZSB0
aGF0IHRoaXMgcGF0Y2ggaXMgZG9pbmcgYWxsIG9mIHRoaXMgUDJQCj4gc3R1ZmYgd3JvbmcgLSBm
b2xsb3dpbmcgdGhlIGFscmVhZHkgTkFLJ2QgQU1EIGFwcHJvYWNoLgoKV2VsbCB0aGF0IHN0dWZm
IHdhcyBOQUtlZCBiZWNhdXNlIHdlIHN0aWxsIHVzZSBzZ190YWJsZXMsIG5vdCBiZWNhdXNlIHdl
IApkb24ndCB3YW50IHRvIGFsbG9jYXRlIHN0cnVjdCBwYWdlcy4KClRoZSBwbGFuIGlzIHRvIHB1
c2ggdGhpcyBmb3J3YXJkIHNpbmNlIERFVklDRV9QUklWQVRFIGNsZWFybHkgY2FuJ3QgCmhhbmRs
ZSBhbGwgb2Ygb3VyIHVzZSBjYXNlcyBhbmQgaXMgbm90IHJlYWxseSBhIGdvb2QgZml0IHRvIGJl
IGhvbmVzdC4KCklPTU1VIGlzIG5vdyB3b3JraW5nIGFzIHdlbGwsIHNvIGFzIGZhciBhcyBJIGNh
biBzZWUgd2UgYXJlIGFsbCBnb29kIGhlcmUuCgo+PiBJJ2xsIGdvIGFuZCByZWFkIExvZ2FuJ3Mg
cGF0Y2gtc2V0IHRvIHNlZSBpZiB0aGF0IHdpbGwgd29yayBmb3IgdXMgaW4KPj4gdGhlIGZ1dHVy
ZS4gUGxlYXNlIHJlbWVtYmVyLCBhcyBEYW5pZWwgc2FpZCwgd2UgZG9uJ3QgaGF2ZSBzdHJ1Y3Qg
cGFnZQo+PiBiYWNraW5nIG91ciBkZXZpY2UgbWVtb3J5LCBzbyBpZiB0aGF0IGlzIGEgcmVxdWly
ZW1lbnQgdG8gY29ubmVjdCB0bwo+PiBMb2dhbidzIHdvcmssIHRoZW4gSSBkb24ndCB0aGluayB3
ZSB3aWxsIHdhbnQgdG8gZG8gaXQgYXQgdGhpcyBwb2ludC4KPiBJdCBpcyB0cml2aWFsIHRvIGdl
dCB0aGUgc3RydWN0IHBhZ2UgZm9yIGEgUENJIEJBUi4KClllYWgsIGJ1dCBpdCBkb2Vzbid0IG1h
a2UgbXVjaCBzZW5zZS4gV2h5IHNob3VsZCB3ZSBjcmVhdGUgYSBzdHJ1Y3QgcGFnZSAKZm9yIHNv
bWV0aGluZyB0aGF0IGlzbid0IGV2ZW4gbWVtb3J5IGluIGEgbG90IG9mIGNhc2VzPwoKUmVnYXJk
cywKQ2hyaXN0aWFuLgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
