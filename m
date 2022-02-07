Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E4DC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Feb 2022 14:45:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E26F310E271;
	Mon,  7 Feb 2022 14:45:21 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2067.outbound.protection.outlook.com [40.107.95.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 290C810E271
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Feb 2022 14:45:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHc2M584fWwp8J8kESLdbqlv8Bqx/lwzqte9YduVntEzeckujSo628e6QSvIHJaYwanA0TqIqbvaoImKaBEMGxSDj8tuiYIcFpPh/7teIb80bIsAcdlgWSXcpzm/VOkLe4w63PVzYBrcIL9xhIwDxpl1JdaD7zAQwmqrjr6kDwjRwQgUSjTYdwS/BUkYj5KuOEGbJD1pZF9aXsIgi39VFKC5T9SXE/l+NZ5iyt21BncHNJ4mIQAzXZPvoZa5FQ7HYkFLC4A1uWS4wWc2E1XaGpraDFCDuEUaL/Q+y3NhQ1TqPqFbSc43bpHtSsBHWlGQtu3ePkJ2IVc/rKvmxWjNuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CfsVtC7KERAwvh0YvyVDVxuKV+R5d23qsQpbtPrOr20=;
 b=YuWR/9yVRC4rk8YjuRvkOl4yjUUajpbKKVwLKiFifIaNjdnCdEATN0oxTJx/EoFJb97eLlzFBUWoAQNbXKzjRFoTOb3ZO4Dx4i/Z5lyEws9OT4JGd6CXNQdZWfuzWkB+spN5ujHtkTU5vQSVTNxLTUm7pd6IP3FgceTcRpi6Z9xUXBv0bmi/U8tfu88Y+qYfQ0m6iEIVyyMDBOgqsbiD+jQjrzq5AeEhkB66jwxzXOgdzeIuSZg6DyDa1105iWudVZPyNsCShdMmZO8YGsCS0ddgA5Ws3MPKMM/mQBG8SJtxSoMb2s59J31lXqSjQGaono1ARlVCxwHua+IKhnQljA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfsVtC7KERAwvh0YvyVDVxuKV+R5d23qsQpbtPrOr20=;
 b=jY6mzxwPnFBY/42msJg17mJEPdUPXb9GPh1hboD4BTk6E2fY93+edd7seXuCciQJsjLdVm7ZooLKxtuRKFBWe/+m5EXZhXe4B71qIFWylxj7Nmpq3PqqzqWx9hXw9Dk7+VcOocmxExVG5gzfuMo8i6TR7A4xTlFu0PriLLiwOKM=
Received: from DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18)
 by DM6PR12MB3948.namprd12.prod.outlook.com (2603:10b6:5:1c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Mon, 7 Feb
 2022 14:45:19 +0000
Received: from DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::2c:40ad:b492:a81a]) by DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::2c:40ad:b492:a81a%5]) with mapi id 15.20.4951.019; Mon, 7 Feb 2022
 14:45:18 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Dhillon, Jasdeep" <Jasdeep.Dhillon@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/14] DC Patchset, Feb 7 2022 v2
