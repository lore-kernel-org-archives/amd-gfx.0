Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7595EECAAD3
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Sep 2022 03:38:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 111FD10E986;
	Fri,  9 Sep 2022 03:38:09 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62A8710E986
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Sep 2022 03:38:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SR5Ww6W8KS3FvxbPMd+JEuYaDF3l0R7PhukaWy/jaeGT9ANX0pAqRYTaR9I9U6JlhTkemlZLSJQedmPXTWQ0roYKxF+zzTd5YEgXNlJynvZMxOBbeMd1nTwzTDeHNuwvJ3i8YNl4naIGgiTmtZtNrUNMv4Isr06s8k24R8lHKVNwMzebFGBV4Xh4cLj+vy8iau4n1e5IAckPs3seBdIjMAZPPlst3jSRBnFLEScbYMGihbPFxC2WcWFOLSi+X9/wA1snlxCEQwiAPjLEPK6oKXHFTlvHBPn/B3LuDgnIfJ27C5QJe+moY8wJ9Kb0y3STgel+vowkAJoxJykRKwmRRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9WriniJ59cc/tZkLQGaqGlid2+sJscSI21VE55lshMY=;
 b=G6h8AA6onDMl9MKcWZiTxCHJyx8ZlbsE2soHI+3uUGX/eLjBuWdXYFrUkQEClS5QHke6QFF9eC/FUQ7RfUNUjSUddyBZZtE/5VDjkZohQwaotmQST8m9S0mdErqs/hyAMChH8k+A7A0cw+UjHbwb4oUrgLn8BvqUPQwMSJ7FU3JIpYNEG8mUsPhqMwbL0KFdkLACjeHrsJ54vYTFnZtzpO+k1VNJrbXVBqYsEk2y4mCf99ATkS1yEadKGJ9xbwTVApKoS8wQsV1ANEOq5t1nLyssQnyZG4KAUmth4BfQJdv2RqreuZz3mWDE1jQmY0wXvNo1kP6ZUOb9wwnhL0E59w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9WriniJ59cc/tZkLQGaqGlid2+sJscSI21VE55lshMY=;
 b=n4tjpjbKeYjn8apgRyZRZIWmr2OBZ+tWSiWoVFmRbTgyjCW8c2F6cu+8p+i47FhAxTzdLXWNOQYnYLxLNlopvOqb1O399Wcu1E74RhtaGuxLlBk7MM6CArnUn/D/a7Qy4wt7Qt3lY6ugcMbh0bCUDqbBLdEADsWfXwKB6eyPEIY=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by DM6PR12MB4500.namprd12.prod.outlook.com (2603:10b6:5:28f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Fri, 9 Sep
 2022 03:38:02 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::736d:3c73:e9d7:11a8]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::736d:3c73:e9d7:11a8%6]) with mapi id 15.20.5612.012; Fri, 9 Sep 2022
 03:38:01 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Recall: [PATCH v2] drm/amdgpu: change the alignment size of TMR BO to
 1M
