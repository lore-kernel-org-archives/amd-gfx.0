Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD52C5AE59
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jun 2025 21:53:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CD5D10E0DB;
	Tue,  3 Jun 2025 21:53:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sLq83wIf";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5F5310E0DB
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jun 2025 21:53:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dANyLyilmF56ovjO9ToWawtmTklPIZgJ4sJOkR78Mhfez98jsdu4QaVbpmfSHWZ5N8lfL4Rs5af49aJ1xYY+JAhMYCkyELepwENZHQAq1TxC4VBUr4rER6EvZHutty2IVgHQkH2nA03ahTfWNMK84CVQtO+pCAPUDc3Yn/oTbqyR7sXKJ0PQTR0DN9CeAgDBltCzglgzJHmD81aEoNGuAst108zg7oGg0WuEzqyRSVV2qrDtjVN9AwfkZwNyWETl6pv1nX7UJ76q/V+oMkiM8wgqfoBphgDTGlmzvNw12+euJB18L1zXEM1jSOM4KcQV4OK/mBwEN3+cMSxrylAGUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yt8es1XCXRaoTR1XhlWwJ8jamXZ5Hgh2zunsqX8EKhs=;
 b=j/Ox4XTqHZ/hFmPaHw1benkMz6VeToNJ4gvME3aTtX5jX4+5KRoSRWpXruoeznlmMe/ybmBUyadje2AOqt1rMyIWYNwLy2GiTmEzRxLu9w6ETte40ey51kS103+P+xqOv8tQKxJnvcJCYsasttIPdp8wSiy9pOPO04jQs4NNYlp2XFayHlaWGLrY6sSVCz+z7u9ADGklrRAIt9p9bp9A3L1XZrrp8L6MN5Sf+lO7qhHA5LELOiC3hi+uspviUhiS27n4r1ZH4gfp3lWkmrN+vuAeBK/qpWGfr3mLOuR9eyhSuNge7hV0zWvKUBRIiZJXPoKaruYT+HXlR1Io1bqYJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yt8es1XCXRaoTR1XhlWwJ8jamXZ5Hgh2zunsqX8EKhs=;
 b=sLq83wIf+eSNLBd49jrVVvmSi4L26V3hptt4P9YFCYB9juNXc//MBbdK2eaLWQ11IoJW+PVRus2UemHxT2IVbmngTq7X7bOPvGiuVJR6GZW4WfePxP8Orsg5Cf4IbLGdAIRFpjUXw1H9KsDpRKLlgo8CJxJ0f9asEAJZlu1AxGk=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by PH7PR12MB6539.namprd12.prod.outlook.com (2603:10b6:510:1f0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 21:52:56 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%6]) with mapi id 15.20.8769.031; Tue, 3 Jun 2025
 21:52:54 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Joshi, Mukul"
 <Mukul.Joshi@amd.com>
Subject: RE: [PATCH] drm/amdkfd: fix mes based process evictions
Thread-Topic: [PATCH] drm/amdkfd: fix mes based process evictions
Thread-Index: AQHb1KS4XUVnUZftPkq2YPKZ2cAy/rPx8eQAgAAHfZA=
Date: Tue, 3 Jun 2025 21:52:54 +0000
Message-ID: <CY8PR12MB743580E8BF4A0D8CA4061848856DA@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20250603162934.154349-1-jonathan.kim@amd.com>
 <CY8PR12MB7099B08A13F18F0E620123B38C6DA@CY8PR12MB7099.namprd12.prod.outlook.com>