Thread-Topic: [PATCH 00/14] DC Patchset, Feb 7 2022 v2
Thread-Index: AQHYGjLNqq4BpvMKHk6S2cpNi8qQkqyILgmA
Date: Mon, 7 Feb 2022 14:45:18 +0000
Message-ID: <DM6PR12MB3529B219321CB4FBCAD9412C9C2C9@DM6PR12MB3529.namprd12.prod.outlook.com>
References: <20220205015029.143768-1-jdhillon@amd.com>
In-Reply-To: <20220205015029.143768-1-jdhillon@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-02-07T14:44:47Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=002a50c5-7a2f-4bb7-aaa9-9199b7c21b96;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-02-07T14:45:17Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 5e361e3e-9d34-4dc7-afd7-8024213fbc1c
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 136777db-8818-4f03-8fd6-08d9ea48761e
x-ms-traffictypediagnostic: DM6PR12MB3948:EE_
x-microsoft-antispam-prvs: <DM6PR12MB39480AEDC1A82F341130D0379C2C9@DM6PR12MB3948.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nB8yoROc5yGzKlL2yAyJkjUkvqwSkyiqBKAGqhfwWu/YkozAeDYOwQSQ3tcOEd2Wjry0eSVRmfQTLFzECG5s4v9E/AgJnOIVxwNgZ0p3lZAe3hW1tVI7yABzft2yohDxfYJwZS/HJvV/EHm0n3Z6NJfRbZvs9bpf88Ee0/cROtKsI5wytWP0TugN0jhz/xFb55TazkdhtkxkTV0Zx8jqpdiHyWdgs5tr4umvjIlapSDKTOUtYX1gaRbkW+hRYw0jvWTqWhRv6UpNaURLHjkGq0JBWQMgTu7zptwzslYCxpi65ujav0mlXQ4b0GHZnnhtFxk9ZxC1QzTRonh99WvQMNNiHVITZz2M26uGxJIFZbBqWYROWqdmd3BxuLF4xg1zbSfZcHR44Ur3CzA+nWNyLuPFdyqjFMkFSkx8k0FbO3Qy3VFe7oNebvzP5crhXKRfaVlbCHstlXSd3zNUBxFmmBCVbt7QNZWAOFt80o/KCJz31DXP16edrVWzX74fPOZtiBeWJ2yqKB6/sUO8iJp1nWM2/vyOgmvSNJw0kBNKN29yNTXBwWJ0hPh+hKPXDSVqNQzKM1GglvnLjU1p/rm0Zn64xVnZpfmaUPr1RKcgmOMmz42X6gXYqODISiHqSBIUNU/T8HtYld8sVuwQGzvFJcR4o9mKJAE62MlByZfyfjb9iS5oCQvNS0xuKe67BmkcZn9uTd3EhTSyO2Djv0UiCA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(110136005)(54906003)(186003)(66556008)(316002)(53546011)(86362001)(8676002)(76116006)(66446008)(4326008)(64756008)(66946007)(8936002)(2906002)(26005)(6506007)(7696005)(33656002)(71200400001)(66476007)(122000001)(52536014)(9686003)(508600001)(5660300002)(38100700002)(83380400001)(55016003)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3lWZWZYUHcxK1JjazE3V04xbGl3dllIRnd0OHNCZkRCcFA5UmNDUVk1Z2xl?=
 =?utf-8?B?eVVJZzdHSWFVelNLQ3pKaU9xbzlKQUpXaE9qaFQ1aDYySmNyYWxBeDNQMjF6?=
 =?utf-8?B?NlV5cFhCN1NvQ0ExTTZJMFd5d1F3RE5XT2RhbUhPNUhRZzZ4bXFwMFNLeUhk?=
 =?utf-8?B?UDAwOVNuQzl1TmEraVIzbGFDb25KMzdCcVk3K3BzOVRqUkkvN1dWSFhnSmZj?=
 =?utf-8?B?b3N3U0kvVXNBOGFzb1RDMGs1TmRXOVNlNGF3N3R3QlU5ZUxGellvbnRiN1Rl?=
 =?utf-8?B?dFc5bFkvMGpxT2p1SmZ2R3VoaTFBRHYvNmJKamVFZm1aWEl5SC9yUTkrcFVH?=
 =?utf-8?B?cUNpc21ETzlXN2VZYXA1TnJxY3RlNE5aZ1E0NG51L2duT1grUnhxSHVZaVoy?=
 =?utf-8?B?TjRjUVh4ZjdqS1ZnTVZTN1JVU0tTeFR5bmwvYy9GaSs1cExTTFlLeDE3TUlU?=
 =?utf-8?B?cDRUWlIwdVA5cUtFMW1ybE5meDFMb1ZRSjZsSXVONFUxaDg0ZzVpbkRjaFlY?=
 =?utf-8?B?akcxeEovYnJoWUxzc0tOZlVmNVJhMnBqYkRBTVpVYzdoOVllK21QMjNxWEhL?=
 =?utf-8?B?NFNEa3RGUzNzVW9kRXZ1ZyswM3RsdW8xaEVUQVU4TDJEVXUvS0tTaExoUVlU?=
 =?utf-8?B?ZUNsMjFiNEVQcUdQSVBSTmRVRGtvbTJkZmt1VlEwWC9NVHlldkxDNjdUdHNp?=
 =?utf-8?B?dGhXRUErelIwSjZMNmxZTmNOTWgzSWJvL0JOaFZJSithZjhObW1mRVp2NkNN?=
 =?utf-8?B?ZkZXNjV1OGdsSy9mQmJjc1FJYVJHZkxpSU43bHBZejhBaVNhLzdjTVRNNVFQ?=
 =?utf-8?B?UWNHcTBhTWl2RUdJcUs2SzN1WXBpcVVQeGlOTG1ZM1huUC83UFV6YnpURGE3?=
 =?utf-8?B?dnl5Mk5hVnQyWm1ZZ1EzRnlTa0M3cXpKR0V0bTVoM3AzOXdOZDJXY295NXY5?=
 =?utf-8?B?eHJad21KeVQyVmYvK3NaUzdBWFJYYU9FKzdkZmJVMTNEc1FWZFhFckNWcHFU?=
 =?utf-8?B?K0JCQWJZSTNneXBUVWVmWEVJVlhaT3BQdTkrYjBJYUdpUDRZS2RkVkxnNytw?=
 =?utf-8?B?Y2hidHZXcENVOTJrRDJqRVNPeGhQdXVhMmdIMDRnSnFzOE5WUWdINmxSNG9T?=
 =?utf-8?B?d3F4MEpGNzQ1ZTkyZXRNR05VdHVEbjJZdWFtYjIweERFMUxuc3RTK3dQSmFj?=
 =?utf-8?B?d1ptaXd5WjRUYXhDY1kyblJENXRoRXNwSFdQN1VvNEUxZ2JnYnFYMVRFUDhv?=
 =?utf-8?B?aVBrbkhCdXBPUkE5d1RwL3Fvdk9lclFGeG41bU5OWkxVMHRYaGc2NDltbDR4?=
 =?utf-8?B?QnNQRCtIbjhJNGIrZ3RuTmpKeUJad2xKaXZwalZPVy9IUFZEMEdVVnhWN2VB?=
 =?utf-8?B?WUtwaEUyWmdhWEovZVZXYmE2eXZ5UitIa1JzK3JncmZSRVBta0VnUHlDZU00?=
 =?utf-8?B?RVhwMTE2TW0rUXZ6Ri9NcHNzMkd4TWw2Y3d2aW50UTFwR21kTGlKcWs0OVhG?=
 =?utf-8?B?blBUS3pxWkd6ekJxTUlGbzlab0V1em9MTG9NRWwxM1BsQUtkS2hMeFY1MWFh?=
 =?utf-8?B?Y2RBWXQzbmxtV1ZXeitRNXZGd0JCUjZKVnFZMTdwWHJvZ1RYVWEzdVB3aWZp?=
 =?utf-8?B?WkVFeTNSeTFVNUt5V2NKeTVyUS9ocGc3UGZNcGN5OXpVc3lZckQvVDVtT1ds?=
 =?utf-8?B?dmIvU0Q4RVFORHBMWWdyVEt2YTYxWWpQL0VwREJHSDVVOUNNOTgrb3o0R3VX?=
 =?utf-8?B?RFZyL21hVHMvN2IxWksvcXEwY203S1EyNEJNQ3h3MnA5M1c4RU5MWDY5c2lL?=
 =?utf-8?B?VWQ5QWZJZFEybWZxZTQ1aE1GYlVTZlNHOVJWc2gwTUJSYWRabmxrdGhaZUkx?=
 =?utf-8?B?ZlpheG1IbDJDSlVHZE9ROU5LMVVDaWN2UnF4dkl1N0E5VG5QTHZ0M3cvRUVF?=
 =?utf-8?B?S0wvVzFrM0NBK0ZyMUFPbXIrZ3hWaEJoSzgwOU85QmpPTDhFZURRcVBmMlZX?=
 =?utf-8?B?NGtHVzNkZjBXd2NvdGxDS2I3dVNiNlJmUC9hZTI4NlB0Q3ppeTMvYXpYMTRh?=
 =?utf-8?B?SG9xTnplR3ZCbzk5SXFsZnNxZWFNK1k4RGl5NU8vYVQreFlkUFpSNWxlYjMx?=
 =?utf-8?B?SlBlZzR2bXZUK01wL09Id3RBemtLWjZ1NkRVei9QaGN1ekpkTGdUVlVUaThy?=
 =?utf-8?Q?RCSnihExZMBVqN8jfzvvr/4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 136777db-8818-4f03-8fd6-08d9ea48761e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2022 14:45:18.8020 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z+4ISIoZE+VbO9/uo5TL6z5O7sFx9KFpNq+ZdLG2zOQA5zQYo/lGucY8Br7RNiQJzP5C+fXwagfSG84zchXQZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3948
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Zhuo, 
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Chiu,
 Solomon" <Solomon.Chiu@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>,
 "Dhillon, Jasdeep" <Jasdeep.Dhillon@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KSGkgYWxsLA0KIA0KVGhpcyB3ZWVrIHRoaXMgcGF0Y2hzZXQgd2FzIHRlc3Rl
