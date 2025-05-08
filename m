Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DFCEC3ABC0
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 04:07:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E434710E0B7;
	Thu,  8 May 2025 04:07:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NDBlm/9l";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79C6E10E0B7
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 04:07:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L31U1go+LB37e9UKe70WhB0NW8geeOWRvORttn7CERKxBErBw9v/07zkYAY3hc9E9Gvt0SuYg2DW7uQcANtxo6nFEx/TTbXYX1M5cZvCXPwjHaoC3WPwonEaDLjudqeu8VP0Vn4rUPTeDMphmJUPWPU/Nc38RSn5JGwDCD4VAz3XCGjemP6c9q7v1OzvujNKMS4OREHz50j8Iq+DHfggtQxAeS32N/TjcJAULxeBM3Yc9jEk1zNchY9RA64ceip5kJ1beorxNgljjiVs2IPD3w20fqCmIiV22rIQMQ0+Grf4oU5BCAQSWt2Z67TAnMrUPD34orcYM8vH1zED4WzmNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Sq+MfDvKqP/J/dadW30ow6KKM4vY+kNmZborru6LOs=;
 b=U6ekJb5lJIscGo8o11rQdp2JDvZp0Y1xI5ryB1S2bjE0lPyRuVulHJO885RyQcl+iH2kdyLY0gtX36bXuhBXNvzg+n9Pd+ZL+PyhC+pVh5S1JVPQ0bAUweX+1oI26HlhpkTY99ws4CwB0d8F0I/2wy5o+1vXpgbYS9baBL18amPhZqDSXzkI+HlE0WA+FAuq1MDYdR+cfeGt4XM9DPtVAHj35cidtwRVYH6wX27cBgP5FtBaJksqESQ79TxODRt6OYdSuy6qTDyj8JXpDtr4Euz3qAvd2btFEfYRyLSYV8wIGlR7ADJ5hXIdPcVXQPEVnW6LoI39239syDdKpaqfwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Sq+MfDvKqP/J/dadW30ow6KKM4vY+kNmZborru6LOs=;
 b=NDBlm/9lCxatixCeDxLEWgggGUPfdXd1UsVmeMior3HSsTDml84F82BxzOepDEE4SyuMGKh+UNJJjr58JAqoyTgSpvRHeaNBrjb27njEfAMOG0isbhSvtmbIJcyXJY8fmUx0xs1okivh6qt0EZYgUf/jhu7BcFT/Nps6QSe4A9k=
