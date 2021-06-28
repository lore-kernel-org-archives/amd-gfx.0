Return-Path: <SRS0=DKNW=LW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E628C2B9F4
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jun 2021 17:16:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23A0661466
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jun 2021 17:16:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23A0661466
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D58AC6E4DE;
	Mon, 28 Jun 2021 17:16:14 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2F946E4DE
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jun 2021 17:16:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wm2zb1EBG2lp0FiMYGq50KnRjAmHNOwqZcICNg0GI49O+K8kx9Zx+UQon2OKvBwwTeSLzgNe0wfRKz6g9pyoFZCu/wllCATS/aBvLxK0s9NoKse4s1oJOTxKLgMWypLT51JI+04OlE7ZdihYGXQXi+wCgOadxXlNsDbWwTU52CyGuiWFrCwFxLGB7wXN3RDUVzsjIXQ9zeBo2VpI8pcI8G8/UJ/9hq/CkBT8i5Eddus+hxytSt9wYdq8uvxk3MD1UkgsnnAfsQlKfurPW9Fal1yhCslVa4+ZvFIW4vN0j91mLveINtISCgCEUozhU4/twq4rp5o2A8oTZZd4fR6rVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NrEM/XYqTcodbEM43oD0/xrbrjWDG7o/avxJFSt3V0k=;
 b=Ntitu5ACq8BNb4fb3Nb2TqHeunYOW2G04kjOmtMfJJEd5PlTuWlL1nIOz73vbZ3KYs4NKFXIxI+0+q4eWHsfvACwBUiij2+Vh7TPpYp0YwD90Dxp1yzKBfzQC37HGkUDgwc1ApuG223PjyL1Bg1h9/9Z0xc7ms+9y41t+7VWxqWvg+9/eq1N4G/XvooK1L3k49l7KyS/6Fyh+YhoYc3+Bip0vCsk3YL9sLbapy3g6RR40iPucYe688u97EdFh0vmQsK153AF8aDbS5qaLF/duTzoQaGrDG5xnYzQN9yzhGfhRpH9sc9PcMMRrfVWwpmlVvTSwUehOaLHGMebMQF4nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NrEM/XYqTcodbEM43oD0/xrbrjWDG7o/avxJFSt3V0k=;
 b=PNV4OyQczWNwHTB7XeVKWv5usPBuLLXXHJ1Qk+pNmgRintJ55kGisLrrEPAz6r2LPVcC3IEMPX/PHnvEqd+WozZl8HVHW17pBNaD8NJDrOluwsZHtUQ3VjATz4iTwqXjRhM5FOMDauepsaWKohyFtx96Z0ue2lbjTYwtdPmup7Q=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5270.namprd12.prod.outlook.com (2603:10b6:208:31e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Mon, 28 Jun
 2021 17:16:11 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::3c38:805a:5664:9047]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::3c38:805a:5664:9047%3]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 17:16:11 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: =?iso-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>, Alex Deucher
 <alexdeucher@gmail.com>
Subject: Re: AMDGPU error: "[drm:amdgpu_dm_atomic_commit_tail [amdgpu]]
 *ERROR* Waiting for fences timed out!"
Thread-Topic: AMDGPU error: "[drm:amdgpu_dm_atomic_commit_tail [amdgpu]]
 *ERROR* Waiting for fences timed out!"
Thread-Index: AQHXSxtn3GRRwCoppUifUw+oe1BaWarpSPoAgACEooCAALO9gIAAViWAgBi95wCAAFANgIAACeeAgB9IJYCABrSBDQ==
Date: Mon, 28 Jun 2021 17:16:11 +0000
Message-ID: <BL1PR12MB514478C04EC9E42F39F9C8BDF7039@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <a4ba9456-812b-5280-75fd-6dd66d1f9718@riseup.net>
 <22c25fa6-b3eb-b778-8598-3ce1947a3d0b@daenzer.net>
 <CADnq5_OVjssNi2niLZQs-TOyN5T5EFOnpwmpmbvHRgh_M0B=wg@mail.gmail.com>
 <7a9f2682-559d-57ec-4879-b1e6f743c375@daenzer.net>
 <CADnq5_O+FjF0R0OEMyPZ-hzg7d2Fx87NBUjax8_XLF4b71oKmg@mail.gmail.com>
 <7ecaff42-68e4-7566-0da1-fa3475fcacb3@daenzer.net>
 <CADnq5_MEFyQA6s7+4FKKq3qT_6i2ue=n5+CswPpB3H5Kt3ybuw@mail.gmail.com>
 <65f5567e-4c5c-6e20-a379-e7182bcacb1f@daenzer.net>,
 <c2b9b42d-55e1-fa5d-8e10-ea474fcd9221@daenzer.net>
In-Reply-To: <c2b9b42d-55e1-fa5d-8e10-ea474fcd9221@daenzer.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-06-28T17:16:10.790Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: daenzer.net; dkim=none (message not signed)
 header.d=none;daenzer.net; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a89646b-cbc0-4c4a-3637-08d93a586d49