In-Reply-To: <CY8PR12MB7099B08A13F18F0E620123B38C6DA@CY8PR12MB7099.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=5d511c5a-f9c5-47a9-88e5-131e2d391373;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-06-03T21:16:58Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|PH7PR12MB6539:EE_
x-ms-office365-filtering-correlation-id: 79f3286f-7897-43b6-90a3-08dda2e8fee3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?na6MBCqNIHl4q3UJyeh9MK/hpLrs6g4JmjUvzV/ZAreaAW4TT7IRucasoNt4?=
 =?us-ascii?Q?sSWQecdX8auT+JMiEggv9q/2/fSGDNauPMyXXwhGW/t+5geOl5KCI68FAJHA?=
 =?us-ascii?Q?4q7vz8+MmapafbpAS+fqCWAH4RccBZVBxJtZK6BRSDwtlaf8IMzVLq+3zvKj?=
 =?us-ascii?Q?V/M/9fNGExfwePUdaQH0CJSJMUqp+3g1lw34pXacpEzjmKFIzTYhjJG23/T6?=
 =?us-ascii?Q?I04ZaFoTwZQMsKEyUtYCCoIn7kEZ5CBNX31SupRAx9VEbrokpUFxbK9lnGvv?=
 =?us-ascii?Q?Oau7u1bGKFxXk0sq/4ubmSr/R31VlJJebUjvrTHNPjFdtA1kablCVmvlApOb?=
 =?us-ascii?Q?7iAi5Zc4JCOCzgAUaSr09ZhzvOhpM54vqqX2Bt92/TIdAr6mQ0qETeAHl3+K?=
 =?us-ascii?Q?4Mqd0nWDWZGwlJIBOqZAV999Vy93en36wjvI+3kEihE4gIXUriUmHPZw+BUN?=
 =?us-ascii?Q?oWGUhNBTbQJ5ypWoUOL0eAsF0A/xiJpC6KsXmd6j0Xqsz60IA2gB5HL2WTB6?=
 =?us-ascii?Q?hdf16UXjQQzUFod+9cZBpIuiCdr2CMO1hVfxhTxhN2FfWB8GwXdQJ08JUpDA?=
 =?us-ascii?Q?JxzqOiBc183jO1SKdyTICR0uEyQ35baGOzBSI+O1HdeBvdKeKT+03LKhnnFI?=
 =?us-ascii?Q?l5slclDG2vnFK2XHGs/jjyRmqapuu5bM0LfH2AZRnyRDCNo1YdGbaxDdUvyu?=
 =?us-ascii?Q?0TTlKkDws97MNWjxY0VweD8GoixRN1ZEudc3bk2V+29d2EgQmw8H05l4PQ26?=
 =?us-ascii?Q?YyoXi7LrGNeq3QpBEU1bwK/lY1h36VgPGhaCfk9AUA5xb5gmHg0A3WmhQMCv?=
 =?us-ascii?Q?BHhJkgBCgdhWSCmqzHqei3/d8lJPa2InCpzIqJ5jGFYyxO0nEburruW1xMzk?=
 =?us-ascii?Q?1xitgPCETEcr16J9pC3C34IM5W3V0offaX/ITkCwB85GcpLW8XxsYicUwexX?=
 =?us-ascii?Q?fnKUq5tjg1IgX4HSD0F26kTIRB2SBVWfXPqCWfsR93V1D8913LDvCl/VlwN1?=
 =?us-ascii?Q?HKfn/6AiwOmo1y7FTx39o77Ar+0aRRgAY2zNhnFdkNkaLErkZCwD9Foe5StW?=
 =?us-ascii?Q?JiIdTWQ2ie3/IFyr5hPRxZS4w4aTwuKL6qjVXrKvHP5Wgybdo/VVKJ39RVgC?=
 =?us-ascii?Q?kwEVUVkqFfE0OXiwM97+/Pmuc1fcFnguJ5B5Jc2NFmLZA+OTl8OWFB5dvpsa?=
 =?us-ascii?Q?l9Ek7q1p65AlV7UsWp5pmUjXAR66kmm0MXjVhgToLKmH3NIrVYkwmZMGApm5?=
 =?us-ascii?Q?vn7gJ8VpzL1Y8dTQEElaC2vTlMQ1jV8XLAj+O/imMadVGIetSGFze3INRgpR?=
 =?us-ascii?Q?Mhy2NGQbmdSAeLKysp8AR/zKIFgqf04LHkH5KMUGFsP1h+saTvX8sZ8tCKNQ?=
 =?us-ascii?Q?XgmF826zc7MoGUqmbCpK8Q7yltwh/Y3niKnQmjn+8woJQN3IBxxEk8fhpIyd?=
 =?us-ascii?Q?vnDT6SBOcJnSl8PLnlhxtvVIUh0N5gukMJomTg4ju+QiFMDvZwQMcWW0BC5s?=
 =?us-ascii?Q?Znztc2wZzcIclcU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZD8zAZvVpln4M13Gm6pg6xLPH5DhOXmeQN+voVuvj0QaC7WdMypcx5Ms9fZZ?=
 =?us-ascii?Q?G5ydTuxInuUapwgMCE/D1nbk1s97KMmcvTwVklwJB6t+ohsV4PXBvx+V2Qvc?=
 =?us-ascii?Q?nqkedP8qYyKwmy8Q5P85GtBqdcjiDXw6i5qnUC5opp7sFSAwFZymzd/0pm5f?=
 =?us-ascii?Q?zjQoP7owNno7depFLeogIDIIU99z4gADtgzyNYnlGT2fdHf27AVxwpSPeEEf?=
 =?us-ascii?Q?B4F5+Q6wFqoKBt7iBQ2n/ptXFsgX9hdDGmbLbXeEmX0svtVP4ou/qswmoQMO?=
 =?us-ascii?Q?MBUllyucvJXklRmj5PJ7JIrOmJoOVmTSBjTUWJGRXUiEfPoBmBq6gspuOY1O?=
 =?us-ascii?Q?mACYwzf5LN+jYXLZ5unCqSLeZF6gj+Vmni0rtMQnTMv6AMFHe5xBqH3bPm4d?=
 =?us-ascii?Q?UEKNb21cEAMYXCw3jdivJiRJK12wJzSvWxzO57+R2S8m06qW1KlyLX17iKXF?=
 =?us-ascii?Q?SrSfj2S3q3r55Ea4UNCKWerK4OQhDK5RIIhPTVtKAGjUUqbdj5A1Z/08aJ6o?=
 =?us-ascii?Q?lDxn7RcF3uu8C5aGJqIcpQXFNmxQPkV+yWb7d3NujUBk651wVOmJ6+p8hSaw?=
 =?us-ascii?Q?rnY70SrpyeOtk+ed4GA2b22Gf3lODPf/fk+Rru9cQ0P4kLrFM3dZc1yRVqye?=
 =?us-ascii?Q?YAFqSnfaytyoRB7ZIfbbhYIBZnKE0IoHqqhJQY2ZneDPBZ4ePhEMXB/bpyAz?=
 =?us-ascii?Q?SUOFG0oDm6AnvcVTgkQTpYRHa0rM7RRx+RzLRnwZFQgtLqgS4sqS6I+crJrw?=
 =?us-ascii?Q?n3I3rROYOHXEd2FYJD8WE6HgU+CEOjuBanV04t2QC7z3ENDNrXYWz+KdOCsR?=
 =?us-ascii?Q?WnkcGoaBYaQGN/P6AGt0qYvM1z077pix/XoCekt8d5S0a3y2Enu9Bjlymj8J?=
 =?us-ascii?Q?pp28QXQa2r3/2ceXz+dKb2IrmBMsTRqd2X3XwdNTdS3MIbSfSjUWPjJNljd3?=
 =?us-ascii?Q?fJ+mZGGUo/+Zy1JDfHx3a8IwBoahYaklAr/UkLnzUh8yRC/LKVA1cwo6s+N0?=
 =?us-ascii?Q?YtVpp6las1v+MWPpJXtJLbAIzgtJnyPpGXfwU5hvKfAspqVOFM/CqUkPoUHc?=
 =?us-ascii?Q?7C0HtYxwRcQdhMlrUK1qvSEYj/HP6V6Z2TUWmVRdrimZRn+0Yw2P9aQLZEpD?=
 =?us-ascii?Q?puFh0qZqyl6Inpz4/RyNOdVqA/Ot2HkgX/uQjBghY2tkJvI7x8Bi4tpRnzlO?=
 =?us-ascii?Q?HVCAj05RfznBuJajjbaAinnoD2/0zWNjLCIOeGmzJAQzm5WalZKgZQVYRER2?=
 =?us-ascii?Q?HLo3v2GhYODiIO8tdA56GUioneA86tuXhZ0NFMc5QglV7yYq5QdeAUKKr9Q2?=
 =?us-ascii?Q?Ux0ijU0FWVSLUW47ysxZqztreqfB7/iBLH06j2+AqzErAF4qGPx9BtVzBp06?=
 =?us-ascii?Q?CxAJXPYo9P3r41gjrCn8vUhiKSOg6U5OdZ0zig4AYZvZe/viw9a1L7LHytuN?=
 =?us-ascii?Q?n+Ua3NTmpyU2PRgAUu7qoNfVxlz1A6YBIeV4RQChS9FSd/Cz0PO19A/dKkqa?=
 =?us-ascii?Q?i6GJxd49h/W0fNDwg9xppHUkNWy/HY3dpiaMa3iDuVAmnN9FL78TSJUW23iv?=
 =?us-ascii?Q?GBrDuFtBppelluH/wIY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79f3286f-7897-43b6-90a3-08dda2e8fee3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 21:52:54.8688 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RbXjUeWIqR/qpr8qjJnzJsVJ3H9t1XswrE5E44XpzVJ0K2kZfSuk8e8DRH/Kq8dn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6539
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