Received: from DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) by
 MN2PR12MB4110.namprd12.prod.outlook.com (2603:10b6:208:1dd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Thu, 8 May
 2025 04:07:13 +0000
Received: from DM4PR12MB5937.namprd12.prod.outlook.com
 ([fe80::c847:70c6:3c78:54ba]) by DM4PR12MB5937.namprd12.prod.outlook.com
 ([fe80::c847:70c6:3c78:54ba%7]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 04:07:13 +0000
From: "Zhang, GuoQing (Sam)" <GuoQing.Zhang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>, "Zhang, GuoQing (Sam)" <GuoQing.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhao, Victor" <Victor.Zhao@amd.com>, "Chang, HaiJun"
 <HaiJun.Chang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhang, Owen(SRDC)" <Owen.Zhang2@amd.com>, "Ma, Qing (Mark)"
 <Qing.Ma@amd.com>, Jiang Liu <gerry@linux.alibaba.com>
Subject: Re: [PATCH v3 1/7] drm/amdgpu: update XGMI physical node id and GMC
 configs on resume
Thread-Topic: [PATCH v3 1/7] drm/amdgpu: update XGMI physical node id and GMC
 configs on resume
Thread-Index: AQHbvmqSdeRyBSujaUqqoycQD1crPbPFfriAgAEQVKaAAGKegIAAEM2AgAAV6QCAAI3LAP//e+4AgAF9cQA=
Date: Thu, 8 May 2025 04:06:54 +0000
Message-ID: <e5d68a3e-598e-4d33-ab1b-a3f47acaeab2@amd.com>
References: <20250506093629.249792-1-guoqing.zhang@amd.com>
 <354d063e-ba67-469f-a945-d8c6467f6c11@amd.com>
 <DM4PR12MB59371DC0E9B611C568CE395CE588A@DM4PR12MB5937.namprd12.prod.outlook.com>
 <5a80dd63-3dab-4117-afd1-b25a2a8d1725@amd.com>
 <13a13f7a-2a6a-42f8-8a06-ebf892bf06f6@amd.com>
 <6b2ede19-a7be-48f0-8098-63e05dd62691@amd.com>
 <343bba9a-d21d-448b-925b-f7af8237250b@amd.com>
 <a8772fbf-98e3-456c-8fb8-f8aa4ea6a5dd@amd.com>
In-Reply-To: <a8772fbf-98e3-456c-8fb8-f8aa4ea6a5dd@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: DM4PR12MB5937.namprd12.prod.outlook.com
 (15.20.8722.017)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5937:EE_|MN2PR12MB4110:EE_
x-ms-office365-filtering-correlation-id: 812ecb50-d353-45f1-3965-08dd8de5cfe1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|8096899003; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?jwm5mGRjjQRxfTSc6T4fTIvWnSQBRDkynTUpkV8vbFOoPdL4K0Pvmphkxs?=
 =?iso-8859-1?Q?rwZR58ZlvWD5PjpRG6NlugYECaaRC+CbGi1S0Mrn6FSuDr13q9unNo4uJE?=
 =?iso-8859-1?Q?4ARAcJqDyf1NoH4eTzBq9jYDmNfBWXgc6ybmmQ2GkXLrFgdf4kiQT4ZvON?=
 =?iso-8859-1?Q?/vZzR8KJMI7MTvPK3t9TTOkcorZHDGw7Em4KuLsSiQT6ZG6zt/k4leZ5fs?=
 =?iso-8859-1?Q?Dk+hZ08DEr6rAnsuY4E3757zPg3Kwt1He9sk7L0/EvabX0m20fzA+Gl+9u?=
 =?iso-8859-1?Q?C86/oNRZf+zEmaLKqn1WRsyv/+Wv/6uU3Y7XCotAsrYGSGYNeLY8kSRwPZ?=
 =?iso-8859-1?Q?/IFFrjxSqEO/zc3Ps8N1FWzqLLm9aWE6BjBj1oNVdPJP+L6UdZSdpgdHdG?=
 =?iso-8859-1?Q?70OyFrg3mPeyzvy4fZEojm+z0V6EoVngHqMHVMFB/0OJhmwwRLAZpFBLkk?=
 =?iso-8859-1?Q?46MUD+g+mAgkg1ov1pUf4rwTWhynGActe+tYTqEjm2eBCl62J2lBqnFPpX?=
 =?iso-8859-1?Q?/ha0Zc55SuEhQCWgLK5Edd9CyX1Zs+Im1O4rs3ydwkeFWLn3v8O7j1hwVq?=
 =?iso-8859-1?Q?IoQupEwk/DNftslDsQUrZnLuF3Ma5jUGeWYl5YmnYYCrzIfawNSmNVzltb?=
 =?iso-8859-1?Q?xW/wMjw5OrsZay3kGjfuuvf8LkbYbmb5JAnoVK1U8Nu5Qpr3SuhAOgwkS5?=
 =?iso-8859-1?Q?0yPbnlZcYSnvexzAwd+dbDtwCJXqRHU22A0HiX+GJqiAfw9L9/qPcl7v6e?=
 =?iso-8859-1?Q?izlhkeNeWvdI13gV0JdDE6mqb2TxN6XkjHVIOSMfvwlWqPnrCvxJDHhyM3?=
 =?iso-8859-1?Q?Gy5F0FstjbqxlmmlRWjfmhPFWUVVXq07vtChlOpkKqkZBfzE2ALnP8hsgD?=
 =?iso-8859-1?Q?H+1QwEEBVKq9Ws6mG1ZpGaUTFmIT/siVbmBbaeICXydjs/C7JivnN/TgRG?=
 =?iso-8859-1?Q?cVlX+Js0MiRKFb2QUIoLVMRiWD3IO2/pMP9AEd6QYOmNJPmuso04bEdkrJ?=
 =?iso-8859-1?Q?iHyUTLrRO/5g+K+e5SjT1yVZov3Hw5J0i4N/Cw2HCQKDxYGdA25HYP4XVm?=
 =?iso-8859-1?Q?Esuhe+t2yOz1rC1CoChumYGIukmjhZPoGCzvdcH+9nOYQiCf41uSySvBk1?=
 =?iso-8859-1?Q?1GT2Mj195Q78j4EI6VjY1Tmou3/P638UtLH4N6zYp/cRt0Pzddp85VZG1J?=
 =?iso-8859-1?Q?JJiIyF9ft2OSz/xTabDpnAPpB/qUs0BQLSy7vhJTYlDJAI9zJqUdgqL+rW?=
 =?iso-8859-1?Q?Ty6/23J4JwWP2PIYYUkFMKTe7tsBqcXwTZR2zzcjsVa53m2AaXtgPt3Bob?=
 =?iso-8859-1?Q?6cYTXaWZ0IB0/Wn1c0VmNFdX9JWlB+emu2Lv4wqwKhsZDK6Ak0OEbSoRNW?=
 =?iso-8859-1?Q?eNOengHFDtI2eoIBKlbkm6ZD4/pkcLCKP0Ct0vLDtwdREkcZjhFRjKFxXN?=
 =?iso-8859-1?Q?EsmKV2rQQYr9ibb2YumgIlUnmvkzPj/Ppar3DoAKP3ucu9HW4hP3K0pBOe?=
 =?iso-8859-1?Q?G9iRG9Tf2SA9krvyQPCG1AKUdZwsr++toPu/vK21npPA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5937.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(8096899003); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SzRz9MOqvSTvrgGz7vV5y0zr7nA7a33500a1jLR091RRudZVhL7J7nBFdd?=
 =?iso-8859-1?Q?JJx2SBdlHGt3jzjCh8h+w04hqeMWJowZ8FXPdJBuBxs9toTFEfcVPrlPDq?=
 =?iso-8859-1?Q?tCqnHp3vMcVEVhdhlvJaZcSzau/DSPlbUMWyClIwLSQ9tv8lS+xEpVwMVi?=
 =?iso-8859-1?Q?lfnWGQbeQJFuWsuV7h4TmZweYKuefYYQpxlyNOBmrkvnabGlWKlKl0v4K7?=
 =?iso-8859-1?Q?eVUiKYVudyz/oC+Gq2dj6ZfT3BYICb2OsjM+tc27V0KPv1H811O5ayxp8i?=
 =?iso-8859-1?Q?xFDjtcJkircuuiYfnFi+24ZqcxFYrUNM7EqUqH+IlxPXUnXr1b4dgu9ilY?=
 =?iso-8859-1?Q?YW0wEMcWRQDjOoabyADR0NC590ThbGSLdyYO9qYj5MyE9UC9LWCfM7XHHp?=
 =?iso-8859-1?Q?HwxE94Rzg+dUrQtJD+W/NZUJDLSzLPdTrk5OWCHMtX0INT1eXQvPBnNmT+?=
 =?iso-8859-1?Q?zD4WKRSgPT2zOqHA6hKvvgA8pA0OIw5bHwxE+5yyzBL/NPbmxtgCcumiUN?=
 =?iso-8859-1?Q?/Dbk0X2hsujQtr1oHfydRNeGwc2JLpzr6Ob2fS8StqHxkzbUOABDdTXGAI?=
 =?iso-8859-1?Q?Svt3rY9N4bq0N0RkX5soko3Cqs8ENt+2XsZjFVEC2lRrjKznbzsxBRGi0U?=
 =?iso-8859-1?Q?uB0Q6KP0CZMUQnPqCd+bauGv6OJc4oL3to+WGxue1sBGWHLLkvMeXrOQgQ?=
 =?iso-8859-1?Q?sPyYllI64eDcjjQQ0pATonkM1MyWcoNiS7e4wxKDCHDTZWQecvYpynOxR3?=
 =?iso-8859-1?Q?jhT36CPC3M+PuNnJNCysP/2wi+tlTyLkPprdDSeIUsmElbT6i12xnrOXeE?=
 =?iso-8859-1?Q?QwJmF/OzO6ommDgDY0tWlMqjf2dQGGexjlPoGDxSzgluiA2/AOzeKuwxOU?=
 =?iso-8859-1?Q?L7JHf+xamuEqbnaqtgziXpOSfj0OAOI/lxKEY23rOn8zK/E9WhEzX7TP9L?=
 =?iso-8859-1?Q?vTyJuURwtFok3GvZhT1OR7O/iIANHZaL7SuTS5FOtkzby9BMIQJhCDNFi3?=
 =?iso-8859-1?Q?8DXK7D8wVVOncdTf1dSC6oKAipt9wc3MQVGLHIHGJ/cYsNYQeZlbCxPu6q?=
 =?iso-8859-1?Q?wxLuF464gRn8jf2F2zHduaTTEoNROqBMIYtgjm4dAl/w9DnaiKL7nyFkfX?=
 =?iso-8859-1?Q?6JRpRCLMAaBhqgcqG1KuWFROhIFJQDkHAiCdKjdpJhU8Sc1G+za58XvUTB?=
 =?iso-8859-1?Q?IRBO9NctNm8gBB89OviyT9PwchLyMEIjj9K1y4/JVA9qshrSZ59S2WyZBM?=
 =?iso-8859-1?Q?74a+IPrPAOQXAuHa0OyAcCPsRAREhhibYWlJvZqB6M7YJKbgS7knIRjNUA?=
 =?iso-8859-1?Q?GSON31j+uPUHhTNtIoANb0mZ4MV+zo9u8DHaP3guKIjIe4R55j5zdm3K+y?=
 =?iso-8859-1?Q?dDfUHfohOI5rNQjw8F1F13ZoaiAvTDMFoiGxyUJJKfQXXA12LCISExvF8b?=
 =?iso-8859-1?Q?CkgEQxTimaC39tMaox6syu9POQGZ6A67ZEjz3wSQMAym6OTANNyXgPtWZj?=
 =?iso-8859-1?Q?lpwaerjTJYftg1BaFEgLM2eI4KSSN4bv+UI4vGompDG9qgx1cjz2tqqjYi?=
 =?iso-8859-1?Q?Wjzha/H3euwfCfqFxqMbYbu3iHHFlaeLF8wVQUFJwz25wgqggvyuNeCiZf?=
 =?iso-8859-1?Q?dOUib9Me6bLsw=3D?=
Content-Type: multipart/alternative;
 boundary="_000_e5d68a3e598e4d33ab1ba3f47acaeab2amdcom_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5937.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 812ecb50-d353-45f1-3965-08dd8de5cfe1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 04:07:13.0526 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K7kb9b4yqJep3K0pfeVrfCSIBlHrloZoHwk/IKjgblt09CEXEtI/U8nFI6geNG4xJmyjNOpnNas12Ti20IjrBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4110
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_e5d68a3e598e4d33ab1ba3f47acaeab2amdcom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


On 2025/5/7 20:56, Christian K=F6nig wrote:
> On 5/7/25 14:49, Sam wrote:
>> On 2025/5/7 20:21, Christian K=F6nig wrote:
>>> On 5/7/25 13:03, Sam wrote:
>>>> On 2025/5/7 18:03, Lazar, Lijo wrote:
>>>>> On 5/7/2025 11:52 AM, Zhang, GuoQing (Sam) wrote:
>>>>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>>>>
>>>>>>
>>>>>>
>>>>>>> Please keep in mind that this is not the only scenario addressed by=
 the
>>>>>>> driver - for ex: a resume sequence is executed after a device reset=
.
>>>>>>> This patch itself introduces unwanted sequences for other commonly =
used
>>>>>>> usecases. Please rework on the series without breaking existing use=
cases.
>>>>>>> Thanks,
>>>>>>> Lijo
>>>>>>    Hi @Lazar, Lijo<mailto:Lijo.Lazar@amd.com>, Thank you for the fee=
dback.
>>>>>>
>>>>>>    I also think the new code should be inside a check so that new co=
de is
>>>>>> executed only on resume with different VF and do not break existing
>>>>>> usecases. Following is the implementation of this approach I can thi=
nk of.
>>>>>>
>>>>>> - introduce new field `prev_physical_node_id ` in `struct amdgpu_xgm=
i `.
>>>>>> update the fields on resume.
>>>>>>
>>>>>> - put new code inside code block `if (prev_physical_node_id  !=3D
>>>>>> physical_node_id )`
>>>>>>
>>>>>>
>>>>> Can this happen only with XGMI under this condition? Any other method
>>>>> possible like preparing a 'unique signature' and matching it to ident=
ify
>>>>> if it resumed on an identically configured system?
>>>> Yes, this hibernate-resume with different VF feature is only for devic=
es with XGMI. Detecting XGMI node id change is the only way I can think of =
to identify the case. It's also a very simple way.
>>>>
>>>> @Koenig, Christian<mailto:Christian.Koenig@amd.com> Are you OK with th=
is approach, adding a check for the new code sequence?
>>> Well you still need to avoid calling gmc_v9_0_mc_init() since that is m=
ost likely incorrect.
>> Yes, I will change it to
>>
>>      if (amdgpu_xmgi_is_node_changed(adev))
>>          gmc_v9_0_vram_gtt_location(adev, &adev->gmc);
> Even that is incorrect. The VRAM and GTT location can't change on resume.
>
> What changes are the XGMI node ID and with it where inside the FB apertur=
e our VRAM PDB0 should point to.


2 updates in `gmc_v9_0_vram_gtt_location()` is needed:
1. `vm_manager.vram_base_offset` is changed with new `xgmi.physical_node_id=
` at the end of `gmc_v9_0_vram_gtt_location()`.
2. `fb_start` and `fb_end` got reset in `mmhub_v1_8_get_fb_location()`  cal=
led by the new `amdgpu_bo_fb_aper_addr()`. It needs to be updated again.

For update 1, I can inline it in `gmc_v9_0_resume()`.
For update 2, I can disable reset `fb_start/fb_end` in `mmhub_v1_8_get_fb_l=
ocation()` when pdb0 is enabled.
Is this OK? @Koenig, Christian <mailto:Christian.Koenig@amd.com>

Regards
Sam


> Regards,
> Christian.
>
>> And remove the change of `refresh`.
>>
>> Regards
>> Sam
>>
>>
>>> Regards,
>>> Christian.
>>>
>>>>> Regardless, instead of having a direct check, better to wrap it insid=
e
>>>>> something like
>>>>>       if (amdgpu_virt_need_migration()) or something more appropriate=
.
>>>> Yes, I will do that. Thank you!
>>>>
>>>> Regards
>>>> Sam
>>>>
>>>>>     Thanks,
>>>>> Lijo
>>>>>
>>>>>> Is this approach acceptable? If not, can you suggest a better approa=
ch?
>>>>>> @Lazar, Lijo<mailto:Lijo.Lazar@amd.com> @Koenig, Christian
>>>>>> <mailto:Christian.Koenig@amd.com> Thank you!
>>>>>>
>>>>>>    Regards
>>>>>>
>>>>>> Sam
>>>>>>
>>>>>>    *From: *Lazar, Lijo<Lijo.Lazar@amd.com>
>>>>>> *Date: *Tuesday, May 6, 2025 at 19:55
>>>>>> *To: *Zhang, GuoQing (Sam)<GuoQing.Zhang@amd.com>, amd-
>>>>>> gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>>>>>> *Cc: *Zhao, Victor<Victor.Zhao@amd.com>, Chang, HaiJun
>>>>>> <HaiJun.Chang@amd.com>, Koenig, Christian<Christian.Koenig@amd.com>,
>>>>>> Deucher, Alexander<Alexander.Deucher@amd.com>, Zhang, Owen(SRDC)
>>>>>> <Owen.Zhang2@amd.com>, Ma, Qing (Mark)<Qing.Ma@amd.com>, Jiang Liu
>>>>>> <gerry@linux.alibaba.com>
>>>>>> *Subject: *Re: [PATCH v3 1/7] drm/amdgpu: update XGMI physical node =
id
>>>>>> and GMC configs on resume
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 5/6/2025 3:06 PM, Samuel Zhang wrote:
>>>>>>> For virtual machine with vGPUs in SRIOV single device mode and XGMI
>>>>>>> is enabled, XGMI physical node ids may change when waking up from
>>>>>>> hiberation with different vGPU devices. So update XGMI physical nod=
e
>>>>>>> ids on resume.
>>>>>>>
>>>>>> Please keep in mind that this is not the only scenario addressed by =
the
>>>>>> driver - for ex: a resume sequence is executed after a device reset.
>>>>>> This patch itself introduces unwanted sequences for other commonly u=
sed
>>>>>> usecases. Please rework on the series without breaking existing usec=
ases.
>>>>>>
>>>>>> Thanks,
>>>>>> Lijo
>>>>>>
>>>>>>> Update GPU memory controller configuration on resume if XGMI physic=
al
>>>>>>> node ids are changed.
>>>>>>>
>>>>>>> Signed-off-by: Jiang Liu<gerry@linux.alibaba.com>
>>>>>>> Signed-off-by: Samuel Zhang<guoqing.zhang@amd.com>
>>>>>>> ---
>>>>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 24 ++++++++++++++=
++++++++
>>>>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  3 +--
>>>>>>>      drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  4 ++++
>>>>>>>      3 files changed, 29 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/g=
pu/
>>>>>> drm/amd/amdgpu/amdgpu_device.c
>>>>>>> index d477a901af84..e795af5067e5 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> @@ -5040,6 +5040,27 @@ int amdgpu_device_suspend(struct drm_device
>>>>>> *dev, bool notify_clients)
>>>>>>>            return 0;
>>>>>>>      }
>>>>>>>     +static int amdgpu_device_update_xgmi_info(struct amdgpu_device=
 *adev)
>>>>>>> +{
>>>>>>> +     int r;
>>>>>>> +     unsigned int prev_physical_node_id;
>>>>>>> +
>>>>>>> +     /* Get xgmi info again for sriov to detect device changes */
>>>>>>> +     if (amdgpu_sriov_vf(adev) &&
>>>>>>> +         !(adev->flags & AMD_IS_APU) &&
>>>>>>> +         adev->gmc.xgmi.supported &&
>>>>>>> +         !adev->gmc.xgmi.connected_to_cpu) {
>>>>>>> +             prev_physical_node_id =3D adev->gmc.xgmi.physical_nod=
e_id;
>>>>>>> +             r =3D adev->gfxhub.funcs->get_xgmi_info(adev);
>>>>>>> +             if (r)
>>>>>>> +                     return r;
>>>>>>> +
>>>>>>> +             dev_info(adev->dev, "xgmi node, old id %d, new id %d\=
n",
>>>>>>> +                     prev_physical_node_id, adev-
>>>>>>> gmc.xgmi.physical_node_id);
>>>>>>> +     }
>>>>>>> +     return 0;
>>>>>>> +}
>>>>>>> +
>>>>>>>      /**
>>>>>>>       * amdgpu_device_resume - initiate device resume
>>>>>>>       *
>>>>>>> @@ -5059,6 +5080,9 @@ int amdgpu_device_resume(struct drm_device *d=
ev,
>>>>>> bool notify_clients)
>>>>>>>                    r =3D amdgpu_virt_request_full_gpu(adev, true);
>>>>>>>                    if (r)
>>>>>>>                            return r;
>>>>>>> +             r =3D amdgpu_device_update_xgmi_info(adev);
>>>>>>> +             if (r)
>>>>>>> +                     return r;
>>>>>>>            }
>>>>>>>              if (dev->switch_power_state =3D=3D DRM_SWITCH_POWER_OF=
F)
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/
>>>>>> drm/amd/amdgpu/amdgpu_gmc.c
>>>>>>> index d1fa5e8e3937..a2abddf3c110 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>>>>>> @@ -1298,8 +1298,7 @@ int amdgpu_gmc_get_nps_memranges(struct
>>>>>> amdgpu_device *adev,
>>>>>>>            if (!mem_ranges || !exp_ranges)
>>>>>>>                    return -EINVAL;
>>>>>>>     -     refresh =3D (adev->init_lvl->level !=3D
>>>>>> AMDGPU_INIT_LEVEL_MINIMAL_XGMI) &&
>>>>>>> -               (adev->gmc.reset_flags & AMDGPU_GMC_INIT_RESET_NPS)=
;
>>>>>>> +     refresh =3D true;
>>>>>>>            ret =3D amdgpu_discovery_get_nps_info(adev, &nps_type, &=
ranges,
>>>>>>>                                                &range_cnt, refresh)=
;
>>>>>>>     diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gp=
u/drm/
>>>>>> amd/amdgpu/gmc_v9_0.c
>>>>>>> index 59385da80185..1eb451a3743b 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>>>>> @@ -2533,6 +2533,10 @@ static int gmc_v9_0_resume(struct
>>>>>> amdgpu_ip_block *ip_block)
>>>>>>>            struct amdgpu_device *adev =3D ip_block->adev;
>>>>>>>            int r;
>>>>>>>     +     r =3D gmc_v9_0_mc_init(adev);
>>>>>>> +     if (r)
>>>>>>> +             return r;
>>>>>>> +
>>>>>>>            /* If a reset is done for NPS mode switch, read the memo=
ry range
>>>>>>>             * information again.
>>>>>>>             */

--_000_e5d68a3e598e4d33ab1ba3f47acaeab2amdcom_
Content-Type: text/html; charset="iso-8859-1"
Content-ID: <7811DA2CA825A540952AE23DBC4EFE46@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"en-CN" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<div>
<p class=3D"MsoNormal"><br>
On 2025/5/7 20:56, Christian K=F6nig wrote:<br>
&gt; On 5/7/25 14:49, Sam wrote:<br>
&gt;&gt; On 2025/5/7 20:21, Christian K=F6nig wrote:<br>
&gt;&gt;&gt; On 5/7/25 13:03, Sam wrote:<br>
&gt;&gt;&gt;&gt; On 2025/5/7 18:03, Lazar, Lijo wrote:<br>
&gt;&gt;&gt;&gt;&gt; On 5/7/2025 11:52 AM, Zhang, GuoQing (Sam) wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt; [AMD Official Use Only - AMD Internal Distribution=
 Only]<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Please keep in mind that this is not the only =
scenario addressed by the<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; driver - for ex: a resume sequence is executed=
 after a device reset.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; This patch itself introduces unwanted sequence=
s for other commonly used<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; usecases. Please rework on the series without =
breaking existing usecases.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Thanks,<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Lijo<br>
&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; Hi @Lazar, Lijo&lt;<a href=3D"mailto:=
Lijo.Lazar@amd.com">mailto:Lijo.Lazar@amd.com</a>&gt;, Thank you for the fe=
edback.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; I also think the new code should be i=
nside a check so that new code is<br>
&gt;&gt;&gt;&gt;&gt;&gt; executed only on resume with different VF and do n=
ot break existing<br>
&gt;&gt;&gt;&gt;&gt;&gt; usecases. Following is the implementation of this =
approach I can think of.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; - introduce new field `prev_physical_node_id ` in =
`struct amdgpu_xgmi `.<br>
&gt;&gt;&gt;&gt;&gt;&gt; update the fields on resume.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; - put new code inside code block `if (prev_physica=
l_node_id &nbsp;!=3D<br>
&gt;&gt;&gt;&gt;&gt;&gt; physical_node_id )`<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Can this happen only with XGMI under this condition? A=
ny other method<br>
&gt;&gt;&gt;&gt;&gt; possible like preparing a 'unique signature' and match=
ing it to identify<br>
&gt;&gt;&gt;&gt;&gt; if it resumed on an identically configured system?<br>
&gt;&gt;&gt;&gt; Yes, this hibernate-resume with different VF feature is on=
ly for devices with XGMI. Detecting XGMI node id change is the only way I c=
an think of to identify the case. It's also a very simple way.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; @Koenig, Christian&lt;<a href=3D"mailto:Christian.Koenig@a=
md.com">mailto:Christian.Koenig@amd.com</a>&gt; Are you OK with this approa=
ch, adding a check for the new code sequence?<br>
&gt;&gt;&gt; Well you still need to avoid calling gmc_v9_0_mc_init() since =
that is most likely incorrect.<br>
&gt;&gt; Yes, I will change it to<br>
&gt;&gt;<br>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp; if (amdgpu_xmgi_is_node_changed(adev))<br=
>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gmc_v9_0_vram_gtt=
_location(adev, &amp;adev-&gt;gmc);<br>
&gt; Even that is incorrect. The VRAM and GTT location can't change on resu=
me.<br>
&gt;<br>
&gt; What changes are the XGMI node ID and with it where inside the FB aper=
ture our VRAM PDB0 should point to.<br>
<br>
<br>
2 updates in `gmc_v9_0_vram_gtt_location()` is needed:<br>
1. `vm_manager.vram_base_offset` is changed with new `xgmi.physical_node_id=
` at the end of `gmc_v9_0_vram_gtt_location()`.<br>
2. `fb_start` and `fb_end` got reset in `mmhub_v1_8_get_fb_location()` &nbs=
p;called by the new `amdgpu_bo_fb_aper_addr()`. It needs to be updated agai=
n.<br>
<br>
<o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">For update 1, I can inline it i=
n </span>`gmc_v9_0_resume()`<span lang=3D"EN-US">.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">For update 2, I can disable res=
et `fb_start/fb_end` in
</span>`mmhub_v1_8_get_fb_location()`<span lang=3D"EN-US"> when pdb0 is ena=
bled.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Is this OK?</span> @Koenig, Chr=
istian &lt;<a href=3D"mailto:Christian.Koenig@amd.com">mailto:Christian.Koe=
nig@amd.com</a>&gt;<br>
<br>
Regards<br>
Sam<br>
<br>
<br>
&gt; Regards,<br>
&gt; Christian.<br>
&gt;<br>
&gt;&gt; And remove the change of `refresh`.<br>
&gt;&gt;<br>
&gt;&gt; Regards<br>
&gt;&gt; Sam<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;&gt; Regards,<br>
&gt;&gt;&gt; Christian.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Regardless, instead of having a direct check, better t=
o wrap it inside<br>
&gt;&gt;&gt;&gt;&gt; something like<br>
&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (amdgpu_virt_ne=
ed_migration()) or something more appropriate.<br>
&gt;&gt;&gt;&gt; Yes, I will do that. Thank you!<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Regards<br>
&gt;&gt;&gt;&gt; Sam<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp;&nbsp; Thanks,<br>
&gt;&gt;&gt;&gt;&gt; Lijo<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Is this approach acceptable? If not, can you sugge=
st a better approach?<br>
&gt;&gt;&gt;&gt;&gt;&gt; @Lazar, Lijo&lt;<a href=3D"mailto:Lijo.Lazar@amd.c=
om">mailto:Lijo.Lazar@amd.com</a>&gt; @Koenig, Christian<br>
&gt;&gt;&gt;&gt;&gt;&gt; &lt;<a href=3D"mailto:Christian.Koenig@amd.com">ma=
ilto:Christian.Koenig@amd.com</a>&gt; Thank you!<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; Regards<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Sam<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; *From: *Lazar, Lijo&lt;Lijo.Lazar@amd=
.com&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; *Date: *Tuesday, May 6, 2025 at 19:55<br>
&gt;&gt;&gt;&gt;&gt;&gt; *To: *Zhang, GuoQing (Sam)&lt;GuoQing.Zhang@amd.co=
m&gt;, amd-<br>
&gt;&gt;&gt;&gt;&gt;&gt; gfx@lists.freedesktop.org &lt;amd-gfx@lists.freede=
sktop.org&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; *Cc: *Zhao, Victor&lt;Victor.Zhao@amd.com&gt;, Cha=
ng, HaiJun<br>
&gt;&gt;&gt;&gt;&gt;&gt; &lt;HaiJun.Chang@amd.com&gt;, Koenig, Christian&lt=
;Christian.Koenig@amd.com&gt;,<br>
&gt;&gt;&gt;&gt;&gt;&gt; Deucher, Alexander&lt;Alexander.Deucher@amd.com&gt=
;, Zhang, Owen(SRDC)<br>
&gt;&gt;&gt;&gt;&gt;&gt; &lt;Owen.Zhang2@amd.com&gt;, Ma, Qing (Mark)&lt;Qi=
ng.Ma@amd.com&gt;, Jiang Liu<br>
&gt;&gt;&gt;&gt;&gt;&gt; &lt;gerry@linux.alibaba.com&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; *Subject: *Re: [PATCH v3 1/7] drm/amdgpu: update X=
GMI physical node id<br>
&gt;&gt;&gt;&gt;&gt;&gt; and GMC configs on resume<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; On 5/6/2025 3:06 PM, Samuel Zhang wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; For virtual machine with vGPUs in SRIOV single=
 device mode and XGMI<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; is enabled, XGMI physical node ids may change =
when waking up from<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; hiberation with different vGPU devices. So upd=
ate XGMI physical node<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; ids on resume.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Please keep in mind that this is not the only scen=
ario addressed by the<br>
&gt;&gt;&gt;&gt;&gt;&gt; driver - for ex: a resume sequence is executed aft=
er a device reset.<br>
&gt;&gt;&gt;&gt;&gt;&gt; This patch itself introduces unwanted sequences fo=
r other commonly used<br>
&gt;&gt;&gt;&gt;&gt;&gt; usecases. Please rework on the series without brea=
king existing usecases.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Thanks,<br>
&gt;&gt;&gt;&gt;&gt;&gt; Lijo<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Update GPU memory controller configuration on =
resume if XGMI physical<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; node ids are changed.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Signed-off-by: Jiang Liu&lt;gerry@linux.alibab=
a.com&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Signed-off-by: Samuel Zhang&lt;guoqing.zhang@a=
md.com&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/a=
mdgpu/amdgpu_device.c | 24 ++++++++++++++++++++++<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/a=
mdgpu/amdgpu_gmc.c&nbsp;&nbsp;&nbsp; |&nbsp; 3 +--<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/a=
mdgpu/gmc_v9_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 4 ++++<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp; 3 files changed, 29 i=
nsertions(+), 2 deletions(-)<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu=
_device.c b/drivers/gpu/<br>
&gt;&gt;&gt;&gt;&gt;&gt; drm/amd/amdgpu/amdgpu_device.c<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; index d477a901af84..e795af5067e5 100644<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device=
.c<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device=
.c<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; @@ -5040,6 +5040,27 @@ int amdgpu_device_suspe=
nd(struct drm_device<br>
&gt;&gt;&gt;&gt;&gt;&gt; *dev, bool notify_clients)<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp;&nbsp; +static int amdgpu_device_u=
pdate_xgmi_info(struct amdgpu_device *adev)<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; unsigned int prev_ph=
ysical_node_id;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Get xgmi info aga=
in for sriov to detect device changes */<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(=
adev) &amp;&amp;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; !(adev-&gt;flags &amp; AMD_IS_APU) &amp;&amp;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;gmc.xgmi.supported &amp;&amp;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; !adev-&gt;gmc.xgmi.connected_to_cpu) {<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; prev_physical_node_id =3D adev-&gt;gmc.xgmi.phy=
sical_node_id;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D adev-&gt;gfxhub.funcs-&gt;get_xgmi_info(a=
dev);<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 return r;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;xgmi node, old id =
%d, new id %d\n&quot;,<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 prev_physical_node_id, adev-<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; gmc.xgmi.physical_node_id);<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp; /**<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; * amdgpu_device=
_resume - initiate device resume<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; *<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; @@ -5059,6 +5080,9 @@ int amdgpu_device_resume=
(struct drm_device *dev,<br>
&gt;&gt;&gt;&gt;&gt;&gt; bool notify_clients)<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu=
_virt_request_full_gpu(adev, true);<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_device_update_xgmi_info(adev);<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 return r;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (dev-&gt;switch_power_state =3D=3D DRM_SWITCH_POWE=
R_OFF)<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu=
_gmc.c b/drivers/gpu/<br>
&gt;&gt;&gt;&gt;&gt;&gt; drm/amd/amdgpu/amdgpu_gmc.c<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; index d1fa5e8e3937..a2abddf3c110 100644<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<=
br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<=
br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; @@ -1298,8 +1298,7 @@ int amdgpu_gmc_get_nps_m=
emranges(struct<br>
&gt;&gt;&gt;&gt;&gt;&gt; amdgpu_device *adev,<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (!mem_ranges || !exp_ranges)<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINV=
AL;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp; r=
efresh =3D (adev-&gt;init_lvl-&gt;level !=3D<br>
&gt;&gt;&gt;&gt;&gt;&gt; AMDGPU_INIT_LEVEL_MINIMAL_XGMI) &amp;&amp;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;gmc.reset_flags &amp; AMD=
GPU_GMC_INIT_RESET_NPS);<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; refresh =3D true;<br=
>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D amdgpu_discovery_get_nps_info(adev, &amp;nps_type, &=
amp;ranges,<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; &amp;range_cnt, refresh);<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp;&nbsp; diff --git a/drivers/gpu/dr=
m/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/<br>
&gt;&gt;&gt;&gt;&gt;&gt; amd/amdgpu/gmc_v9_0.c<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; index 59385da80185..1eb451a3743b 100644<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br=
>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br=
>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; @@ -2533,6 +2533,10 @@ static int gmc_v9_0_res=
ume(struct<br>
&gt;&gt;&gt;&gt;&gt;&gt; amdgpu_ip_block *ip_block)<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; struct amdgpu_device *adev =3D ip_block-&gt;adev;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; int r;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp; r=
 =3D gmc_v9_0_mc_init(adev);<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /* If a reset is done for NPS mode switch, read the memory r=
ange<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * information again.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; */<o:p></o:p></p>
</div>
</div>
</body>
</html>

--_000_e5d68a3e598e4d33ab1ba3f47acaeab2amdcom_--