x-ms-traffictypediagnostic: BL1PR12MB5270:
x-microsoft-antispam-prvs: <BL1PR12MB52705C3C431C3E8B4B6C8E7CF7039@BL1PR12MB5270.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tJGHtQuf809sP2KAqDIYFgIF149kb4yh2fFjtoc5OIyM+pbpGPDrEBgC+6U429Y/z2rfCrPAMZtqoYKlozinhT2XEQkw/34z6TivTdntCd5KeHBw1adtQzaL+D5EwiNaoi5ivNIB4W5YkkYuP59KhhXzzdKg1D/7edR+U+6Mkm2fKFAgg+BYekaBZgn/qXDcG22buEhx0cZJvPuSLP5V9K1caVkBSM3kpzlPPiekSc9RSUldo+IBqAoCnAH+mMLfOjKqHrNEZ/Cnzy0twfOf9NJV8ov5dQ/22zo+tn3G2UhOpSoFs/NezB4Fx+vFegB3vCi8/5y8xQOu7PAPp6QmwMh7ACUkxoaVl6cFvYIOnfr8vyZaDr6A8ppnEXoxmjgRdxIizfTj69wEJVP7VOeG9UvcQvQfpkCFVgDbsQ4vRpcgfBEistP5d+MgCMri5Zv02DoGpHvWzlQzcUM8N1+bKzYi3C7/RPF48+Y/+fgrpmzx3aPtLMu9PJoOkIGRVZljgVRfxEkECRGv/MGoscQYRlIfxbKEaZVkPS3cIQgaXsyzN178JfjUSV3DE7HAom8k/lhFqImmn+JG4D1S3KVMVD5+u/ELY8n6Gnk1W5zAY6JmBboNeAI9KfCsqaRpfn9OwjZbiwA7CB827TWkb7jjMkA6MoAmVeu9L/CIz2r3Nq5jFoH4hLPbQUMBulIiiBYZAe/ElhywRwnX8exj+KG979s4ZQpY5shJ9qcJkBivV7PEj5AaRhgdAXBHC+0NndW0lZwRoMPQvAUpuisWP6uqlA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(33656002)(122000001)(71200400001)(478600001)(38100700002)(66574015)(966005)(166002)(55016002)(110136005)(83380400001)(99936003)(9686003)(45080400002)(54906003)(2906002)(52536014)(316002)(86362001)(5660300002)(66446008)(26005)(66616009)(66946007)(76116006)(8676002)(4326008)(66476007)(66556008)(7696005)(64756008)(6506007)(53546011)(8936002)(19627405001)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Fn7LBJ0cfksAEz8iDsrxG3X4wTtEhzri1XYaGt5lwv2JEDv8KVkE5nSWiE?=
 =?iso-8859-1?Q?1vUgNOrujvgxHVmZATKY6KE3eXWBdTUwUcIPzQQSvep81ms6ppCPUVNkFq?=
 =?iso-8859-1?Q?MaFoIcAgQZrrTPJPgVHJOT9+GCwm5RIWPX4Xd+14Ur8b4HrqN8rW52a8l7?=
 =?iso-8859-1?Q?P4PIpp4dRtHVV/GOxFxF6Wa+uxGlvaS0FjfGWncRMdEWco6BVthDaW5wLS?=
 =?iso-8859-1?Q?Ou1sfyKvuauRZaBJfs/OIKyYffZibWXsI5Ld2i4tM/Sc1YTUzT+2D5iEKW?=
 =?iso-8859-1?Q?UajmRmxEkAXGlZyhta3ixQYDjDQ1iIC0cE1GPJ48Vlp2u4nfSOAe8XvEaP?=
 =?iso-8859-1?Q?XaSprC23d6wp/wfmn9qWJ/6ogQZMPtqM8MNRQS/UWfwPOgB3f0KkVt7j9q?=
 =?iso-8859-1?Q?ifijqllnZxeQ3EaVWyyP/7AMgoTAuPaT2nQn/0QROHIAySrc3uoqRs1b8P?=
 =?iso-8859-1?Q?lAQD0isoWVIvFv95J7pQHvA6qXbiwJWE3Wk0357uenmvFHhZlCT+RW7zHF?=
 =?iso-8859-1?Q?7oc0l9we8RGjuF4gC/1IF6/Vlou2PSI3nQJ9lHVDRwPU2nejOzbVLd9W81?=
 =?iso-8859-1?Q?OpHk1iFFH5PyXoH04Nc9EtfY4KzitPbzp5GJvW6urAr8orKhYqYdNLD4ZI?=
 =?iso-8859-1?Q?+WR2+eqhve2poaEEOt4wvU5F2CSdnwl2ePo9CG+UUjugy6SYbgdwlpZJqo?=
 =?iso-8859-1?Q?fzWGskUG2/h2WFV4v8BQ5u3GFa51oiiZmIEZC2U4GS1h4nAYn3D80T37wo?=
 =?iso-8859-1?Q?//hml+6ZnDD59yTEyxqXdMCxolpHJpwhQ/B8Pfpe7LAINAiOdm4JOHDCkY?=
 =?iso-8859-1?Q?5qJl4CQ0Wyne4zR+bl/foilnOUQ9+OWJX3psPEun2pY5ti/wtiPFQNaBpd?=
 =?iso-8859-1?Q?opNliE90i4QAIok6mPsHkkd/1LSWAA9OHpIIQM/z9HwDeR8GIFUit+IvhU?=
 =?iso-8859-1?Q?wjgZha/aVgf+Pul1iBkgK26M2nv9c4IrEg2jZUCUYL54QZpdprceiWI5se?=
 =?iso-8859-1?Q?Bxhdy9YuCg3XokFp8r9dG91YZcv0raJNXtiV4mPSTbtd2t3B/iAnUAmCul?=
 =?iso-8859-1?Q?xc+G5d+uHeC2On/50Bx5RyeWgQ3AFOjPQRE1F5jjYR1gDMzUIq2w0p0qD7?=
 =?iso-8859-1?Q?rrB1DFgzM+F5h3AbNjDpS52Nr45KPKjZD5k9EwsmvwA2/FnBtuFXfrIZut?=
 =?iso-8859-1?Q?BONRrd8YNAUEpURwkfF1yVp/zUpppD+iJxOBt0lGEE8UeHXfiMXKkO4QAP?=
 =?iso-8859-1?Q?lseQa5WzSaaWFbM1PWwPKRmEdtKzYPV7UO3jTnbqb0THfobJQz9IBNPFzS?=
 =?iso-8859-1?Q?T9QPNYndVM0reGg7VkXRN4Yu4ECChG0c9kZOOa+Cxg1hYkcUYmwahbiOPQ?=
 =?iso-8859-1?Q?VIovb+mx84?=
x-ms-exchange-transport-forked: True
Content-Type: multipart/mixed;
 boundary="_004_BL1PR12MB514478C04EC9E42F39F9C8BDF7039BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a89646b-cbc0-4c4a-3637-08d93a586d49
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2021 17:16:11.2562 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CAMt+61Sw6J7f/DF9cxOSx/mBIFcGQHu2nFMMQsEBGSUPFECYvw23TtBKuqfg0J5UIOqhUV83QzLdsjb/IwV8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5270
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
Cc: xgqt <xgqt@riseup.net>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_004_BL1PR12MB514478C04EC9E42F39F9C8BDF7039BL1PR12MB5144namp_
Content-Type: multipart/alternative;
	boundary="_000_BL1PR12MB514478C04EC9E42F39F9C8BDF7039BL1PR12MB5144namp_"