Thread-Topic: [PATCH v2] drm/amdgpu: change the alignment size of TMR BO to 1M
Thread-Index: AQHYw/2PlX4xYBOqrUGbqyQ5i2QqdQ==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 35
X-FaxNumberOfPages: 0
Date: Fri, 9 Sep 2022 03:38:01 +0000
Message-ID: <PH7PR12MB5997483DD4D7814F2C05F94782439@PH7PR12MB5997.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|DM6PR12MB4500:EE_
x-ms-office365-filtering-correlation-id: 4e85f008-141e-4ea8-a202-08da9214b274
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VWIyQMw66c0+WAauJIC6JA5ZBMrmtIgnOhJnIrIZEDk5SVi23wl4KD49mmaSybQQkEtm5/X7Wp/snU8vNfLigf+1JDDHnWrOFvW3qRFvHXMoBAVYJNFGVMYnLQBGgZvRzmKA1fNf+hz1547Dn0WhGj4CGLcmUjfP0HM0vq3p9EFHKOZeCTipCZjZt23OZPoan/Mh5j5uZWIeH4TGohhx+JBSMC1k3jDe2XVjGaq1bx7Wp1yXg+ELdnhB/JYEc/0tktzwRyB+iv+n0fZbiE/sZxQ//yonSX4BAM6ZZdYmwjQa/FzLZWnGiXcqx3iEY9ELd1ntOb/igbfkBqZJridv0s8TChMIUjapqCCxAOCZi3Zny/IrAmzMN4xwanFDcE0QO+m7gvFVP1+oTt4w3HUeRhFozu8n93Rqgpw2NqDgGKLX4gRsbkzl/SKhS408GJ/5E3LdxfIviftHNpNoy1Mvb0ODXQEB8U1IHw1NbS6rDABG8xeKMkYUEAaNt+GrREnXKXNEYgN/cU9CKg5ypZB3MFmZWFWNazQ/XfLoAFkiPxobS52e1iEa9QoCldAOGOXBl0Mbt1pqTNVQ0+7bvJhGH1MYO80koSXdZiAIfoq+n/KRRRzAutisLDQQaaI0iP4ayD0Ybl1VM1px1RT/CtRNR7aEzLC6570W+Myqcd+KveHQY6aJ/QM3IyMqysc1m8BfVfqth0wbHZUMGvttJGjbnkzrJ2qDtPvKZSH1EnGOV9KeDqN2ex8zARm6JttQA26crll+4B3y9XzEeUITnCv4fA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(376002)(396003)(346002)(39860400002)(136003)(5660300002)(52536014)(4326008)(66946007)(66556008)(64756008)(8936002)(66476007)(66446008)(8676002)(2906002)(76116006)(7696005)(33656002)(9686003)(6506007)(26005)(558084003)(86362001)(41300700001)(83380400001)(478600001)(186003)(38100700002)(38070700005)(55016003)(54906003)(316002)(6916009)(122000001)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rIQQFrHBLZGA4+HSBUeLmsgTdwuuSZg5nM/WcK92XjXtuF2lyaar1oGL2qbw?=
 =?us-ascii?Q?+Hzh8ybtDzXWkio2dJFQqDgUNBVd5N0pBFVHheu0nsJb5u7fov0CKVF39WU4?=
 =?us-ascii?Q?XAFA5MwfNQNNBWhbyJluvLIM4SP4Huypt6yyO9E8ts43LMRjYXrd4YwYOTjM?=
 =?us-ascii?Q?YYgQwHSwqXo5l4+gMT/rBQ5gXq7DY2Luc2+ZX5xX1pUdfjMgOVJRJkMY9KS7?=
 =?us-ascii?Q?+alqkr/yu/fGazBY0o0MKtsk6JabzfSXydwfe8b257TEm2fZ43KRiKXHLw04?=
 =?us-ascii?Q?4aoX8MJ/opQLMpxT1ZVPw3UJO50vP0lk/YWQ2Saoo4eq82e40Slt3RxWcnCm?=
 =?us-ascii?Q?uYz7YJ51Xd7PkRv0dGR0QASEzo4QT5wMLhg5+WSCLNBzbtR11LAs3k62u0EM?=
 =?us-ascii?Q?+posEbbXjoM19SemhcsKOGDFJwwEKNQddDSCIsmGCjl2p8Fgct9wG1dp4XP7?=
 =?us-ascii?Q?q6QBr/seANrFvjXw0JTZZO1hv52mIVI2rEfUDRmrMu/krJbS+mfWsUf8TY5c?=
 =?us-ascii?Q?HfCcPVGBIQLIozfRk7suli56mw9MP0TjhoyKQRnxvTygCn8jgArQOKcB8kGE?=
 =?us-ascii?Q?LQgt84Luk7KpUAoY9DjRqKmLBAyRZuZVx/eM9v0WkIuREokEhDI+9pH61nkI?=
 =?us-ascii?Q?CHQLArdUMWtq9pSZ6V18oNBJ+IRZQJmlzuKC8wmKNS4H2hkzhHEyNq/THnNB?=
 =?us-ascii?Q?9fj1JgtB9CJ4wxRggbYLgXhntjF/euINAgCLasbqeU8aVvyiWvSGdgzb7yM/?=
 =?us-ascii?Q?PwB7Yw1dweYSIJUOmzm/v3bsBLFq/2y1AFntLxaCeNtHOHOJQ6IUlgb0jp5u?=
 =?us-ascii?Q?K1AAx93dijRGxNIDGC6HQLbanLwyQPazWHZhCUUXENfa0DaJE1WTBgdyEJn+?=
 =?us-ascii?Q?JOsc3KeA16YwlABuE2+I9sjInZaLsbgyrIaWYBNJ15r0CSQQrvJ2mpEMqELb?=
 =?us-ascii?Q?AwigMY+PUPHToa+hhLDk1IsiaKIn3a+iwmQ5eThxPBxOWl3fb6Jn6ldYTWhm?=
 =?us-ascii?Q?g/ewuRZvioaP0kS5SDeTn6VXIlOHc+kTaBEFCb3RYFPgSsVMoz/nyi1j11vQ?=
 =?us-ascii?Q?+uLkvhIQiEHNWBPM1r/P3LJImG+IsZGk/l/wT4DWUxoY79kj3Oifcbzc4pyW?=
 =?us-ascii?Q?XjMDFdvaJky/pMzP3iIZUzLUd8I5rkMFGWyoZm2JAGzpA5905x76Nuj5ZvuN?=
 =?us-ascii?Q?ctzCZz6N2i9bLjntmA9lwESGCs8HB8UUwygIXsns6ksoWarBkxSG79IYCB09?=
 =?us-ascii?Q?J5V1Tcq754MAus57+B9AsWX49MoWeVBf/TCkEGFuTG8enMU2CoGJe9UQv6Hu?=
 =?us-ascii?Q?yDFA7Y+ew84sOXlUN+mJqCcv4F/FOJAVZCpKwt7x+yJYQW8bzUzawqiBkTyr?=
 =?us-ascii?Q?wf8ThseMkD9dVOA8FwElnOvI6AwKlNtDHpvZC/4b5vTJYZom1qgl7YGd+Hr7?=
 =?us-ascii?Q?1Tf4nuLVx+U3BiXHLNlXDQBBvxBoGVzw64vROz+SvrWdQv4CW4lqgNLZVNW6?=
 =?us-ascii?Q?URy+9wqEMLBVhXzyykdxyZ1wNs/j7n8MosbLuRu6zlHKkLUWi5ix7d7JddqM?=
 =?us-ascii?Q?j4jUm4EBZZz5jPglW1Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e85f008-141e-4ea8-a202-08da9214b274
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2022 03:38:01.7179 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8JIss/tDM4mRQiVRnUW3u3jsojRyZZBQurxziM+WsMuUxfNpnpfojH5r/NMWbFr/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4500
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
Cc: "Wang, Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Wang, Yang(Kevin) would like to recall the message, "[PATCH v2] drm/amdgpu:=
 change the alignment size of TMR BO to 1M".=
