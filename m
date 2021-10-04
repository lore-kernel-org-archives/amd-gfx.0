Return-Path: <SRS0=otPk=OY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23161C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 18:45:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA05361409
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 18:45:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DA05361409
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CDEC6EA99;
	Mon,  4 Oct 2021 18:45:06 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2070.outbound.protection.outlook.com [40.107.95.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A444B6EA99
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Oct 2021 18:45:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6SZGttPQlNkG9rhGAqNa5KgoLD6EN8d6CuyMFZpDw1/KXBzHetogVmUb/ZCJzkRtVjT+8yPYe2HL/lAF2/ZLq/ehCvo19dbPmSYYJxbnkjTPB1c9mBircoHe0KlpiJPLddprf1+0X32kl/fsfcOhHOtN15s/7j5xvoYUEIuUBptWog56YFAnuZ8674rsAjs688eyv994zJKQuNV+G2jfpiOFPyfOhFtOD6Ktb9UAGhWzBpzim5JtVBR/PJ6YjxVq70xZtloy7BoJKlFmjndAQ1UNQENqyC3kKD5E1jPfS3tuYNFKCHtTYjPdnSARPh90oGge+WcqdSSoovNEYKTiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ozli2eEM4MQi+q4MQBmv+ngVYdgIbU4EAbikqOvbulM=;
 b=Wmil6ngTCqx3KQIQ3391hevE2ArDkcjN+/rT4jmzmAg8jcNlDatfAxU4sQhtFaBzlItM8a7DNUwUexLqsfuZ/3PRbif7h/fa8Q7Bv+dgwDdrUdkqmoP5t/QzczABhrj9YE3hNb/qDdHMa14jcB9WiXpu6cidBtmesleKE3Us2PMLsnTGd2Qrzz+ZeqPUY8Ku5bC6TTNPyCJcJ6mzpeVfkONtGWtB7hzWBJOa1i1So/YTLC1lxHirdBi5RxbcGKR88c0tm8wfHSxsLpDGVg1ErmFVWfVuAsE34QxLdvtYESiJ9lrT7NGCyidDUOWKaY+fDs/g+BrtrqnMuOcyu/Y6wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ozli2eEM4MQi+q4MQBmv+ngVYdgIbU4EAbikqOvbulM=;
 b=DSKzIM7tDZBf9WMXN6z0MMrUIwpTKKaveDQHf5Q3Qs7R9UCoYE+nNglDPVK6Ty+dVozQ07qbvYTfApx7h9lw0QYPUek3S68XNrcHeydKaz7MeRy/ojfHri9GqFt6rXkL/a87wJj0EFJZqSqNqGYmSOogIFDG9c+WPhYqBR6ce0I=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB5564.namprd12.prod.outlook.com (2603:10b6:610:65::24)
 by CH0PR12MB5347.namprd12.prod.outlook.com (2603:10b6:610:d6::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Mon, 4 Oct
 2021 18:45:02 +0000
Received: from CH2PR12MB5564.namprd12.prod.outlook.com
 ([fe80::7988:8b2a:5575:4510]) by CH2PR12MB5564.namprd12.prod.outlook.com
 ([fe80::7988:8b2a:5575:4510%4]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 18:45:02 +0000
Date: Mon, 4 Oct 2021 14:44:59 -0400
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu/amdgpu_smu: Fix IP version checking in
 smu_set_funcs()
Message-ID: <20211004184459.pmplkviaycfaem6a@outlook.office365.com>
References: <20211004182220.2385965-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004182220.2385965-1-alexander.deucher@amd.com>
X-ClientProxiedBy: BN6PR11CA0019.namprd11.prod.outlook.com
 (2603:10b6:405:2::29) To CH2PR12MB5564.namprd12.prod.outlook.com
 (2603:10b6:610:65::24)
MIME-Version: 1.0
Received: from outlook.office365.com (2607:fea8:56e0:6d60:566:7ada:f470:5877)
 by BN6PR11CA0019.namprd11.prod.outlook.com (2603:10b6:405:2::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Mon, 4 Oct 2021 18:45:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 608be63a-9f0e-41e7-e08c-08d987671341
X-MS-TrafficTypeDiagnostic: CH0PR12MB5347:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB53479226A3580D76D34C5E5298AE9@CH0PR12MB5347.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jsPBlPvA0fmuBntdKxeEnAhg7+aPGuHF2H2T35tNou5G7C0+0YUtHF1/n8sZGo7aHwKQZXdngMVCLDBjOt/1CLmmB+B7L1CFakzaig2DJRFxB+ZqRL8GswQA0KLgfpe4EgBmi4TurYd/kS+JENR1WI0zaHDjhqNCVEN4aQcK98HYWexfkFRkUewi+qyjKy6KxknLfUvrXCxSB2UlYCMiibtdymVv0afpQHfuKG0d/Juc7aMY0uGPJ4GRrGqKwmR/SkHk9BWQF+G2XFXu9hbIbLjWWDpwpN8D2vd0T1VkC+Hn/KWd7XmjCpyKatM3mM0JmbhFkm62ZnPK2Z9H+FM/miVhZ5jzgdmt8py5cstry4mvvfvurFXG1TMRo7qvOSgbOqvK+p5xfcQPIqHPDt91gaj0jEU09TcZ/qFWuR/QhS6UdgmrjDacDbiAV0XduLdazKQIfPkRJMaDuGYXv9v630AxbE2ygLRcDahD242NxTi3qNXhRWv68WTp3xQp10IR+UAJHNZqAq85hFXpbEU+gjdu/G3gpFCZxySq3HHDHGUsXGDsmvU8z0I7FlCgeiCTiz0X8owq3MaVHhhkoGSpuz9qP3lb5F622J+YajC4rkF/JC2R4IQkuAXh1SOl7Eg1Np0pzrrG4s3MMVh9ftSnNPwUpjw2EqcbEpP8aPpXObQmx/6EUKkdB74SZaa03sFxJZvwD+A59BewR95u7wQpZICD9MWuPmsqMc0npIUVhEg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB5564.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(84040400005)(8676002)(6862004)(316002)(38100700002)(8936002)(4326008)(4744005)(5660300002)(55016002)(52116002)(66476007)(66556008)(7696005)(1076003)(186003)(86362001)(6666004)(508600001)(6506007)(9686003)(6636002)(966005)(66946007)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+M3xYNSggeP3tdPv/fWyD7u1i00ZNfO5ykFNDdBDP+9a2sa5od7KXBT333pX?=
 =?us-ascii?Q?a0UEWhzC8B1Z9PoYp8qF2NORx+F9ELtl/LpfEODcWtrnLQNddc+YKBTbz1DX?=
 =?us-ascii?Q?CuhSst4uQUzdT0BpQeKH4fVsxDWXJHNX1cVhpinNqjN03nGgXQKFg11e50yu?=
 =?us-ascii?Q?Lf6x60NLD6ceP9z9ZIgYAtyjLNYY/OV2ZrYxedPKCog6x33KJHGEdr/u389x?=
 =?us-ascii?Q?HvJkJTxZ2IWM9xhq7bIK08dPx9ifDaBtbjaR9mEGFYh4cLgN1Na+2REdgy03?=
 =?us-ascii?Q?cSJnK4osZM50u4R8dIHmWdVXxjvlegji8jDtN/aXKcF9/KQ64FImSbHoXXgE?=
 =?us-ascii?Q?DUtntsKeX4Lczcdq0U6NBMz2Gtkz79ykUIqL2YFunY3gO0Nknx2Ig0YY0Htu?=
 =?us-ascii?Q?Rw7h/i7cJyFhGlg3zKG//GwVentwqsUqypIHtttN2/cotKz7LJ+n7Z/u748A?=
 =?us-ascii?Q?1Fi/WI2uit29S3QnURI7or+w2HHgFZ3FgjdmP2NPFLKQmY3Wo6fdCFwLkfpU?=
 =?us-ascii?Q?VmSywmhweS58tGJCDO9GwXBXmu/EWxc1Wfy25miyMZTtBStpSBZeiT9wlnB5?=
 =?us-ascii?Q?oIfI84D8BLNYinb5wy7JrfyPCzCUZYqlZYIcBoxn7WiUjytvEzjhSF2gt83s?=
 =?us-ascii?Q?jofOSUuB8adu0l+mjgBGVTgWdRGoTMxGRP/NOeoIFOTxqFicULhqXQz1jZ6I?=
 =?us-ascii?Q?QtqVYEfg9QUiEIQH5N46Ji6Z8gohvSA3O8CaNk+DqQOM6LqEIVwfJ8u4Foy5?=
 =?us-ascii?Q?x7CQICnjcIgg9M7F9C1unDBTVNci23o9hNSrm6HOd5lwecfg5u9rB+IccCrH?=
 =?us-ascii?Q?9TaDAzokfKLED7xPoNFnwS+F8wwaRmwuVtWm1HhEvjS1yX+tRiqkupNr7qf3?=
 =?us-ascii?Q?7F5bKajbwqMEtTTeOtj+uA8DPWyuX5/oiNArtFL1sZMDSdbABL5vgTYJwYKd?=
 =?us-ascii?Q?d4XrUtJNfxEaOmF2ZQG6UMqSfDUFDqQUdm2II/c87/RC4Lw59R4KQib2HQb9?=
 =?us-ascii?Q?9XF0/ImIreSOprBJB8JWq6oIYdeLwo9Znve2wItPz56ZHYapkZucmliFfgyU?=
 =?us-ascii?Q?CnIMP4wsQqNFGhV8vjcx7f7BtMtaGMIJ+tK4VVR3uJmJOmmQPMReIN/2CZJ1?=
 =?us-ascii?Q?VUPS9JMJ8v+f/xacqkrl4vDMVY5tx6ZJ+Q3+W5Mu1eCdfvWJTzETi3hbnk6z?=
 =?us-ascii?Q?eZHsQ/swCoOk6Pc2wz2nTWcs41sNG36+teireEd8i6aHLrh7y5eJ4EvPfmiF?=
 =?us-ascii?Q?pJMV5E9Rfx4KXseKUT6od1yXKo9yB8ap3c0lB5soUSqmF7ybL4v3Gqq6EPYo?=
 =?us-ascii?Q?xcmvGtOw3gp75/WH7fMO76zzAZgvjDStt40dBQcbFgp5ODaNfA8jsIgKikVB?=
 =?us-ascii?Q?HdlPzUnMwfADnQZ5qSbWGH07aqRo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 608be63a-9f0e-41e7-e08c-08d987671341
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB5564.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 18:45:02.6530 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rD2X2EMW3Zfd2FlujBiOlVv617QnH95i+ebDAvElZh7cThg3vjDRSzEyrj4OUI5JXAnAJCl09Q+z7x3Otlz09w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5347
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

On 10/04, Alex Deucher wrote:
> Was missing the IP version check for green sardine.
> 
> Fixes: db95b2bd598d1a ("drm/amdgpu/amdgpu_smu: convert to IP version checking")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index b633f202b466..4ea7e90ef60d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -588,6 +588,7 @@ static int smu_set_funcs(struct amdgpu_device *adev)
>  		sienna_cichlid_set_ppt_funcs(smu);
>  		break;
>  	case IP_VERSION(12, 0, 0):
> +	case IP_VERSION(12, 0, 1):
>  		renoir_set_ppt_funcs(smu);
>  		break;
>  	case IP_VERSION(11, 5, 0):
> -- 
> 2.31.1
>

Tested-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com> 

-- 
Rodrigo Siqueira
https://siqueira.tech