--_000_BL1PR12MB514478C04EC9E42F39F9C8BDF7039BL1PR12MB5144namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[Public]

Thanks for narrowing this down.  There is new PCO SDMA firmware available (=
attached).  Can you try it?

Thanks,

Alex
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Michel D=
=E4nzer <michel@daenzer.net>
Sent: Thursday, June 24, 2021 6:51 AM
To: Alex Deucher <alexdeucher@gmail.com>
Cc: xgqt <xgqt@riseup.net>; amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: AMDGPU error: "[drm:amdgpu_dm_atomic_commit_tail [amdgpu]] *ER=
ROR* Waiting for fences timed out!"

On 2021-06-04 3:08 p.m., Michel D=E4nzer wrote:
> On 2021-06-04 2:33 p.m., Alex Deucher wrote:
>> On Fri, Jun 4, 2021 at 3:47 AM Michel D=E4nzer <michel@daenzer.net> wrot=
e:
>>>
>>> On 2021-05-19 3:57 p.m., Alex Deucher wrote:
>>>> On Wed, May 19, 2021 at 4:48 AM Michel D=E4nzer <michel@daenzer.net> w=
rote:
>>>>>
>>>>> On 2021-05-19 12:05 a.m., Alex Deucher wrote:
>>>>>> On Tue, May 18, 2021 at 10:11 AM Michel D=E4nzer <michel@daenzer.net=
> wrote:
>>>>>>>
>>>>>>> On 2021-05-17 11:33 a.m., xgqt wrote:
>>>>>>>> Hello!
>>>>>>>>
>>>>>>>> I run a AMD laptop "81NC Lenovo IdeaPad S340-15API" - AMD Ryzen 5 =
3500U with Radeon Vega 8 Graphics.
>>>>>>>> Recently some breakages started happening for me. In about 1h afte=
r boot-up while using a KDE desktop machine GUI would freeze. Sometimes it =
would be possible to move the mouse but the rest will be frozen. Screen may=
 start blinking or go black.
>>>>>>>>
>>>>>>>> I'm not sure if this is my kernel, firmware or the hardware.
>>>>>>>> I don't understands dmesg that's why I'm guessing, but I think it =
is the firmware since this behavior started around 2021-05-15.
>>>>>>>> From my Portage logs I see that I updated my firmware on 2021-05-1=
4 at 18:16:06.
>>>>>>>> So breakages started with my kernel: 5.10.27 and FW: 20210511.
>>>>>>>> After breakage I jumped to a older kernel 5.4.97 and compiled 5.12=
.4. I didn't notice a breakage on 5.4.97 but system ran ~40 minutes.
>>>>>>>> So I booted to newly compiled 5.12.4 where I was ~1h and it broke.
>>>>>>>> After that I booted to 5.4.97 again and downgraded my FW.
>>>>>>>> While I'm writing this I'm booted to kernel: 5.12.4 with FW: 20210=
315.
>>>>>>>>
>>>>>>>> I also described my situation on the Gentoo bugzilla: https://nam1=
1.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbugs.gentoo.org%2F7=
90566&amp;data=3D04%7C01%7Calexander.deucher%40amd.com%7C06c9a5296ad74b0cd0=
2408d936fe00bc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637601286843342=
891%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1=
haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D5HKZUabvEZWI%2BzQUBBPWl3Cpiy7Zjs%2Bq=
aKa4XZyNK1g%3D&amp;reserved=3D0
>>>>>>>>
>>>>>>>> "dmesg.log" attached here is from the time machine run fine (at th=
e moment); "errors_sat_may_15_072825_pm_cest_2021.log" is a dmesg log from =
the time system broke
>>>>>>>>
>>>>>>>> Can I get any help with this? What are the next steps I should tak=
e? Any other files I should provide?
>>>>>>>
>>>>>>> I've hit similar hangs with a Lenovo ThinkPad E595 (Ryzen 7 3700U /=
 Picasso / RAVEN 0x1002:0x15D8 0x17AA:0x5124 0xC1). I'm also suspecting the=
m to be firware related. The hangs occurred with firmware from the AMD 20.5=
0 release. I'm currently running with firmware from the 20.40 release, no h=
ang in almost 2 weeks (the hangs happened within 1-2 days after boot).
>>>>>>
>>>>>> Can you narrow down which firmware(s) cause the problem?
>>>>>
>>>>> I'll try, but note I'm not really sure yet my hangs were related to f=
irmware (only). Anyway, I'll try narrowing it down.
>>>>
>>>> Thanks.  Does this patch help?
>>>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpa=
tchwork.freedesktop.org%2Fpatch%2F433701%2F&amp;data=3D04%7C01%7Calexander.=
deucher%40amd.com%7C06c9a5296ad74b0cd02408d936fe00bc%7C3dd8961fe4884e608e11=
a82d994e183d%7C0%7C0%7C637601286843352846%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiM=
C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
=3D1BJky5Nl47A2ytThBe44pAJEHKEARozWTjskAdkK1s8%3D&amp;reserved=3D0
>>>
>>> Unfortunately not. After no hangs for two weeks with older firmware, I =
just got a hang again within a day with newer firmware and a kernel with th=
is fix.
>>>
>>>
>>> I'll try and narrow down which firmware triggers it now. Does Picasso u=
se the picasso_*.bin ones only, or others as well?
>>
>> The picasso ones and raven_dmcu.bin.
>
> Thanks. raven_dmcu.bin hasn't changed, so I'm trying to bisect the 8 Pica=
sso ones which have changed:
>
> picasso_asd.bin
> picasso_ce.bin
> picasso_me.bin
> picasso_mec2.bin
> picasso_mec.bin
> picasso_pfp.bin
> picasso_sdma.bin
> picasso_vcn.bin

Things are pointing to picasso_sdma.bin. I'm currently running with only th=
at one reverted to linux-firmware 20210315, and haven't got any hangs for a=
 week.