[Public]

> -----Original Message-----
> From: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
> Sent: Tuesday, June 3, 2025 5:22 PM
> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Joshi, Mukul
> <Mukul.Joshi@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>
> Subject: RE: [PATCH] drm/amdkfd: fix mes based process evictions
>
> [Public]
>
> So, the code now loops two times over the list of queues. Couple of quest=
ions.
>
> (1) Isn't it possible to call suspend_all_queues_mes(dqm) before the firs=
t
> list_for_each_entry()? The first loop only does some housekeeping. That w=
ay you
> can still do get away with single loop.

Yeah I guess there's no harm in grabbing the last eviction time stamp prior=
 to house keeping + queue removal instead of just raw queue removal.

> (2) Also remove_queue_mes() is called for inactive queues (q->properties.=
is_active).
> Is that intentional?

No. That was a lazy copy and paste mistake.  Good catch.

Jon

>
> Best Regards,
> Harish
>
>
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jonath=
an
> Kim
> Sent: Tuesday, June 3, 2025 12:30 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Joshi, Mukul
> <Mukul.Joshi@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>
> Subject: [PATCH] drm/amdkfd: fix mes based process evictions
>
> First, MES suspend/resume calls should be consistently held under the
> KFD device lock (similar to queue invalidation) so consolidate
> MES based eviction logic with F32 HWS based eviction logic.
>
> Second, save the last eviction timestamp prior to current eviction to
> align with F32 HWS timestamp logging behaviour.
>
> Finally, bail early on failure to remove a single queue as something
> has gone really wrong post-suspend and a GPU reset is going to occur
> anyway so it's more efficient to just release the device lock.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 73 +++++--------------
>  1 file changed, 20 insertions(+), 53 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 76359c6a3f3a..c1f0207eeb9e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1219,25 +1219,36 @@ static int evict_process_queues_cpsch(struct
> device_queue_manager *dqm,
>
>                 q->properties.is_active =3D false;
>                 decrement_queue_count(dqm, qpd, q);
> +       }
>
> -               if (dqm->dev->kfd->shared_resources.enable_mes) {
> -                       int err;
> +       pdd->last_evict_timestamp =3D get_jiffies_64();
> +
> +       if (dqm->dev->kfd->shared_resources.enable_mes) {
> +               retval =3D suspend_all_queues_mes(dqm);
> +               if (retval) {
> +                       dev_err(dev, "Suspending all queues failed");
> +                       goto out;
> +               }
>
> -                       err =3D remove_queue_mes(dqm, q, qpd);
> -                       if (err) {
> +               list_for_each_entry(q, &qpd->queues_list, list) {
> +                       retval =3D remove_queue_mes(dqm, q, qpd);
> +                       if (retval) {
>                                 dev_err(dev, "Failed to evict queue %d\n"=
,
>                                         q->properties.queue_id);
> -                               retval =3D err;
> +                               goto out;
>                         }
>                 }
> -       }
> -       pdd->last_evict_timestamp =3D get_jiffies_64();
> -       if (!dqm->dev->kfd->shared_resources.enable_mes)
> +
> +               retval =3D resume_all_queues_mes(dqm);
> +               if (retval)
> +                       dev_err(dev, "Resuming all queues failed");
> +       } else {
>                 retval =3D execute_queues_cpsch(dqm,
>                                               qpd->is_debug ?
>                                               KFD_UNMAP_QUEUES_FILTER_ALL=
_QUEUES :
>
> KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0,
>                                               USE_DEFAULT_GRACE_PERIOD);
> +       }
>
>  out:
>         dqm_unlock(dqm);
> @@ -3089,61 +3100,17 @@ int kfd_dqm_suspend_bad_queue_mes(struct
> kfd_node *knode, u32 pasid, u32 doorbel
>         return ret;
>  }
>
> -static int kfd_dqm_evict_pasid_mes(struct device_queue_manager *dqm,
> -                                  struct qcm_process_device *qpd)
> -{
> -       struct device *dev =3D dqm->dev->adev->dev;
> -       int ret =3D 0;
> -
> -       /* Check if process is already evicted */
> -       dqm_lock(dqm);
> -       if (qpd->evicted) {
> -               /* Increment the evicted count to make sure the
> -                * process stays evicted before its terminated.
> -                */
> -               qpd->evicted++;
> -               dqm_unlock(dqm);
> -               goto out;
> -       }
> -       dqm_unlock(dqm);
> -
> -       ret =3D suspend_all_queues_mes(dqm);
> -       if (ret) {
> -               dev_err(dev, "Suspending all queues failed");
> -               goto out;
> -       }
> -
> -       ret =3D dqm->ops.evict_process_queues(dqm, qpd);
> -       if (ret) {
> -               dev_err(dev, "Evicting process queues failed");
> -               goto out;
> -       }
> -
> -       ret =3D resume_all_queues_mes(dqm);
> -       if (ret)
> -               dev_err(dev, "Resuming all queues failed");
> -
> -out:
> -       return ret;
> -}
> -
>  int kfd_evict_process_device(struct kfd_process_device *pdd)
>  {
>         struct device_queue_manager *dqm;
>         struct kfd_process *p;
> -       int ret =3D 0;
>
>         p =3D pdd->process;
>         dqm =3D pdd->dev->dqm;
>
>         WARN(debug_evictions, "Evicting pid %d", p->lead_thread->pid);
>
> -       if (dqm->dev->kfd->shared_resources.enable_mes)
> -               ret =3D kfd_dqm_evict_pasid_mes(dqm, &pdd->qpd);
> -       else
> -               ret =3D dqm->ops.evict_process_queues(dqm, &pdd->qpd);
> -
> -       return ret;
> +       return dqm->ops.evict_process_queues(dqm, &pdd->qpd);
>  }
>
>  int reserve_debug_trap_vmid(struct device_queue_manager *dqm,
> --
> 2.34.1
>

