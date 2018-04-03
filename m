From: zhoucm1 <zhoucm1@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Fix PCIe lane width calculation
Date: Tue, 3 Apr 2018 10:46:12 +0800
Message-ID: <b464fcce-aa05-ea33-b7f1-85a9ffb8c5bb@amd.com>
References: <20180402173246.19143-1-alexander.deucher@amd.com>
 <20180402173246.19143-2-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180402173246.19143-2-alexander.deucher@amd.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Acked-by: Chunming Zhou <david1.zhou@amd.com> for series.


On 2018年04月03日 01:32, Alex Deucher wrote:
> The calculation of the lane widths via ATOM_PPLIB_PCIE_LINK_WIDTH_MASK and
> ATOM_PPLIB_PCIE_LINK_WIDTH_SHIFT macros did not increment the resulting
> value, per the comment in pptable.h ("lanes - 1"), and per usage elsewhere.
> Port of the radeon fix to amdgpu.
>
> Bug: https://bugs.freedesktop.org/show_bug.cgi?id=102553
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: stable@vger.kernel.org
> ---
>   drivers/gpu/drm/amd/amdgpu/si_dpm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/si_dpm.c b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
> index 6253b272c944..b12d7c9d42a0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si_dpm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
> @@ -6372,9 +6372,9 @@ static void si_set_pcie_lane_width_in_smc(struct amdgpu_device *adev,
>   {
>   	u32 lane_width;
>   	u32 new_lane_width =
> -		(amdgpu_new_state->caps & ATOM_PPLIB_PCIE_LINK_WIDTH_MASK) >> ATOM_PPLIB_PCIE_LINK_WIDTH_SHIFT;
> +		((amdgpu_new_state->caps & ATOM_PPLIB_PCIE_LINK_WIDTH_MASK) >> ATOM_PPLIB_PCIE_LINK_WIDTH_SHIFT) + 1;
>   	u32 current_lane_width =
> -		(amdgpu_current_state->caps & ATOM_PPLIB_PCIE_LINK_WIDTH_MASK) >> ATOM_PPLIB_PCIE_LINK_WIDTH_SHIFT;
> +		((amdgpu_current_state->caps & ATOM_PPLIB_PCIE_LINK_WIDTH_MASK) >> ATOM_PPLIB_PCIE_LINK_WIDTH_SHIFT) + 1;
>   
>   	if (new_lane_width != current_lane_width) {
>   		amdgpu_set_pcie_lanes(adev, new_lane_width);