Note that I've previously gone for a week without a hang even with firmware=
 which had hung before. So there's still a small chance that I'm just on an=
other lucky run.

That said, Pierre-Eric has also homed in on raven_sdma.bin for similar hang=
s, and reverting to older firmware seems to have helped multiple people on =
bug reports.

So, I think it makes sense for you guys to start looking for what could be =
going wrong with the Picasso/Raven SDMA firmware from 20.50. One thing I no=
ticed is that the SDMA firmware from 20.50 advertises the same feature vers=
ion, but a *lower* firmware version than the one from 18.50. So it might be=
 worth double-checking that there wasn't an accidental downgrade to some ol=
der version.


--
Earthling Michel D=E4nzer               |               https://nam11.safel=
inks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fredhat.com%2F&amp;data=3D0=
4%7C01%7Calexander.deucher%40amd.com%7C06c9a5296ad74b0cd02408d936fe00bc%7C3=
dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637601286843352846%7CUnknown%7CTW=
FpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3=
D%7C1000&amp;sdata=3Da4DpKvRRhPfsEg82S8CWs%2FFORSeK22RPe1Grbbkd8qE%3D&amp;r=
eserved=3D0
Libre software enthusiast             |             Mesa and X developer
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7C06c9a5296ad74b0cd02408d936fe00bc%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637601286843352846%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3Doa3XWhbFjxkpciPx%2BDDcni5fVnkVGGgeRe%2FQimF7vRo%3D&amp;reserved=3D0

--_000_BL1PR12MB514478C04EC9E42F39F9C8BDF7039BL1PR12MB5144namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks for narrowing this down.&nbsp; There is new PCO SDMA firmware availa=
ble (attached).&nbsp; Can you try it?</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Michel D=E4nzer &lt;michel@da=
enzer.net&gt;<br>
<b>Sent:</b> Thursday, June 24, 2021 6:51 AM<br>
<b>To:</b> Alex Deucher &lt;alexdeucher@gmail.com&gt;<br>
<b>Cc:</b> xgqt &lt;xgqt@riseup.net&gt;; amd-gfx list &lt;amd-gfx@lists.fre=
edesktop.org&gt;<br>
<b>Subject:</b> Re: AMDGPU error: &quot;[drm:amdgpu_dm_atomic_commit_tail [=
amdgpu]] *ERROR* Waiting for fences timed out!&quot;</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 2021-06-04 3:08 p.m., Michel D=E4nzer wrote:<br=
>
&gt; On 2021-06-04 2:33 p.m., Alex Deucher wrote:<br>
&gt;&gt; On Fri, Jun 4, 2021 at 3:47 AM Michel D=E4nzer &lt;michel@daenzer.=
net&gt; wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; On 2021-05-19 3:57 p.m., Alex Deucher wrote:<br>
&gt;&gt;&gt;&gt; On Wed, May 19, 2021 at 4:48 AM Michel D=E4nzer &lt;michel=
@daenzer.net&gt; wrote:<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; On 2021-05-19 12:05 a.m., Alex Deucher wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt; On Tue, May 18, 2021 at 10:11 AM Michel D=E4nzer &=
lt;michel@daenzer.net&gt; wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; On 2021-05-17 11:33 a.m., xgqt wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Hello!<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; I run a AMD laptop &quot;81NC Lenovo IdeaP=
ad S340-15API&quot; - AMD Ryzen 5 3500U with Radeon Vega 8 Graphics.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Recently some breakages started happening =
for me. In about 1h after boot-up while using a KDE desktop machine GUI wou=
ld freeze. Sometimes it would be possible to move the mouse but the rest wi=
ll be frozen. Screen may start blinking or go black.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; I'm not sure if this is my kernel, firmwar=
e or the hardware.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; I don't understands dmesg that's why I'm g=
uessing, but I think it is the firmware since this behavior started around =
2021-05-15.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; From my Portage logs I see that I updated =
my firmware on 2021-05-14 at 18:16:06.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; So breakages started with my kernel: 5.10.=
27 and FW: 20210511.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; After breakage I jumped to a older kernel =
5.4.97 and compiled 5.12.4. I didn't notice a breakage on 5.4.97 but system=
 ran ~40 minutes.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; So I booted to newly compiled 5.12.4 where=
 I was ~1h and it broke.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; After that I booted to 5.4.97 again and do=
wngraded my FW.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; While I'm writing this I'm booted to kerne=
l: 5.12.4 with FW: 20210315.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; I also described my situation on the Gento=
o bugzilla: <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=
=3Dhttps%3A%2F%2Fbugs.gentoo.org%2F790566&amp;amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7C06c9a5296ad74b0cd02408d936fe00bc%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637601286843342891%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;=
sdata=3D5HKZUabvEZWI%2BzQUBBPWl3Cpiy7Zjs%2BqaKa4XZyNK1g%3D&amp;amp;reserved=
=3D0">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbugs.ge=
ntoo.org%2F790566&amp;amp;data=3D04%7C01%7Calexander.deucher%40amd.com%7C06=
c9a5296ad74b0cd02408d936fe00bc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7=
C637601286843342891%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2l=
uMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=3D5HKZUabvEZWI%2Bz=
QUBBPWl3Cpiy7Zjs%2BqaKa4XZyNK1g%3D&amp;amp;reserved=3D0</a><br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &quot;dmesg.log&quot; attached here is fro=
m the time machine run fine (at the moment); &quot;errors_sat_may_15_072825=
_pm_cest_2021.log&quot; is a dmesg log from the time system broke<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Can I get any help with this? What are the=
 next steps I should take? Any other files I should provide?<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; I've hit similar hangs with a Lenovo ThinkPad =
E595 (Ryzen 7 3700U / Picasso / RAVEN 0x1002:0x15D8 0x17AA:0x5124 0xC1). I'=
m also suspecting them to be firware related. The hangs occurred with firmw=
are from the AMD 20.50 release. I'm currently running
 with firmware from the 20.40 release, no hang in almost 2 weeks (the hangs=
 happened within 1-2 days after boot).<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Can you narrow down which firmware(s) cause the pr=