ZCBvbiB0aGUgZm9sbG93aW5nIHN5c3RlbXM6DQogDQpIUCBFbnZ5IDM2MCwgd2l0aCBSeXplbiA1
IDQ1MDBVLCB3aXRoIHRoZSBmb2xsb3dpbmcgZGlzcGxheSB0eXBlczogZURQIDEwODBwIDYwaHos
IDRrIDYwaHogICh2aWEgVVNCLUMgdG8gRFAvSERNSSksIDE0NDBwIDE0NGh6ICh2aWEgVVNCLUMg
dG8gRFAvSERNSSksIDE2ODAqMTA1MCA2MGh6ICh2aWEgVVNCLUMgdG8gRFAgYW5kIHRoZW4gRFAg
dG8gRFZJL1ZHQSkNCiANCkxlbm92byBUaGlua3BhZCBUMTRzIEdlbjIgd2l0aCBBTUQgUnl6ZW4g
NSA1NjUwVSwgd2l0aCB0aGUgZm9sbG93aW5nIGRpc3BsYXkgdHlwZXM6IGVEUCAxMDgwcCA2MGh6
LCA0ayA2MGh6ICAodmlhIFVTQi1DIHRvIERQL0hETUkpLCAxNDQwcCAxNDRoeiAodmlhIFVTQi1D
IHRvIERQL0hETUkpLCAxNjgwKjEwNTAgNjBoeiAodmlhIFVTQi1DIHRvIERQIGFuZCB0aGVuIERQ
IHRvIERWSS9WR0EpDQogDQpTYXBwaGlyZSBQdWxzZSBSWDU3MDBYVCB3aXRoIHRoZSBmb2xsb3dp
bmcgZGlzcGxheSB0eXBlczoNCjRrIDYwaHogICh2aWEgRFAvSERNSSksIDE0NDBwIDE0NGh6ICh2
aWEgRFAvSERNSSksIDE2ODAqMTA1MCA2MGh6ICh2aWEgRFAgdG8gRFZJL1ZHQSkNCiANClJlZmVy
ZW5jZSBBTUQgUlg2ODAwIHdpdGggdGhlIGZvbGxvd2luZyBkaXNwbGF5IHR5cGVzOg0KNGsgNjBo
eiAgKHZpYSBEUC9IRE1JIGFuZCBVU0ItQyB0byBEUC9IRE1JKSwgMTQ0MHAgMTQ0aHogKHZpYSBV
U0ItQyB0byBEUC9IRE1JIGFuZCBVU0ItQyB0byBEUC9IRE1JKSwgMTY4MCoxMDUwIDYwaHogKHZp
YSBEUCB0byBEVkkvVkdBKQ0KIA0KSW5jbHVkZWQgdGVzdGluZyB1c2luZyBhIFN0YXJ0ZWNoIERQ
IDEuNCBNU1QgaHViIGF0IDJ4IDRrIDYwaHosIGFuZCAzeCAxMDgwcCA2MGh6IG9uIGFsbCBzeXN0
ZW1zLiBBbHNvIHRlc3RlZCBEU0MgdmlhIFVTQi1DIHRvIERQIERTQyBIdWIgd2l0aCAzeCA0ayA2
MGh6IG9uIFJ5emVuIDkgNTkwMGggYW5kIFJ5emVuIDUgNDUwMHUuDQogDQpUZXN0ZWQgb24gVWJ1
bnR1IDIwLjA0LjMgd2l0aCBLZXJuZWwgVmVyc2lvbiA1LjEzIGFuZCBDaHJvbWVPUw0KIA0KVGVz
dGVkLWJ5OiBEYW5pZWwgV2hlZWxlciA8ZGFuaWVsLndoZWVsZXJAYW1kLmNvbT4NCiANCiANClRo
YW5rIHlvdSwNCiANCkRhbiBXaGVlbGVyDQpUZWNobm9sb2dpc3QgIHwgIEFNRA0KU1cgRGlzcGxh
eQ0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQoxIENvbW1lcmNlIFZhbGxleSBEciBFLCBUaG9ybmhpbGwsIE9OIEwzVCA3WDYNCkZhY2Vi
b29rIHwgIFR3aXR0ZXIgfCAgYW1kLmNvbSAgDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQpGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBP
biBCZWhhbGYgT2YgSmFzZGVlcCBEaGlsbG9uDQpTZW50OiBGZWJydWFyeSA0LCAyMDIyIDg6NTAg
UE0NClRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IFdhbmcsIENoYW8ta2Fp
IChTdHlsb24pIDxTdHlsb24uV2FuZ0BhbWQuY29tPjsgTGksIFN1biBwZW5nIChMZW8pIDxTdW5w
ZW5nLkxpQGFtZC5jb20+OyBXZW50bGFuZCwgSGFycnkgPEhhcnJ5LldlbnRsYW5kQGFtZC5jb20+
OyBaaHVvLCBRaW5ncWluZyAoTGlsbGlhbikgPFFpbmdxaW5nLlpodW9AYW1kLmNvbT47IERoaWxs
b24sIEphc2RlZXAgPEphc2RlZXAuRGhpbGxvbkBhbWQuY29tPjsgU2lxdWVpcmEsIFJvZHJpZ28g
PFJvZHJpZ28uU2lxdWVpcmFAYW1kLmNvbT47IExpLCBSb21hbiA8Um9tYW4uTGlAYW1kLmNvbT47
IENoaXUsIFNvbG9tb24gPFNvbG9tb24uQ2hpdUBhbWQuY29tPjsgUGlsbGFpLCBBdXJhYmluZG8g
PEF1cmFiaW5kby5QaWxsYWlAYW1kLmNvbT47IExpbiwgV2F5bmUgPFdheW5lLkxpbkBhbWQuY29t
PjsgTGFraGEsIEJoYXdhbnByZWV0IDxCaGF3YW5wcmVldC5MYWtoYUBhbWQuY29tPjsgR3V0aWVy
cmV6LCBBZ3VzdGluIDxBZ3VzdGluLkd1dGllcnJlekBhbWQuY29tPjsgS290YXJhYywgUGF2bGUg
PFBhdmxlLktvdGFyYWNAYW1kLmNvbT4NClN1YmplY3Q6IFtQQVRDSCAwMC8xNF0gREMgUGF0Y2hz
ZXQsIEZlYiA3IDIwMjIgdjINCg0KVGhpcyBEQyBwYXRjaHNldCBicmluZ3MgaW1wcm92ZW1lbnRz
IGluIG11bHRpcGxlIGFyZWFzLiBJbiBzdW1tYXJ5LCB3ZSBoYXZlOg0KLWZpeCBmb3IgYnVpbGQg
ZmFpbHVyZSB1bmluaXRhbGl6ZWQgZXJyb3IgLUJ1ZyBmaXggZm9yIERQMiB1c2luZyB1bmNlcnRp
ZmllZCBjYWJsZSAtbGltaXQgdW5ib3VuZGVkIHJlcXVlc3QgdG8gNWsgLWZpeCBEUCBMVCBzZXF1
ZW5jZSBvbiBFUSBmYWlsIC1CdWcgZml4ZXMgZm9yIFMzL1M0DQoNCg0KQW50aG9ueSBLb28gKDEp
Og0KICBkcm0vYW1kL2Rpc3BsYXk6IFtGVyBQcm9tb3Rpb25dIFJlbGVhc2UgMC4wLjEwMy4wDQoN
CkFyaWMgQ3lyICgxKToNCiAgZHJtL2FtZC9kaXNwbGF5OiAzLjIuMTcyDQoNCkRteXRybyBMYWt0
eXVzaGtpbiAoMik6DQogIGRybS9hbWQvZGlzcGxheTogbGltaXQgdW5ib3VuZGVkIHJlcXVlc3Rp
bmcgdG8gNWsNCiAgZHJtL2FtZC9kaXNwbGF5OiBmaXggeWVsbG93IGNhcnAgd20gY2xhbXBpbmcN
Cg0KRXJpYyBCZXJuc3RlaW4gKDIpOg0KICBkcm0vYW1kL2Rpc3BsYXk6IEZpeCBmb3IgdmFyaWFi
bGUgbWF5IGJlIHVzZWQgdW5pbml0aWFsaXplZCBlcnJvcg0KICBkcm0vYW1kL2Rpc3BsYXk6IHJl
bW92ZSBzdGF0aWMgZnJvbSBvcHRjMzFfc2V0X2Rycg0KDQpHdW8sIEJpbmcgKDEpOg0KICBkYzog
ZG8gYmxvY2tlZCBNU1QgdG9wb2xvZ3kgZGlzY292ZXJ5IGF0IHJlc3VtZSBmcm9tIFMzL1M0DQoN
CklseWEgKDEpOg0KICBkcm0vYW1kL2Rpc3BsYXk6IEZpeCBEUCBMVCBzZXF1ZW5jZSBvbiBFUSBm
YWlsDQoNCk1hcnRpbiBUc2FpICgxKToNCiAgZHJtL2FtZC9kaXNwbGF5OiBoYW5kbGUgbnVsbCBs
aW5rIGVuY29kZXINCg0KTmljaG9sYXMgS2F6bGF1c2thcyAoMSk6DQogIGRybS9hbWQvZGlzcGxh
eTogRml4IHN0cmVhbS0+bGlua19lbmMgdW5hc3NpZ25lZCBkdXJpbmcgc3RyZWFtIHJlbW92YWwN
Cg0KT2xpdmVyIExvZ3VzaCAoMik6DQogIGRybS9hbWQvZGlzcGxheTogQmFzaWMgc3VwcG9ydCB3
aXRoIGRldmljZSBJRA0KICBTV0RFVi0zMjE3NTggLSBkYzogQ29kZSBjbGVhbg0KDQpQYXVsIEhz
aWVoICgxKToNCiAgZHJtL2FtZC9kaXNwbGF5OiBjaGFuZ2UgZmFzdGJvb3QgdGltaW5nIHZhbGlk
YXRpb24NCg0KWmhhbiBMaXUgKDEpOg0KICBkcm0vYW1kL2Rpc3BsYXk6IGtlZXAgZURQIFZkZCBv
biB3aGVuIGVEUCBzdHJlYW0gaXMgYWxyZWFkeSBlbmFibGVkDQoNCiAuLi4vZ3B1L2RybS9hbWQv
ZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgfCAyNCArKysrKysrLSAgLi4uL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5oIHwgIDIgKy0gIC4uLi9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2RjL2Nsa19tZ3IvY2xrX21nci5jICB8ICAyICstDQogZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2RjL2NvcmUvZGMuYyAgICAgIHwgIDIgKy0NCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rLmMgfCAyNyArKy0tLS0tLSAgLi4uL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rX2RwLmMgIHwgIDQgKy0gIC4uLi9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2RjL2NvcmUvZGNfcmVzb3VyY2UuYyB8ICA4ICstLQ0KIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9kYy9kYy5oICAgICAgICAgICB8ICA0ICstDQogZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2RjL2RjX2xpbmsuaCAgICAgIHwgIDEgKw0KIC4uLi9kaXNwbGF5L2RjL2Rj
ZTExMC9kY2UxMTBfaHdfc2VxdWVuY2VyLmMgICB8IDI3ICsrKysrKystDQogLi4uL2RybS9hbWQv
ZGlzcGxheS9kYy9kY24yMC9kY24yMF9yZXNvdXJjZS5jIHwgMTEgKy0tLQ0KIC4uLi9kcm0vYW1k
L2Rpc3BsYXkvZGMvZGNuMzEvZGNuMzFfaHViYnViLmMgICB8IDYxICsrKysrKysrKystLS0tLS0t
LS0NCiAuLi4vZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24zMS9kY24zMV9vcHRjLmMgfCAgMiAr
LSAgLi4uL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMzEvZGNuMzFfb3B0Yy5oIHwgIDIgKyAg
Li4uL2RybS9hbWQvZGlzcGxheS9kYy9kY24zMS9kY24zMV9yZXNvdXJjZS5jIHwgIDMgKy0NCiAu
Li4vZ3B1L2RybS9hbWQvZGlzcGxheS9kbXViL2luYy9kbXViX2NtZC5oICAgfCAgNCArLQ0KIC4u
Li9ncHUvZHJtL2FtZC9kaXNwbGF5L2luY2x1ZGUvZGFsX2FzaWNfaWQuaCB8ICAzICstDQogMTcg
ZmlsZXMgY2hhbmdlZCwgMTA0IGluc2VydGlvbnMoKyksIDgzIGRlbGV0aW9ucygtKQ0KDQotLQ0K
Mi4yNS4xDQo=