oblem?<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; I'll try, but note I'm not really sure yet my hangs we=
re related to firmware (only). Anyway, I'll try narrowing it down.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Thanks.&nbsp; Does this patch help?<br>
&gt;&gt;&gt;&gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/=
?url=3Dhttps%3A%2F%2Fpatchwork.freedesktop.org%2Fpatch%2F433701%2F&amp;amp;=
data=3D04%7C01%7Calexander.deucher%40amd.com%7C06c9a5296ad74b0cd02408d936fe=
00bc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637601286843352846%7CUnkn=
own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXV=
CI6Mn0%3D%7C1000&amp;amp;sdata=3D1BJky5Nl47A2ytThBe44pAJEHKEARozWTjskAdkK1s=
8%3D&amp;amp;reserved=3D0">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatchwo=
rk.freedesktop.org%2Fpatch%2F433701%2F&amp;amp;data=3D04%7C01%7Calexander.d=
eucher%40amd.com%7C06c9a5296ad74b0cd02408d936fe00bc%7C3dd8961fe4884e608e11a=
82d994e183d%7C0%7C0%7C637601286843352846%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC=
4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sda=
ta=3D1BJky5Nl47A2ytThBe44pAJEHKEARozWTjskAdkK1s8%3D&amp;amp;reserved=3D0</a=
><br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Unfortunately not. After no hangs for two weeks with older fir=
mware, I just got a hang again within a day with newer firmware and a kerne=
l with this fix.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I'll try and narrow down which firmware triggers it now. Does =
Picasso use the picasso_*.bin ones only, or others as well?<br>
&gt;&gt;<br>
&gt;&gt; The picasso ones and raven_dmcu.bin.<br>
&gt; <br>
&gt; Thanks. raven_dmcu.bin hasn't changed, so I'm trying to bisect the 8 P=
icasso ones which have changed:<br>
&gt; <br>
&gt; picasso_asd.bin<br>
&gt; picasso_ce.bin<br>
&gt; picasso_me.bin<br>
&gt; picasso_mec2.bin<br>
&gt; picasso_mec.bin<br>
&gt; picasso_pfp.bin<br>
&gt; picasso_sdma.bin<br>
&gt; picasso_vcn.bin<br>
<br>
Things are pointing to picasso_sdma.bin. I'm currently running with only th=
at one reverted to linux-firmware 20210315, and haven't got any hangs for a=
 week.<br>
<br>
Note that I've previously gone for a week without a hang even with firmware=
 which had hung before. So there's still a small chance that I'm just on an=
other lucky run.<br>
<br>
That said, Pierre-Eric has also homed in on raven_sdma.bin for similar hang=
s, and reverting to older firmware seems to have helped multiple people on =
bug reports.<br>
<br>
So, I think it makes sense for you guys to start looking for what could be =
going wrong with the Picasso/Raven SDMA firmware from 20.50. One thing I no=
ticed is that the SDMA firmware from 20.50 advertises the same feature vers=
ion, but a *lower* firmware version
 than the one from 18.50. So it might be worth double-checking that there w=
asn't an accidental downgrade to some older version.<br>
<br>
<br>
-- <br>
Earthling Michel D=E4nzer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"https://nam11.safe=
links.protection.outlook.com/?url=3Dhttps%3A%2F%2Fredhat.com%2F&amp;amp;dat=
a=3D04%7C01%7Calexander.deucher%40amd.com%7C06c9a5296ad74b0cd02408d936fe00b=
c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637601286843352846%7CUnknown=
%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6=
Mn0%3D%7C1000&amp;amp;sdata=3Da4DpKvRRhPfsEg82S8CWs%2FFORSeK22RPe1Grbbkd8qE=
%3D&amp;amp;reserved=3D0">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fredhat.=
com%2F&amp;amp;data=3D04%7C01%7Calexander.deucher%40amd.com%7C06c9a5296ad74=
b0cd02408d936fe00bc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6376012868=
43352846%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTi=
I6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=3Da4DpKvRRhPfsEg82S8CWs%2FFOR=
SeK22RPe1Grbbkd8qE%3D&amp;amp;reserved=3D0</a><br>
Libre software enthusiast&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; Mesa and X developer<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7C06c9a5296ad74b0cd02408d936fe00bc%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637601286843352846%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3Doa3XWhbFjxkpciPx%2BDDcni5fVnkVGGgeRe%2FQimF7vRo%3D&a=
mp;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3D=
https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;=
data=3D04%7C01%7Calexander.deucher%40amd.com%7C06c9a5296ad74b0cd02408d936fe=
00bc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637601286843352846%7CUnkn=
own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXV=
CI6Mn0%3D%7C1000&amp;amp;sdata=3Doa3XWhbFjxkpciPx%2BDDcni5fVnkVGGgeRe%2FQim=
F7vRo%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB514478C04EC9E42F39F9C8BDF7039BL1PR12MB5144namp_--

--_004_BL1PR12MB514478C04EC9E42F39F9C8BDF7039BL1PR12MB5144namp_
Content-Type: application/octet-stream; name="picasso_sdma.bin"
Content-Description: picasso_sdma.bin
Content-Disposition: attachment; filename="picasso_sdma.bin"; size=17408;
	creation-date="Mon, 28 Jun 2021 17:16:00 GMT";
	modification-date="Mon, 28 Jun 2021 17:16:10 GMT"
Content-Transfer-Encoding: base64

AEQAADAAAAABAAAABAABACgAAAAAQwAAAAEAALK6avcpAAAAAAAAAAAQAABAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMblq5im+36vRkGKA+4YpqkkUFMxAEEAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAglOsAN5OToSHCqBxWOc2dQAAAAABAAAAAAAAAAAA
AAAlIAEBAAAAACgAAAD/////AAAAAABDAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAA180xg0eTB9LzkwtpJEOv9y5yvdJMaUfyojDGDiDJAXQAAAAAAAAAAAAAAAAAAAAAA
AAAACAFA0FBSKcgBAJgeAwCAlQIAKAQEAYDOjw8AhPQAGcgtD4CZfAAZyBAAlB3CDECZmwAA0JoA
ANDOCgCEgFEVyAEAWB3OCICVnFEhyAQAJB4CAECWjw4AhPwAGcgeD4CZbQoAhB8HAISZAADQ/QAA
0MgADcgPAMCUwgAAzMkAGMjSCICZxwAAzAEA0BxSAACZAgDQHNcBAJkEANAcZAEAmQgA0BwRAgCZ
EADQHFECAJl8ABnIEACUHZ8MQJnAURHICwAAlYAAEcgAAAAAwAUAlQAAAAAUShnIAAAAAAACqB0D
AICWAAAAAPELAIDOCgCEbAAZyA2mmB0aCYCZFEoZyAAQqB0CAICa4AgAgAUBAMwAgEB8AAAAoGIA
AMwQAIwUwFHBzIEAQNCBAMDMfgAAzO//gJQfBwCEbQoAhMBREcj9/wCZ4AgAgBsAkBQBABAdBgAA
lYBREcgAEDgdAwCAl8hJgc/9AEDQAACAzAEAQMwLAEDMAgBAzAMAQMwEAEDMBQBAzAcAOAQbAJAU
AQAQHQ4AAJkIABQdDwBAmfRJGcgQAJgVAQCcHQsAwJUCAKAdCQAAlsAAAMzJABjIBgCAlcEAQNDg
CACAFQBAzBYAQMwCALgH/wAAzIEAgM/ISRHIABAQJWYIAJn9AADQyEkBzOAIAIAUSjXIAAJ4HwkA
tBcLgEF/qFE1yB8AeBcHgLl9HwC0ER8AWBdnAICVAACAzO8AgMwAAEJ8AQAAzgsAQMwAwEB8AABB
fAIAwMwDAADNBABAzAUAQMz//9QcAEAVfiBKGcgDAJwdEADcBQQAXn0MAOQJAQAoBAPApX4gABhR
IECNfQwAWFUEAJQVBABYEf8AAMzVAADRHwcAhEwBJcgCAGhSAAC3ygAAAAABAGgf+/+AllQBJcgC
AGhSAAC3ygAAAAABAGgf+/+AlkQBJcgCAGhSAACzygAAAAABACwf+//AlgEAjAXZAEDQSAElyFsA
QM5cAMDM5QAAhNkAQNBQASXIWwBAzlwAwMzlAACEQAElyFsAQM5cAMDM5QAAhEwBJcgCAGhSAAC3
ygAAAAABAGgf+/+AllQBJcgCAGhSAACzygAAAAABACgf+/+AlkQBJcgCAGgSAACvygAAAAABAOge
+/+AlgcAc38HwC5/4gDAzgkAAJYggJ19HwcAhOMANMgAAAAA/f9AmwAAAAABACAKowAAgIEAwNHg
CACAAAAAAAAAAAAAAAAAFEolyA4AaBYBAKQe/f9AlgAAAIgAAAAAAIBAfACAQHwAgEB8AIBAfACA
QHwAgEB8gQDA0QcAJAQCAGQS+gAAhOAIAIAAAAAAmwBA0FBSGcgBAJwdBwDAmQEAqCFQUoHOAAAA
AFBSgc0AAAAAAAAAAJsAANAUShnIAAAAAAACqB0QAICaAAAAAIxRGcgAAAAAkFEdyAAAAAAgANRR
IMBZfSBA5X2MUUHNAAAAACAAXFWQUcHNAAAAAAAAAIgAAAAAsFEZyAAAAAAAwKV9sFHBzQAAAAAA
AACIAAAAABRKNcgAAngfCQC0FwuAQX+oUTXIHwB4FweAuX0fALQRHwBYFxAAgJUAAIDMAQBAzACA
Q3wfAJAXAQAQHQIAAJWbAEDQCwCAzwIAQMwDAEDMBABAzAUAQMwHADgEdgAAgAAAAAAAgEB8AIBA
fACAQHwAgEB8AIBAfACAQHyBAMDRBwAkBAIAZBL6AACE4AgAgBsAkBQBABAdBgAAlYBREcgAEDgd
AwCAl8hJgc/9AEDQAACAzAQAQMwFAEDMDQA4BBoAkBQDABAdBAAAlRUAQMwWAEDMAwC4BwBAQ3wG
AEDPAQB0BwAAQ3wHAADP/z8wHwEAMAcSwDZ/GADAzgDAQHwIAMDMBwDwHADAQHwJAMDM/z/cHBAA
2BQjQPN9AMBAfP8H8BwKAMDMAgAAlQDAQHwLAMDMAMBAfCAAVFAgwEx9AEBBfBAAQM0BAGxFEgDa
fiBANn4AwEF8DQDAzQEA2EUSwBl/IADmfSCADn4CAIDOIACoVgMAgM4BAEDMDgAAmRAAFB0MAECZ
9EkZyBAAmBUBAJwdCADAlQIAoB0GAACWwAAAzMkAGMgDAICVwQAA0eAIAID/AADMgQCAz8hJEcgA
EBAlUAcAmf0AANDISQHM4AgAgAAAgMwAwEB8HADcHAIAwJVmAADMIABQUCBADX0AwEB8EwDAzAQA
2BQEAJgRDwDcHAEAQMwAAEF8AQAQBQoAAM0LAADN/wcQHQAAQnwgAGRQIIBifhLAGn0gAN9+AgAw
EyBAF38EAEDPIAB0VwUAQM8SwA59AgD4EiAAq38CAADPIAAwVwMAAM//AADMgQAA0uAIAIAAAIDM
HQCkFADAQHwgAFBQIEAPfQDAQHwJAMDM/z/cHBAA2BQAwEB8CgDAzP8P1BwNANAUAQAoBRIAqn0A
wEJ8BwDAzhgAwM4BAPhGEgB7fSAAMX4gQNF9I4BlfSBAt30CAEDPIAB0VwMAQM8AwEB8IABQUCBA
D30AwEB8DwDAzP8/3BwQANgUAMBAfBAAwMz/D9QcDQDQFAEAEAUSAJJ9AMBCfA0AwM4ZAMDOAQDs
RhIAb30ggDF+IEDZfSMAZn0gQDd+BABAzyAAdFcFAEDPAMBAfBEAwMwAQEF8EgBAzQsAQM30SRnI
EACYFQEAnB0IAMCVAgCgHQYAAJbAAADMyQAYyAMAgJXBAIDQ4AgAgP8AAMyBAEDT4AgAgAAAgMwE
AEDMBQBAzAkAQMwAwEB8/wfQHAoAAM0QAMwU/z/QHAYAAM0BADQFAABDfAcAAM//PzAfAQAwBxLA
Nn8YAMDOAMBAfAgAwMwHAOQcAMBAfCAAUFAgQA99AMBAfA8AwMz/P9wcEADYFADAQHwQAMDM/w/g
HBAA6BQBAKgGAMBCfA0AwM4BAOxGEgAtfhJAqX0gAFN9IMDyfSOA5n4gQLd+AgBAzyAAdFcDAEDP
EQBAzADAQHwSAMDMCwDAzPRJGcgQAJgVAQCcHQgAwJUCAKAdBgAAlsAAAMzJABjIAwCAlcEAANLg
CACA/wAAzIEAgNPgCACAAACAzAIAQMwAwEB8pFIZyAEAkB0IAACVEADQFP//EB0FAACVkFIZyAoA
NBEHAFt/kFIBzwMAwMwJAEDMAMBAfP8H0BwKAADNEADMFP8/0BwGAADNAQA0BQAAQ3wHAADP/z8w
HwEAMAcSwDZ/GADAzggAQMwEAEDMBQBAzA8AQMwAwEB8/wfQHBAAAM0QAMwU/z/QHAwAAM0BADQF
AABDfA0AAM//PzAfAQAwBxLANn8ZAMDODgBAzBEAQMwAwEB8EgDAzAsAwMz0SRnIEACYFQEAnB0K
AMCVAgCgHQgAAJbAAADMyQAYyAUAgJUBACQEBABkEsEAQM7gCACA/wAAzIEAwNPgCACAAACAzAQA
NAQEAEDMBQBAzADAQHwMANAQDAAUFSBAV38BAHQHgQBAzwgA8BQLAADPAgBsEQEAwM4QABwEqQIA
gAAAgMwJADQEBABAzAUAQMwAQEN8BgBAzwEAdAcAAEN8BwAAz/8/MB8BADAHEsA2fxgAwM4IAEDM
CQBAzADAQHwKAMDMCwDAzADAQHwBAMDMIEBPfwEAdAeBAEDPAgDsECQAHATtAIDQ8ABA0PIAANAU
ShnIAAKoHRkAgJqEUQ3IiFEVyCAAUFEgwNB8jFERyJBRFcggAFRRIABRfSAAHX2AUR3IPgDgHQEA
HBYEACAEA8AdfgEA5AkGACV9CADUUCBAUX0gAExVAgBAzQMAwMwBAAwEZwDCzNMCAIC0UQ3IuFEZ
yLBRJcggAF1+IEDRfCAAXFUAgJ19AgBAzQMAgM1tAEDQbgBA0ADAAXwfAKgUAQCoHgUAgJYAUjnI
AAAAANBKgc8AAAAA/wAAzJsAQNBGCgCEbAA5yAymqB88AICa8EkxyAUAKBcBALAeCQAAlwEAqB8H
AICWpFIpyAEAsB4zAACXCACwFgEAMB8wAICaFEoZyBkAmBUBAKgd7f+AlmIAAMzwAADQ7QAA0BRK
GcgAAqgdBgCAmghKKARnAALMjFEgBAAAEcr+AgCAsFEgBAAAEcoMSigECADsEggA7BYEAOxGAACZ
ygDALH0AgIN9DgCTfQIAAJcAgJ99EAD7fAMAAJsAgMB+EgMAgABAw3wAAGnPAYDYfACACH0AQIN8
AABhzwGAkH8CAIgUwFGBzDEKAITAURHI//8AmZsAAMxtAADQ4AgAgAAAAAAfAKgUAQCoHgcAgJbQ
ShnIAAAAAABSgc0AAAAApFIBzAAAAACbAADMbQAA0FkJAIB8CgCEGEoNyBAA0BQBABAd/f8AmQDA
gHwfAMwUAQDMHIEAQNIFAMwQAAKMzAECTMwBAkzMAQJMzAECTMwCAkzMAgJMzAICTMwCAkzM4AgA
gHwKAIQAwIB8HwDMFAEAzByBAEDRBQDMEAMCjMwEAkzMBAJMzAQCTMwEAkzM4AgAgHwKAIQAwIB8
HwDMFAEAzByBAEDQBQDMEAcCjMzgCACAgAoAhADAgHwfAMwUAQDMHIEAQNEFAMwQCAKMzAkCTMwJ
AkzMCQJMzAkCTMzgCACAgAoAhADAgHwfAMwUAQDMHIEAgNAFAMwQBQKMzAYCTMzgCACAgQCA0ahR
GcgBALAdfgAAzDwAAJf//4wdEACQFBAAFBEHwE19qFHBzbRRQcy4UUHMsFEBzAAAQ3y8UQHPPAAA
zADAQHwAAEF8hQAAzDBSwcw0UgHNigAAzH8AAMwHgNJ8JgCAliAAGFEggI19sFEkBB0MAIQOAECV
AFIkBB0MAIQEUiQEHQwAhAhSJAQdDACEDFIkBB0MAIQQUiQEHQwAhBRSJAQdDACEjAoAhP0AQND7
AEDQ9QCA0AIAMBNDAELQRAAC0RAAKAQjAILORQDCzEgAAsxHAALMRgACzWIAAMz9AADQHwcAhBRK
GcgZAJgVAQCQHfz/AJVCAADMGQAAgACAQHwAgEB8AIBAfACAQHwAgEB8iwBA0GIAAMzgCACAQwBC
0EQAAtECAEgUAgCIEEUAgswAwEB88EkZyBAAqB0DAKgWRwCCzkgAQsxGAMLMgQAA0eAIAIDwSRnI
AMBAfIEAgNABAKgdBQCAluAACARQAIDMUQDAzE0KAIRiAADMfgAAzOAIAIAAwEB8AABBfCAAKFEg
wI5+BADoRgBAgX4gAJhWUgDCzFMAAs0AADLIAAAAAB8HAIQAAAAAAAAAACAAeFMggLN/AQC4RwAA
g38gALRXQwBC0EQAAtFHAALQRQDCzEgAAs9GAALNFgcAhJ0MAISBAMDQ4AgAgFUAgMyBAMDQHgCM
FAEAzBxWAEDMVwBAzBRKGcgAAAAAAAKoHQYAgJYAAAAAgAAZyAAAAADjB4CZAAAAAFgAFMgAAAAA
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
JQCCzBcAkBQBABAdnEkxyB8ANBcGQFN/NABAmwDAQHwAAEF8AEBBfACAQXwAwEF8AABCfACAQ3xS
AMLMUwACzQAAMsgAAAAAFgcAhAtAQn0GQHJ+B0BefkMAQtBEAALRRwAC0EUAwsxIAELORgACzRYH
AISdDACEIAAoUSDAjn4EAOhGAMCAfiAAkFZSAMLMUwACzQAAMsgAAAAAFgcAhAtAgn0GQHJ+B0Bi
fkMAQtBEAALRRQDCzEgAQs5GAALNFgcAhJ0MAIQPAICXAQC4CyAAKFEgwI5+BADoRgDAgH4gAJBW
kgcAgACAQHwAgEB8AIBAfACAQHwAgEB8AIBAfACAQHyBAMDR4AgAgF0AgMxeAEDMXwBAzIEAwNDg
CACAQwAC0UQAAtJhAALQRQBCzEYAQsyBAMDQ4AgAgEMAAtFEAALSYQBC0EUAQsxGAELMgQDA0OAI
AIAAABgcgQDA0BRKMcgAAjgfCQCwFwsAA3+oUTXIHwB4FwcAO39oADXICQB4HwAAtC8GADd/AwCA
mQCAQnwAwEF8DgAAl1oAgMzVAIDQWwCAzlwAwM0AAAAAAAAAABRKKcgOALAWAQAoH/v/gJYAAAAA
BgCAlQAAAIhiAADM9wAMBFAAwMxNCgCE4AgAgAABANCbAEDQMAAAzAAAAAB2AADMAAAAADAAQNCb
AADM4AgAgFUIAIRdCACEZwgAhADAQHwAwEB8AMBAfAEADAQBAYDMAADAzAEAQMwLAEDMAgBAzAMA
QMwEAEDMBQBAzP8AAMwAwEB8AMBAfADAQHwAwEB8dggAhIAIAISZCACE4AgAgFUIAIQAwEB8AMBA
fAAAQXwgAChRIECNfgDAQHwAAEF8IAAoUSCAjX4AwEB8AABBfCAAKFEgwI1+AMBAfAAAQXwgAChR
IACOfgDAQHwAAEF8IAAoUSBAjn4AwEB8AMBAfAEALAQggEJ9TAgAhA4AwJYggIJ9TAgAhAsAwJYg
gMJ9TAgAhAgAwJYggAJ+TAgAhAUAwJYggEJ+TAgAhAIAwJY3CACAXQgAhGcIAISACACEmQgAhOAI
AIAIAICWAMCAfiAAkFZSAMLMUwACzRAAKAQiAILOAAAuyAAAAIgEAYDQCACMFAUAwJQUShnIGQCM
FQEA0Bz6/wCVAAAAiAkAjBQDANAcAgAMKQYAwJQfBwCEFEoZyA0AjBUBANAc/P8AlQAAAIgDAULQ
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
AQAYHQUAgJWbAEDQOAFA0BgAFcj//0CVAAAAiBgAFcgSAECVFAEpyA4AgJocASXIDgBAlvoAQNDo
SRnIAgCkIehJQc7EUSnIAAKgHgcAAJokASHI8v8AmiwBHcj6/8CVdgAAzDwBQND6AADQ6EkZyAIA
pB0IAFp+6EkBzgAAAIiPDwCEFAAVyP//QJVZCQCA7Ek5yAAQuB8PAICXgFE9yAEA/B8DAMCXYAoA
hL0PAIAUSj3IGQD4FwEAvB8GAMCXjw8AhBQAFcj//0CV8AAIBOMKAIAAAACI7EkNyBgA0BT/ABAd
AP8UIRAAWBH//8wcBwDZfAAAAADsSQHNAAAAiOxJDcgQANAU/wAQHRgAGBH//8wcBwDZfAAAAADs
SQHNAAAAiAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAxgjuAEcAAABTABAAQwERAJQBEwC5ARQAAAIVAD4CFgB+
ABcAHwEYAIACIACQAiEAJwMxADsDMgBHAzMATwM0AFsDNQBkA0AArANQALoDYADjA3AAxgNxAOoE
gACTBIEAogSCAEIFgwAUBIQA5QWQAAMGoAB2BrAAkQaxAK4GwADNBsEAhAfCACUHwwDHB9AAzAfR
ANMH0gDaB+AA2gXwAMYI+QDGCPgAxgj3AMYI9gDGCPUAxgj0AMYI8wDGCPIABggEAB4IBQD9BwEA
xgjwAMYI8ADGCPAAxgjwAMYI8ADGCPAAxgjwAMYI8ADGCPAAxgjwAMYI8ADGCPAAxgjwAI8lg6HK
22+ylEKPHv+gGTFNsZ03/HuvTtkpd2vbELsnqiRWN1o77zm1cv3VZjAdnMV5iX7k/rDtKn6QlNAF
EaR3u1Rzrux2byroCamEvvyoK7AsaTNxjVRGBFnfx4+iHFMRIW9beeaFShYPyELGg1JwYOzoYqjw
my5sqEWtLBDYa2HZ2hhd1ZDVbZEmsNGwpnHMKROJk8L5spio2dGdL07L8ZwK3nl9QcOo13j697fH
7OijQGHlB7acgYEOOPmYfwdNNIQaAl7+u3BHEbUiL1OA6An3eAjBiISk1m6L12ZUS+dP6/ntYjMD
gAJN0wItdVx4WsiLfoZiHX3zUdNs6rQ=

--_004_BL1PR12MB514478C04EC9E42F39F9C8BDF7039BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_004_BL1PR12MB514478C04EC9E42F39F9C8BDF7039BL1PR12MB5144namp_--
